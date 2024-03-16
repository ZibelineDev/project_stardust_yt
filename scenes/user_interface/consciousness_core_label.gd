class_name LabelConsciousnessCore
extends Label
## Displays the current amount of consciousness core available.


## Connecting signals.
func _ready() -> void:
	update_text()
	HandlerConsciousnessCore.ref.consciousness_core_created.connect(update_text)
	HandlerConsciousnessCore.ref.consciousness_core_consumed.connect(update_text)


## Updates the text the reflect the current amount of stardust.
func update_text(_quantity : int = -1) -> void:
	text = "Consciousness Cores : %s" %HandlerConsciousnessCore.ref.consciousness_core()
