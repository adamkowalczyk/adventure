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

#GET PLAYER NAME
puts "Enter your name:"
print "> "
name = $stdin.gets.chomp.capitalize
$game = Game.new(name, {normal: ["room1"], lock: ["room2"], fight: ["room3", "room4"]} )


# ROOM OBJECTS
$game.rooms["room1"].description = "You see the dungeon entrance"
$game.rooms["room1"].room_name = "The Dungeon Entrance"
$game.rooms["room1"].objects = ["key","knife"]
$game.rooms["room1"].connections = {door: "room2"}

$game.rooms["room2"].description = "You are in a hallway with a locked gate ahead of you, a hatch in the floor and a door behind you.\nAvailable comands: USE (item)"
$game.rooms["room2"].objects = ["cat"]
$game.rooms["room2"].room_name = "The Hallway"
$game.rooms["room2"].connections = {door: "room1", hatch: "room4"}
$game.rooms["room2"].key = "key"
$game.rooms["room2"].lock = :gate
$game.rooms["room2"].destination = "room3"
$game.rooms["room2"].new_description = "You are in a hallway with an open gate ahead of you, a door behind you."

$game.rooms["room3"].description = "You find yourself dark room, with an angry Orc!\nAvailable comands: FIGHT"
$game.rooms["room3"].room_name = "The Orc's Lair"
$game.rooms["room3"].objects = []
$game.rooms["room3"].connections = {gate: "room2"}
$game.rooms["room3"].enemy = "orc"
$game.rooms["room3"].new_description = "The Orc lies dead at your feet."

$game.rooms["room4"].description = "You are confronted by a Kobold.\nAvailable commands: FIGHT"
$game.rooms["room4"].room_name = "The Kobold Room"
$game.rooms["room4"].objects = []
$game.rooms["room4"].connections = {hatch: "room2"}
$game.rooms["room4"].enemy = "kobold"
$game.rooms["room4"].new_description = "You look around carefully, but the Kobold is nowhere to be seen."

#set references to $game global variable
$game.player.game = $game
$game.player.location = $game.rooms["room1"]

puts "Welcome #{$game.player.name}. Type HELP for commands."
#RUN GAME METHOD
game
puts "YOU ARE DEAD" unless $game.player.alive 