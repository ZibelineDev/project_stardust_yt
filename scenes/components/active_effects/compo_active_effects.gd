extends VBoxContainer
## Displays the Active effects of the Universe.


## Reference to the label displaying the current Stardust per seconds.
@export var stardust_per_second : RichTextLabel


func _ready() -> void:
	_connect_signals()
	_update_active_effects()


func _connect_signals() -> void:
	HandlerStardustGenerator.ref.generator_power_calculated.connect(_on_stardust_generator_power_calculated)
	HandlerNebulas.ref.effect_stardust_consumption_updated.connect(_on_effect_nebula_stardust_consumption_updated)


## Updates the active effects display.
func _update_active_effects() -> void:
	var text : String = "[b]Stardust.s⁻¹ :[/b] %s" %HandlerStardustGenerator.ref.generator_power
	if (HandlerNebulas.ref.effect_stardust_consumed):
		text += "\n[b]Nebulas' Stardust Consumption.s⁻¹ :[/b] %s" %HandlerNebulas.ref.effect_stardust_consumed
	stardust_per_second.text = text


## Triggered when the stardust generator power was calculated.
func _on_stardust_generator_power_calculated() -> void:
	_update_active_effects()


## Triggered when Nebulas' stardust consumption is updated.
func _on_effect_nebula_stardust_consumption_updated() -> void:
	_update_active_effects()
