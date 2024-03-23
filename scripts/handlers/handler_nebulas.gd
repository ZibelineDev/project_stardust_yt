class_name HandlerNebulas
extends Node
## Manages Nebulas.

## Singleton reference.
static var ref : HandlerNebulas


## Singleton check.
func _enter_tree() -> void:
	if not ref:
		ref = self
		return
	
	queue_free()


signal nebula_created

## Reference to the stardust consumption timer.
@export var timer : Timer

## List of Nebulas.
var nebulas : Array[Nebula] = []


## Load Nebuas.
func _ready() -> void:
	load_nebulas()


## Load Nebulas from Data.
func load_nebulas() -> void:
	if Game.ref.data.nebulas.size() == 0:
		return
	
	nebulas = []
	
	var index : int = 0
	
	for _nebula : DataNebula in Game.ref.data.nebulas:
		var new_nebula : Nebula = Nebula.new()
		new_nebula.name = _nebula.name
		new_nebula.stardust = _nebula.stardust
		new_nebula.stardust_consumed = _nebula.stardust_consumed
		new_nebula.data_index = index
		
		timer.timeout.connect(new_nebula._on_consume_stardust)
		
		nebulas.append(new_nebula)


## Returns the full List of Nebulas.
func get_all_nebulas() -> Array[Nebula]:
	return nebulas


## Create a new Nebula and add it to the list.
func create_nebula() -> void:
	var new_nebula : Nebula = Nebula.new()
	new_nebula.data_index = nebulas.size()
	
	timer.timeout.connect(new_nebula._on_consume_stardust)
	
	nebulas.append(new_nebula)
	
	var data_nebula : DataNebula = DataNebula.new()
	data_nebula.name = new_nebula.given_name
	data_nebula.stardust = new_nebula.stardust
	data_nebula.stardust_consumed = new_nebula.stardust_consumed
	Game.ref.data.nebulas.append(data_nebula)
	
	nebula_created.emit()


## Changes the stardust consumption value of a single Nebula.
func update_nebula_stardust_consumption_value(index : int, value : int) -> void:
	nebulas[index].stardust_consumed = value
	Game.ref.data.nebulas[index].stardust_consumed = value
