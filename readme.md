<h1>A Text Adventure!</h1>

<h2>Written for Exercise 36 of Learn Ruby The Hard Way.</h2>

This is a work in progress, and currently features little in the way of actual game play...
The engine is looking good though!

<h3>Background</h3>

Exercise 36 of Learn Ruby The Hard Way asks you to write a text adventure. The idea seems to be to use methods as 'rooms', allowing a more dynamic structure than a simple series of if-else trees.

I felt that I could come up with something a little more advanced, and wanted to at the very least use classes to instantiate the player and room objects.

Rather than make each prompt for input (or turn) unique and dependent on location, I decided to try and make a game with a set of general commands that can be used everywhere, such as 'look', 'go', 'take'. For fun and educational purposes I took the approach of passing the player input directly to the Player and Room classes as method calls, with and without arguments.

<h3>Features</h3>

<ul>
<li>A game method which parses user input as direct method calls</li>
<li>Universal commands</li>
<li>Player object with an inventory</li>
<li>Room objects with items and connections to other rooms</li>
<li>Location specific events</li>
</ul>

<h3>Instructions</h3>

Run "run.rb"

Read in game help with HELP command.

Keep an eye out for location specific commands displayed in CAPS.

Enjoy!

