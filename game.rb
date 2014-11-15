class Game
  
  attr_accessor :player, :rooms
  
  def initialize(player, rooms = {}) 
    @player = Player.new(player)
    @rooms = Hash.new
    rooms.each do |type, name|
      if type == :normal
        rooms[:normal].map { |n| @rooms[n] = Room.new(n) }
      elsif type == :lock
        rooms[:lock].map { |n| @rooms[n] = LockRoom.new(n) }
      elsif type == :orc
        rooms[:orc].map { |n| @rooms[n] = OrcRoom.new(n) }
      else
        exit(1)
      end
    end      
  end
end

$permitted_commands = ["inv", "take", "look", "where", "go", "help", "sudo_help", "quit", "kill", "use", "orc" ]

def game
  while $game.player.alive
    print "> "
    input = $stdin.gets.chomp.downcase
    # use regex to take chars before space as command, and any after space as argument
    verb = input.match(/\w+/).to_s
    # if user input is one word, noun == empty string
    noun = input.match(/\s\w+/).to_s.strip
    # check if player command exists as method and is on permitted list.
    # also to check if method takes arg, and pass one or not as appropriate
    # check both player and room classes for method.
    if noun.length == 0
      if $game.player.respond_to?(verb) && $permitted_commands.include?(verb)
        meth = $game.player.method(verb)
        if meth.arity == 1 || meth.arity == -1  # negative arity allows for optional arguments
          error("needs_target")
        elsif meth.arity != 1 || meth.arity == -1
          meth.call
        else
          exit(1)
        end
      elsif $game.player.location.respond_to?(verb) && $permitted_commands.include?(verb)
        meth = $game.player.location.method(verb)
        if meth.arity == 1 || meth.arity == -1  # negative arity allows for optional arguments
          error("needs_target")
        elsif meth.arity != 1 || meth.arity == -1
          meth.call
        else
          exit(1)
        end  
      else
        error("input")
      end
    elsif  noun.length > 0
      if $game.player.respond_to?(verb) && $permitted_commands.include?(verb)
        meth = $game.player.method(verb)
        if meth.arity == 1 || meth.arity == -1
          meth.call(noun)
        elsif meth.arity != 1 || meth.arity == -1
          error("no_target")
        else
          exit(1)
        end
      elsif $game.player.location.respond_to?(verb) && $permitted_commands.include?(verb)
        meth = $game.player.location.method(verb)
        if meth.arity == 1 || meth.arity == -1
          meth.call(noun)
        elsif meth.arity != 1 || meth.arity == -1
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