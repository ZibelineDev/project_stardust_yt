class_name Ach02StardustCreator
extends Achievement

var progress_value : int = 0
var goal : int = 100


func _init() -> void:
	name = "Ach02StardustCreator"
	completed = Game.ref.data.achievements.ach_02_stardust_creator_completed
	progress_value = Game.ref.data.achievements.ach_02_progress_value
	
	if not completed:
		HandlerStardust.ref.stardust_created.connect(_on_stardust_created)


## Returns the title of the achievement.
func title() -> String:
	return "Stardust Creator"


## Returns the description of the achievement.
func description() -> String:
	return "Create Stardust to advance this Achievement."


## Returns the progress of the achievement.
func progress() -> float:
	return progress_value


## Returns the progress goal of the achievement.
func progress_goal() -> float:
	return 100


func _on_stardust_created(quantity : int) -> void:
	progress_value += quantity
	
	if progress_value > goal:
		progress_value = goal
	
	Game.ref.data.achievements.ach_02_progress_value = progress_value
	
	if progress_value == goal:
		_on_goal_reached()
	
	achievement_progressed.emit()


func _on_goal_reached() -> void:
	completed = true
	Game.ref.data.achievements.ach_02_stardust_creator_completed = true
	
	HandlerStardust.ref.stardust_created.disconnect(_on_stardust_created)
	
	achievement_completed.emit()
