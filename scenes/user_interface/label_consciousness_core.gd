class_name LabelConsciousnessCore
extends Label
## Displays the amount of Consciousness Core available.


func _ready() -> void:
	update_text()
	HandlerConsciousnessCore.ref.consciousness_core_created.connect(update_text)
	HandlerConsciousnessCore.ref.consciousness_core_consumed.connect(update_text)


func update_text(_quantity : int = -1) -> void:
	text = "Consciousness Core : %s" %Game.ref.data.consciousness_core
