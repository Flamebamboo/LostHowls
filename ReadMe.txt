Mon 16 Sep 

Audio System In Pause Menu 
New Art For Pause and Audio Menu with sliders 
master_slide.gd:
	This script is attached to Horizontal Slider. The algorithm retrieve the
	Audio Bus by index, then it access the Audio server it also converts the linear slider value to decibals

screen_gui.gd:
	this script is attached in the GUI control node it handles all the logic to open and close pause menu 
	along with audio volume control menu
	


Graphic Options In Pause Menu
New art for toggle buttons 

The graphic options follows the HCI principle of Aesthetic and Minimalist, And visibility of system status.

Users can toggle:
Particles
Glow
Lightings

need to do:
Show Fps Hud
Colorblind filter (if appplicable with using shaders and overlay), (if possible)



How did i implement Graphic options?

Emit a signal with the global script and retrieve with the nodes ezpz ( not rlly tbh ;-; )
I HAD TO REWROTE THE CODE SO MANY TIMES TO ACTUALLY ACCESS THE PARTICLES, LIGHTINGS, WORLD ENVIRONTMENT. 
Alright so the correct and best approach for this is to have the check_button emit a signal, and all the lights in the game connect to that signal and turn themselves off
