# currently using player class intance methods as user commands.
# should probably use a case list instead in game method, but this is quite fun.
# TODO:
# more rooms!
# error method with randomised messages for different problems.
# methods with optional args? eg, "look" and "look key"

require_relative "player"
require_relative "rooms"
require_relative "game"
require_relative "error"

# $forbidden = ["location", "location=", "alive", "name", "remove", "player", "player=", "description", "description=", "objects", "objects=", "connections", "connections=" ]

#GET PLAYER NAME
puts "Enter your name:"
print "> "
name = $stdin.gets.chomp.capitalize
$game = Game.new(name, {normal: ["room1"], lock: ["room2"], orc: ["room3"]} )


# ROOM OBJECTS
$game.rooms["room1"].description = "You see the dungeon entrance"
$game.rooms["room1"].objects = ["key","knife"]
$game.rooms["room1"].connections = {door: "room2"}

$game.rooms["room2"].description = "You are in a hallway with a locked gate ahead of you, a door behind you.\nUSE (item)"
$game.rooms["room2"].objects = ["cat"]
$game.rooms["room2"].connections = {door: "room1"}
$game.rooms["room2"].key = "key"
$game.rooms["room2"].lock = :gate
$game.rooms["room2"].destination = "room3"
$game.rooms["room2"].new_description = "You are in a hallway with an open gate ahead of you, a door behind you."

$game.rooms["room3"].description = "You find yourself dark room. You see an angry ORC."
$game.rooms["room3"].objects = []
$game.rooms["room3"].connections = {gate: "room2"}

#set references to $game global variable
$game.player.game = $game
$game.player.location = $game.rooms["room1"]

puts "Welcome #{$game.player.name}. Type HELP for commands."
#RUN GAME METHOD
game
puts "YOU ARE DEAD" unless $game.player.alive 