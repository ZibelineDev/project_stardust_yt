class_name OfflineProgressionPopup
extends Control

@export
var label : Label


func _on_pressed() -> void:
	queue_free()


func set_generated_stardust_value(generated_stardust : int) -> void:
	label.text = "You have generated %s stardust while offline." %generated_stardust
