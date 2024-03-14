class_name HandlerConsciousnessCore
extends Node
## Consciousness Core Handler.

## Singleton Ref.
static var ref : HandlerConsciousnessCore

## Singleton Check.
func _enter_tree() -> void:
	if not ref:
		ref = self
		return
	
	queue_free()


## Emitted when Consciousness Cores are created.
signal consciousness_core_created(quantity : int)
## Emitted when Consciousness Cores are consumed.
signal consciousness_core_consumed(quantity : int)


## Method to use to get the current amount of Consciousness Cores available.
func consciousness_core() -> int:
	return Game.ref.data.consciousness_core


## Method to use in order to create Consciousness Cores.
func create_consciousness_core(quantity : int) -> void:
	Game.ref.data.consciousness_core += quantity
	consciousness_core_created.emit(quantity)


## Method to use in order to consume Consciousness Cores.
func consume_consciousness_core(quantity : int) -> Error:
	if quantity > Game.ref.data.consciousness_core:
		return Error.FAILED
	
	Game.ref.data.consciousness_core -= quantity
	Game.ref.data.spent_consciousness_core += quantity
	consciousness_core_consumed.emit(quantity)
	
	return Error.OK
