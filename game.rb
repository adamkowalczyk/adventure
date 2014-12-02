class Game
  
  @@permitted_commands = ["inv", "take", "look", "where", "go", "help", "sudo_help", "quit", "kill", "use", "fight" ]

  attr_accessor :player, :rooms
  
  def initialize(player, rooms = {}) 
    @player = Player.new(player)
    @rooms = Hash.new
    rooms.each do |type, name|
      if type == :normal
        rooms[:normal].map { |n| @rooms[n] = Room.new(n) }
      elsif type == :lock
        rooms[:lock].map { |n| @rooms[n] = LockRoom.new(n) }
      elsif type == :fight
        rooms[:fight].map { |n| @rooms[n] = FightRoom.new(n) }
      else
        exit(1)
      end
    end      
  end

  def run
    while self.player.alive
      print "> "
      input = $stdin.gets.chomp.downcase
      # use regex to take chars before space as command, and any after space as argument
      command = input.match(/\w+/).to_s
      # if user input is one word, argument == empty string
      argument = input.match(/\s\w+/).to_s.strip
      # check if player command exists as method and is on permitted list.
      # also to check if method takes arg, and pass one or not as appropriate
      # check both player and room classes for method.
      if argument.empty?
        if self.player.respond_to?(command) && @@permitted_commands.include?(command)
          command_call = self.player.method(command)
          if command_call.arity == 1 || command_call.arity == -1  # negative arity allows for optional arguments
            error("needs_target")
          elsif command_call.arity != 1 || command_call.arity != -1
            command_call.call
          else
            exit(1)
          end
        elsif self.player.location.respond_to?(command) && @@permitted_commands.include?(command)
          command_call = self.player.location.method(command)
          if command_call.arity == 1 || command_call.arity == -1  # negative arity allows for optional arguments
            error("needs_target")
          elsif command_call.arity != 1 || command_call.arity != -1
            command_call.call
          else
            exit(1)
          end  
        else
          error("input")
        end
      elsif !argument.empty?
        if self.player.respond_to?(command) && @@permitted_commands.include?(command)
          command_call = self.player.method(command)
          if command_call.arity == 1 || command_call.arity == -1
            command_call.call(argument)
          elsif command_call.arity != 1 || command_call.arity != -1
            error("no_target")
          else
            exit(1)
          end
        elsif self.player.location.respond_to?(command) && @@permitted_commands.include?(command)
          command_call = self.player.location.method(command)
          if command_call.arity == 1 || command_call.arity == -1
            command_call.call(argument)
          elsif command_call.arity != 1 || command_call.arity != -1
            error("no_target")
          else
            exit(1)
          end
        else
          error("input")
        end
      else
        exit(1)
      end
    end
  end
end