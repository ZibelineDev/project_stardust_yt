class_name OfflineProgressionComponent
extends TextureButton


func _on_pressed() -> void:
	queue_free()


func set_generated_stardust_value(generated_stardust : int) -> void:
	var text : String = "%s stardusts were generated while you were offline." %generated_stardust
	
	(get_node("%Body") as Label).text = text
