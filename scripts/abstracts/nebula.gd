class_name Nebula
extends Node
## Abstract class containing the common features of all Nebulas.

signal composition_updated

## Name of the Nebula.
var given_name : String = "Unnamed Nebula"
## Index of the Nebula in Data.
var data_index : int = -1

## Amount of Stardust inside the Nebula.
var stardust : int = 0
## Amount of Ionized Stardust inside the Nebula.
var ionized_stardust : int = 0

## Amount of Stardust being attracted.
var attraction_value : int = 1
## Amount of Ionized Stardust being released.
var release_value : int = 1


## Tries to consume Stardust.
func attract_stardust() -> void:
	var error : Error = HandlerStardust.ref.consume_stardust(attraction_value)
	
	if error:
		return
	
	stardust += attraction_value
	Game.ref.data.nebulas[data_index].stardust = stardust
	
	composition_updated.emit()


## Transforms Stardust into Ionized Stardust.
func refine_stardust() -> void:
	if stardust >= 25:
		var error : Error = consume_stardust(3)
		
		if error :
			return
		
		var ionized_stardust_to_create : int = 2
		
		ionized_stardust += ionized_stardust_to_create
		Game.ref.data.universe.ionized_stardust += ionized_stardust_to_create
		Game.ref.data.nebulas[data_index].ionized_stardust = ionized_stardust
		
		composition_updated.emit()
 

## Tries to consume a certain amount of Stardust.
func consume_stardust(quantity : int) -> Error:
	if stardust >= quantity:
		stardust -= quantity
		Game.ref.data.nebulas[data_index].stardust = stardust
		
		return Error.OK
	
	return Error.FAILED


## Tries to consume a certain amount of Ionized Stardust.
func consume_ionized_stardust(quantity : int) -> Error:
	if ionized_stardust >= quantity:
		ionized_stardust -= quantity
		Game.ref.data.nebulas[data_index].ionized_stardust = ionized_stardust
		
		return Error.OK
	
	return Error.FAILED


## Consume ionized stardust from the Nebula to release it in the Universe.
func release_ionized_stardust() -> void:
	var quantity : int = -1
	if release_value > ionized_stardust:
		quantity = ionized_stardust
	
	else:
		quantity = release_value
	
	var error : Error = consume_ionized_stardust(quantity)
	
	if error:
		return
	
	HandlerIonizedStardust.ref.create_ionized_stardust(quantity)

## Triggered when the Nebula Timer times-out.
func _on_nebula_timer_timeout() -> void:
	attract_stardust()
	refine_stardust()
	release_ionized_stardust()
