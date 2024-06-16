class_name HandlerPrestige
extends Node

static var ref : HandlerPrestige

func _enter_tree() -> void:
	if ref:
		queue_free()
		return
	
	ref = self


signal prestige_triggered


func prestige() -> void:
	Game.ref.data.prestige_data()
	
	prestige_triggered.emit()
	
	Game.ref.reload_user_interface()
