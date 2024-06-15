class_name Ach02StardustCreator
extends Achievement

const MAX_LEVEL : int = 3

var progress_value : int = 0
var goal_list : Array[int] = [100, 1000, 10000]
var level : int = 0


func _init() -> void:
	name = "Ach02StardustCreator"
	completed = Game.ref.data.achievements.ach_02_stardust_creator_completed
	progress_value = Game.ref.data.achievements.ach_02_progress_value
	level = Game.ref.data.achievements.ach_02_level
	
	if not completed:
		HandlerStardust.ref.stardust_created.connect(_on_stardust_created)


## Returns the title of the achievement.
func title() -> String:
	return "Stardust Creator %s" %level


## Returns the description of the achievement.
func description() -> String:
	return "Create Stardust to advance this Achievement."


## Returns the progress of the achievement.
func progress() -> float:
	if level >= MAX_LEVEL:
		return 100
	
	return progress_value * 100 / float(goal_list[level])


## Returns the progress goal of the achievement.
func progress_goal() -> float:
	return 100


func _on_stardust_created(quantity : int) -> void:
	progress_value += quantity
	
	if progress_value > goal_list[level]:
		progress_value = goal_list[level]
	
	Game.ref.data.achievements.ach_02_progress_value = progress_value
	
	if progress_value == goal_list[level]:
		_on_goal_reached()
	
	achievement_progressed.emit()


func _on_goal_reached() -> void:
	_level_up()
	
	if level >= MAX_LEVEL:
		_completion()


func _level_up() -> void:
	level += 1
	progress_value = 0
	
	Game.ref.data.achievements.ach_02_level = level
	Game.ref.data.achievements.ach_02_progress_value = 0
	
	achievement_leveled_up.emit()


func _completion() -> void:
	completed = true
	Game.ref.data.achievements.ach_02_stardust_creator_completed = true
	
	HandlerStardust.ref.stardust_created.disconnect(_on_stardust_created)
	
	achievement_completed.emit()
