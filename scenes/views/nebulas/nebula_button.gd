class_name ButtonNebula
extends TextureButton

@export var vbox_container : VBoxContainer

@export var content : Node


func _on_v_box_container_resized() -> void:
	custom_minimum_size.y = vbox_container.size.y


func _on_pressed() -> void:
	content.visible = not content.visible
