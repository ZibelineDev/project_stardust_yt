class_name HandlerLiquidStardust
extends Node
## Manages liquid stardust and related signals.

## Singleton reference.
static var ref : HandlerLiquidStardust


## Singleton check.
func _enter_tree() -> void:
	if not ref:
		ref = self
		return
	
	queue_free()


## Emitted when  liquid stardust has been created.
signal liquid_stardust_created(quantity : int)
## Emitted when liquid stardust has been consumed.
signal liquid_stardust_consumed(quantity : int)


## Returns the current amount of  liquid stardust available.
func liquid_stardust() -> int:
	return Game.ref.data.liquid_stardust


## Create a specific amount of liquid stardust.
func create_liquid_stardust(quantity : int) -> void:
	Game.ref.data.liquid_stardust += quantity
	Game.ref.data.universe.liquid_stardust += quantity
	liquid_stardust_created.emit(quantity)


## Consume a specific amount of lquid_stardust.
func consume_liquid_stardust(quantity : int) -> Error:
	if quantity > Game.ref.data.liquid_stardust:
		return Error.FAILED
	
	Game.ref.data.liquid_stardust -= quantity
	liquid_stardust_consumed.emit(quantity)
	
	return Error.OK
