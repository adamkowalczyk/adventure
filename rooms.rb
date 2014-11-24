class Room
  # review accessors
  attr_accessor :name, :room_name, :description, :objects, :connections, :player
  
  def initialize(name)
    @name  = name
    @room_name = ""
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
    @room_name = ""
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

class FightRoom < Room

  attr_accessor :enemy, :new_description
  
   def initialize(name)
    @name  = name
    @room_name = ""
    @description = ""
    @objects = []
    @connections = {}
    @player = nil
    @enemy = :""
    @new_description = ""
  end
  

  def fight
    send(@enemy,@name,@player.game)
  end
end

#ENEMIES
def orc(room,game)
  puts "You attack the Orc!"
  if game.player.inventory.include?("knife")
    puts "You stab the orc with your handy knife. He is an ex orc."
    puts "He drops a sandwich"
    game.rooms[room].description = game.rooms[room].new_description unless game.rooms[room].new_description.empty?
    game.rooms[room].objects << "sandwich"
  else
    puts "Oh dear, you punch the Orc to no effect and then he beheads you."
    game.player.kill
  end
end

def kobold(room,game)
  puts "You attack the Kobold!"
  puts "The Kobold suggests a game of rock, paper, scissors instead..."
  puts "Given the size of the Kobold's teeth, you decide to play along."
  victor = nil
  until victor
    print "R/P/S >"
    player_turn = $stdin.gets.chomp.downcase
    until player_turn[0] == "r" || player_turn[0] == "p" || player_turn[0] == "s"
      puts "Rock, paper or scissors!"
      player_turn = $stdin.gets.chomp.downcase
    end
    kobold_turn = ["r","p","s"].sample
    if kobold_turn == "r"
      kobold_turn_full = "rock"
    elsif kobold_turn == "p"
      kobold_turn_full = "paper"
    elsif kobold_turn == "s"
      kobold_turn_full = "scissors"
    else
      exit(1)
    end         
    puts "The Kobold chooses #{kobold_turn_full}."
    if player_turn == "r"
      if kobold_turn == "s"
        victor = "player"
      elsif kobold_turn == "p"
        victor = "kobold"
      elsif kobold_turn == "r"
        puts "A draw! Play again."        
      end
    elsif player_turn == "p"
      if kobold_turn == "r"
        victor = "player"
      elsif kobold_turn == "s"
        victor = "kobold"
      elsif kobold_turn == "p"
        puts "A draw! Play again."        
      end
    elsif player_turn == "s"
      if kobold_turn == "p"
        victor = "player"
      elsif kobold_turn == "r"
        victor = "kobold"
      elsif kobold_turn =="s"
        puts "A draw! Play again."        
      end            
    else
      exit(1)
    end
  end
  if victor == "player"
    puts "You win!"
    puts "The Kobold runs away!"
    game.rooms[room].description = game.rooms[room].new_description unless game.rooms[room].new_description.empty?
  elsif victor == "kobold"
    puts "The Kobold eats you with the smug air of a bad winner."
    game.player.kill
  else
    exit(1)
  end    
end