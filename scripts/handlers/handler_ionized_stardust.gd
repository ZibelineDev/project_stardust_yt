class_name HandlerIonizedStardust
extends Node
## Manages Ionized Stardust and related signals.

## Singleton reference.
static var ref : HandlerIonizedStardust


## Singleton check.
func _enter_tree() -> void:
	if not ref:
		ref = self
		return
	
	queue_free()


signal ionized_stardust_created(quantity : int)

signal ionized_stardust_consumed(quantity : int)


## Returns the current amount of Ionized Stardust available.
func ionized_stardust() -> int:
	return Game.ref.data.ionized_stardust


## Create a specific amount of Ionized Stardust.
func create_ionized_stardust(quantity : int) -> void:
	Game.ref.data.ionized_stardust += quantity
	ionized_stardust_created.emit(quantity)


## Consume a specific amount of Ionized Stardust.
func consume_ionized_stardust(quantity : int) -> Error:
	if quantity > Game.ref.data.ionized_stardust:
		return Error.FAILED
	
	Game.ref.data.ionized_stardust -= quantity
	ionized_stardust_consumed.emit(quantity)
	
	return Error.OK
