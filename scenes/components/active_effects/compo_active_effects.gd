extends VBoxContainer
## Displays the Active effects of the Universe.


## Reference to the label displaying the current Stardust per seconds.
@export var stardust_per_second : RichTextLabel


func _ready() -> void:
	_connect_signals()
	_update_stardust_per_second()


func _connect_signals() -> void:
	HandlerStardustGenerator.ref.generator_power_calculated.connect(_on_stardust_generator_power_calculated)


## Updates the stardust per second display.
func _update_stardust_per_second() -> void:
	var text : String = "[b]Stardust.s⁻¹ :[/b] %s" %HandlerStardustGenerator.ref.generator_power
	stardust_per_second.text = text


## Triggered when the stardust generator power was calculated.
func _on_stardust_generator_power_calculated() -> void:
	_update_stardust_per_second()
