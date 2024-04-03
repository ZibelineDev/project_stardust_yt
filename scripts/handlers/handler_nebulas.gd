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

signal nebula_effect_updated

signal effect_stardust_consumption_updated

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

## Total stardust generation effect from all Nebulas.
var effect_stardust_generation : int = 0
## Total amount of stardust being consumed by all Nebulas.
var effect_stardust_consumed : int = 0


## Load Nebuas.
func _ready() -> void:
	load_nebulas()
	calculate_nebula_capacity()
	
	HandlerCCUpgrades.ref.u_04_max_nebulas.leveled_up.connect(calculate_nebula_capacity)


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
	
	calculate_effect_stardust_consumed()


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
	
	calculate_effect_stardust_consumed()
	
	nebula_created.emit()
	
	return Error.OK


## Changes the stardust consumption value of a single Nebula.
func update_nebula_stardust_attraction_value(index : int, value : int) -> void:
	nebulas[index].attraction_value = value
	Game.ref.data.nebulas[index].attraction_value = value
	
	calculate_effect_stardust_consumed()


## Changes the Ionized Stardust release value of a single Nebula.
func update_nebula_release_value(index : int, value : int) -> void:
	nebulas[index].release_value = value
	Game.ref.data.nebulas[index].release_value = value


## Cumulates all the Nebula effects into a single property.
func calculate_nebula_effect_stardust_generation() -> void:
	var old_effect : int = effect_stardust_generation
	var new_effect : int = 0
	
	for nebula : Nebula in nebulas:
		new_effect += nebula.effect_stardust_generation
	
	effect_stardust_generation = new_effect
	
	if new_effect != old_effect:
		nebula_effect_updated.emit()


## Cumulates all the attraction values to calculate the total amount of stardust beign consumed.
func calculate_effect_stardust_consumed() -> void:
	var old_effect : int = effect_stardust_consumed
	var new_effect : int = 0
	for nebula : Nebula in nebulas:
		new_effect += nebula.attraction_value
	
	effect_stardust_consumed = new_effect
	
	if effect_stardust_consumed != old_effect:
		effect_stardust_consumption_updated.emit()


## Calculate the maximum amount of Nebulas which can be created.
func calculate_nebula_capacity() -> void:
	var capacity : int = 1
	capacity += Game.ref.data.cc_upgrades.u_04_max_nebulas_level
	
	max_nebulas_count = capacity
