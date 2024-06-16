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
## Reference to the offline progression packed scene.
@export var scene_offline_progression : PackedScene

## Contains the data to save and load.
var data : Data


## Singleton check & Data initialization.
func _enter_tree() -> void:
	_singleton_check()
	data = Data.new()
	SaveSystem.load_data()


func _ready() -> void:
	_load_user_interface()
	
	_offline_progression()


## Triggered when the save timer completes a loop. Save the game.
func _on_save_timer_timeout() -> void:
	SaveSystem.save_data()


func _offline_progression() -> void:
	var offline_time : int = SaveSystem.offline_time()
	
	if offline_time <= 0:
		return
	
	var generated_stardust : int = HandlerStardustGenerator.ref.generator_power * offline_time
	HandlerStardust.ref.create_stardust(generated_stardust)
	
	var node : OfflineProgressionComponent = (
		scene_offline_progression.instantiate() as OfflineProgressionComponent)
	
	node.set_generated_stardust_value(generated_stardust)
	add_child(node)


func reload_user_interface() -> void:
	var old_interface : UserInterface = get_node("UserInterface")
	old_interface.name = "OldUserInterface"
	remove_child(old_interface)
	old_interface.queue_free()
	
	_load_user_interface()


func _load_user_interface() -> void:
	var node_user_interface : UserInterface = scene_user_interface.instantiate() as UserInterface
	node_user_interface.name = "UserInterface"
	add_child(node_user_interface)
