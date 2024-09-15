Audio System In Pause Menu 
New Art For Pause and Audio Menu with sliders 
master_slide.gd:
	This script is attached to Horizontal Slider. The algorithm retrieve the
	Audio Bus by index, then it access the Audio server it also converts the linear slider value to decibals

screen_gui.gd:
	this script is attached in the GUI control node it handles all the logic to open and close pause menu 
	along with audio volume control menu
	
