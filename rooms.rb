class Room
  # review accessors
  attr_accessor :name, :description, :objects, :connections, :player
  
  def initialize(name)
    @name  = name
    @description = ""
    @objects = []
    @connections = {}
    @player = nil
  end
  
  def remove(obj)
    @objects.delete(obj)
  end
end

class LockRoom < Room
  
  attr_accessor :key, :lock, :destination, :new_description

  def initialize(name)
    @name  = name
    @description = ""
    @objects = []
    @connections = {}
    @player = nil
    @key = ""
    @lock = ""
    @destination = ""
    @new_description = ""
  end

  def use(item)
    if @player.inventory.include?(item)
      puts "You try the #{item}."
      if item == @key
        puts "It works!"
        puts "The #{@lock} unlocks."
        @connections.store(@lock, @destination)
        @player.remove(item)
        @description = @new_description unless @new_description.empty?
      else
        puts "Nothing happens."
      end
    else
      puts "You don't have that." 
    end
  end
end

class OrcRoom < Room
  def orc
    puts "You attack the orc and he kills you. Oops!"
    puts "Come back when I've finished the game."
    @player.kill
  end
end
