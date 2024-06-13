class_name HandlerAchievements
extends Node

static var ref : HandlerAchievements

func _enter_tree() -> void:
	if ref:
		queue_free()
		return
	
	ref = self


var ach_01_universe_created : Ach01UniverseCreated
var ach_02_stardust_creator : Ach02StardustCreator


func _ready() -> void:
	_initialise_achievements()


func _initialise_achievements() -> void:
	ach_01_universe_created = Ach01UniverseCreated.new()
	add_child(ach_01_universe_created)
	
	ach_02_stardust_creator = Ach02StardustCreator.new()
	add_child(ach_02_stardust_creator)
