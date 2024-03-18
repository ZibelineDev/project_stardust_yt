class_name HandlerConsciousnessCore
extends Node
## Manages Consciousness Cores and related signals.

## Singleton reference.
static var ref : HandlerConsciousnessCore


## Singleton check.
func _enter_tree() -> void:
	if not ref:
		ref = self
		return
	
	queue_free()


## Reference to the cc milestone manager.
@onready var cc_milestone : MilestoneConsciousnessCore = MilestoneConsciousnessCore.new()


## Emitted when Consciousness Cores are created.
signal consciousness_core_created(quantity : int)
## Emitted  when Consciousness Cores are consumed.
signal consciousness_core_consumed(quantity : int)


## Get the current amount of Consciousness Cores.
func consciousness_core() -> int:
	return Game.ref.data.consciousness_core


## Create a specific amount of Consciousness Cores.
func create_consciousness_core(quantity : int) -> void:
	Game.ref.data.consciousness_core += quantity
	Game.ref.data.universe.consciousness_core += quantity
	consciousness_core_created.emit(quantity)


## Consume a specific amount of Consciousness Cores.
func consume_consciousness_core(quantity : int) -> Error:
	if quantity > Game.ref.data.consciousness_core:
		return Error.FAILED
	
	Game.ref.data.consciousness_core -= quantity
	consciousness_core_consumed.emit(quantity)
	
	return Error.OK
