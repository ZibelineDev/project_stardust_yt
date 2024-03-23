class_name ViewNebulas
extends View
## View displaying & managing Nebulas.


## Area to add Nebula Components to.
@export var main_list : VBoxContainer
## References the scene of the Nebula Component.
@export var scene_nebula : PackedScene

## Reference the nebulas Handler.
@onready var handler : HandlerNebulas = HandlerNebulas.ref


## Initialize View settings.
func _ready() -> void:
	super()
	_generate_nebulas()
	handler.nebula_created.connect(_generate_newest_nebula)


## Asks the handler to create a new Nebula.
func _on_button_pressed() -> void:
	handler.create_nebula()


## Generate all nebulas from the handler.
func _generate_nebulas() -> void:
	if handler.nebulas.size() == 0:
		return
	
	for nebula : Nebula in handler.nebulas:
		var new_node : CompoNebula = scene_nebula.instantiate() as CompoNebula
		new_node.nebula = nebula
		main_list.add_child(new_node)


## Generate the newest node.
func _generate_newest_nebula() -> void:
	var table_size : int = handler.nebulas.size()
	
	var new_node : CompoNebula = scene_nebula.instantiate() as CompoNebula
	new_node.nebula = handler.nebulas[table_size -1]
	main_list.add_child(new_node)
