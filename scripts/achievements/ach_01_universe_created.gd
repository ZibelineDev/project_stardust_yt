class_name Ach01UniverseCreated
extends Achievement


func _init() -> void:
	name = "Ach01UniverseCreated"
	completed = Game.ref.data.achievements.ach_01_universe_created
	
	if not completed:
		HandlerCCUpgrades.ref.u_01_stardust_generation.leveled_up.connect(_on_universe_created)


func title() -> String:
	return "Universe Creator"


func description() -> String:
	return "Create your first Universe."


func progress() -> float:
	return float(completed)


func progress_goal() -> float:
	return 1


func _on_universe_created() -> void:
	completed = true
	Game.ref.data.achievements.ach_01_universe_created = true
	
	achievement_completed.emit()
	
	HandlerCCUpgrades.ref.u_01_stardust_generation.leveled_up.disconnect(_on_universe_created)
