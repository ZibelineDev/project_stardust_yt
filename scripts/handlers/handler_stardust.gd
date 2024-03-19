class_name HandlerStardust
extends Node
## Manages stardust and related signals.

## Singleton reference.
static var ref : HandlerStardust


## Singleton check.
func _enter_tree() -> void:
	if not ref:
		ref = self
		return
	
	queue_free()


## Emitted when stardust has been created.
signal stardust_created(quantity : int)
## Emitted when stardust has been consumed.
signal stardust_consumed(quantity : int)


## Returns the current amount of stardust available.
func stardust() -> int:
	return Game.ref.data.stardust


## Create a specific amount of stardust.
func create_stardust(quantity : int) -> void:
	Game.ref.data.stardust += quantity
	Game.ref.data.universe.stardust += quantity
	stardust_created.emit(quantity)


## Consume a specific amount of stardust.
func consume_stardust(quantity : int) -> Error:
	if quantity > Game.ref.data.stardust:
		return Error.FAILED
	
	Game.ref.data.stardust -= quantity
	stardust_consumed.emit(quantity)
	
	return Error.OK


## Triggered by the clicker; creates stardust.
func trigger_clicker() -> void:
	var quantity : int = 1
	quantity += Game.ref.data.up_01_level
	
	create_stardust(quantity)
