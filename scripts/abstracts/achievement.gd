class_name Achievement
extends Node

signal achievement_completed
signal achievement_progressed


var completed : bool


## Virtual class, must be overwritten.[br]
## Returns the title of the achievement.
func title() -> String:
	return "Title not defined"


## Virtual class, must be overwritten.[br]
## Returns the description of the achievement.
func description() -> String:
	return "Description not defined"


## Virtual class, must be overwritten.[br]
## Returns the progress of the achievement.
func progress() -> float:
	return -1


## Virtual class, must be overwritten.[br]
## Returns the progress goal of the achievement.
func progress_goal() -> float:
	return -1
