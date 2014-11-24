class Player
  
  # review accessors
  attr_accessor :location, :name, :alive, :inventory, :game
  
  def initialize(name)
    @name = name
    @inventory = []
    @alive = true
    @location = nil
    @game = nil
  end
  
  def inv
    if @inventory.empty?
      puts "Your inventory is empty."
    else
      puts "You are carrying:"
      puts @inventory.sort.join(", ")
    end
  end

  def remove(obj)
    @inventory.delete(obj)
  end

  def take(obj)
    if @location.objects.include?(obj)
      puts "You take the #{obj}"
      @inventory << obj
      @location.remove(obj)
    else
      puts "I can't see that."
    end
  end

  def look
    puts "#{@location.description}"
    #puts "Things that are here:" unless @location.objects.empty? && @location.connections.empty?
    puts "Objects - #{@location.objects.sort.join(", ")}." unless @location.objects.empty?
    puts "Exits - #{@location.connections.keys.join(", ")}." unless @location.connections.empty?
  end
  
  # change to give meaningful names. change room names? or provide secondary descriptive name?
  def where
    puts "Location: #{@location.room_name}"
  end
  
  def go(input)
    exit = input.to_sym
    if @location.connections.include?(exit)
      destination = @location.connections[exit]
      @location = @game.rooms[destination]
      @location.player = self
      puts "#{@location.description}"
    else
      puts "You can't go that way."
    end
  end

  # emergency quit
  def kill
    @alive = false
  end

  def quit
    puts "Are you sure you want to quit?"
    print "(Y/N) > "
    ans = $stdin.gets.chomp.downcase
    puts "Thanks for playing!" ; exit(0) if ans.include?("y")
  end
  
  def help
    puts "---------------------------------------------------"
    puts "Possible commands are made up of either one or two words"
    puts "Commands are not case sensitive, but will be displayed in CAPS."
    puts "Some locations have their own commands..."
    puts ""
    puts '"HELP" - Displays this help screen.'
    puts '"LOOK" - Look at your current location, shows objects and exits.'
    puts '"WHERE" - Displays the name of your current location, in case you get lost!'
    puts '"INV" - Displays the contents of your inventory.'
    puts '"TAKE (OBJECT) - Takes an object and puts it in your inventory.'
    puts '"GO (EXIT) - Moves you to a new location.'
    puts '"QUIT" - Ends the game!'
    puts "---------------------------------------------------"
  end
  
  # are Object methods also exposed?
  def sudo_help
    puts "Exposed commands:"
    puts Player.instance_methods + @location.class.instance_methods - Object.methods
  end
end
