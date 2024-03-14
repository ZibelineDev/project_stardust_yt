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

## Packed Scene : User Interface.
@export var scene_user_interface : PackedScene

## Contains the data to save and load.
var data : Data


## Singleton check & Data initialization.
func _enter_tree() -> void:
	_singleton_check()
	data = Data.new()
	SaveSystem.load_data()


## Instantiates User Interface.
func _ready() -> void:
	var child : UserInterface = scene_user_interface.instantiate() as UserInterface
	add_child(child)


## Triggered when the save timer completes a loop. Save the game.
func _on_save_timer_timeout() -> void:
	SaveSystem.save_data()
