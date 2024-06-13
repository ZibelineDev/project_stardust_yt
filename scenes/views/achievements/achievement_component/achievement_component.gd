class_name CompoAchievement
extends Panel


var achievement : Achievement


func inject_achievement_data(_achievement : Achievement) -> void:
	achievement = _achievement
	(get_node("%Title") as Label).text = achievement.title()
	(get_node("%Description") as RichTextLabel).text = achievement.description()
	
	(get_node("%ProgressBar") as ProgressBar).max_value = achievement.progress_goal()
	(get_node("%ProgressBar") as ProgressBar).value = achievement.progress()
	
	if not achievement.completed:
		achievement.achievement_completed.connect(_on_achievement_completed)
		achievement.achievement_progressed.connect(_on_achievement_progressed)
	
	else:
		(get_node("%Veil") as ColorRect).visible = true


func _on_achievement_progressed() -> void:
	(get_node("%ProgressBar") as ProgressBar).value = achievement.progress()


func _on_achievement_completed() -> void:
	(get_node("%ProgressBar") as ProgressBar).value = achievement.progress()
	(get_node("%Veil") as ColorRect).visible = true
	
	achievement.achievement_completed.disconnect(_on_achievement_completed)
	achievement.achievement_progressed.disconnect(_on_achievement_progressed)
