class_name Game
extends Node
## Main node of the game.

## Singleton reference.
static var ref : Game


## Singleton check.
func _singleton_check() -> void:
	if not ref:
		ref = self
		return
	
	queue_free()


## Reference to the user interface packed scene.
@export var scene_user_interface : PackedScene
## Reference to the offline popup packed scene.
@export var scene_offline_progression : PackedScene

## Contains the data to save and load.
var data : Data


## Singleton check & Data initialization.
func _enter_tree() -> void:
	_singleton_check()
	data = Data.new()
	SaveSystem.load_data()


func _ready() -> void:
	var node_user_interface : UserInterface = scene_user_interface.instantiate() as UserInterface
	add_child(node_user_interface)
	_offline_progression()


## Triggered when the save timer completes a loop. Save the game.
func _on_save_timer_timeout() -> void:
	data.save_time = int(Time.get_unix_time_from_system())
	SaveSystem.save_data()


func _offline_progression() -> void:
	if data.save_time <= 0:
		return
	
	var delta_time : int = 0
	var current_time : int = int(Time.get_unix_time_from_system())
	
	delta_time = current_time - data.save_time
	
	if delta_time <= 0:
		return
	
	var generated_stardust : int = HandlerStardustGenerator.ref.generator_power * delta_time
	
	HandlerStardust.ref.create_stardust(generated_stardust)
	
	var node : OfflineProgressionPopup = (
			scene_offline_progression.instantiate() as OfflineProgressionPopup)
	
	node.set_generated_stardust_value(generated_stardust)
	
	add_child(node)
