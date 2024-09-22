Things Added:


Dash Mechanic - Player (WIP)

Chase State - Minibat
Wandering State - Minibat
AI state controller - MiniBat

Complex enemy pathfinding behaviors gotta give credit to ChatGPT xD



Probably the best enemy I have programmed yet! quite a complex behaviour i'd say with the pathfinding,  
AI state controller, and I made sure each state is well built. This enemy only has 3 states, chase, wandering state and laser state. 
The wandering state only moves in a navigation server region so it has boundaries it basically picks a random point within the bound. 
The chase state, I implemented a pathfinding system that could calculate the player positions while also knowing how to avoid obstacles although 
I programmed the AI controller to only switch to chase state when the player is within the area radius or else its too OP. 
The Laser state is only activated when the player is detected in that red triangle got the inspiration from my favourite childhood game Rayman Legends!
