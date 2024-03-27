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
## Maximum amount of Nebulas the player can create.
var max_nebulas_count : int = 1

## Mininmum attraction value Nebulas can have.
var min_attraction_value : int = 1
## Maximum attraction value Nebulas can have.
var max_attraction_value : int = 5
## Minimum release value Nebulas can have.
var min_release_value : int = 1
## Maximum release value Nebulas can have.
var max_release_value : int = 5


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
		new_nebula.ionized_stardust = _nebula.ionized_stardust
		
		new_nebula.attraction_value = _nebula.attraction_value
		new_nebula.release_value = _nebula.release_value
		
		new_nebula.data_index = index
		
		timer.timeout.connect(new_nebula._on_nebula_timer_timeout)
		
		nebulas.append(new_nebula)


## Returns the full List of Nebulas.
func get_all_nebulas() -> Array[Nebula]:
	return nebulas


## Create a new Nebula and add it to the list.
func create_nebula() -> Error:
	if nebulas.size() >= max_nebulas_count:
		return Error.FAILED
	
	var new_nebula : Nebula = Nebula.new()
	new_nebula.data_index = nebulas.size()
	
	timer.timeout.connect(new_nebula._on_nebula_timer_timeout)
	
	nebulas.append(new_nebula)
	
	var data_nebula : DataNebula = DataNebula.new()
	data_nebula.name = new_nebula.given_name
	
	data_nebula.stardust = new_nebula.stardust
	data_nebula.ionized_stardust = new_nebula.ionized_stardust
	
	data_nebula.attraction_value = new_nebula.attraction_value
	data_nebula.release_value = new_nebula.release_value
	
	Game.ref.data.nebulas.append(data_nebula)
	
	nebula_created.emit()
	
	return Error.OK


## Changes the stardust consumption value of a single Nebula.
func update_nebula_stardust_attraction_value(index : int, value : int) -> void:
	nebulas[index].attraction_value = value
	Game.ref.data.nebulas[index].attraction_value = value


## Changes the Ionized Stardust release value of a single Nebula.
func update_nebula_release_value(index : int, value : int) -> void:
	nebulas[index].release_value = value
	Game.ref.data.nebulas[index].release_value = value
