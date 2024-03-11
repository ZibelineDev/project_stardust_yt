class_name PrototypeGenerator
extends Control
## Generator prototype creating stardust every seconds.


## Reference to the label displaying the current amount of stardust in storage.
@export var label : Label
## Reference to the button starting the generation.
@export var button : Button
## Reference to the timer.
@export var timer : Timer

## Current amount of stardust in storage.
var stardust : int = 0


## Initizalize the label.
func _ready() -> void:
	update_label_text()


## Creates stardust and store it.
func create_stardust() -> void:
	stardust += 1
	update_label_text()


## Updates the label text to match the current amount of stardust in storage.
func update_label_text() -> void:
	label.text = "Stardurst : %s" %stardust


## Start the timer and disable the button.
func begin_generating_stardust() -> void:
	timer.start()
	button.disabled = true


## Triggered when the "begin generating" button is pressed.
func _on_button_pressed() -> void:
	begin_generating_stardust()


## Triggered when the timer times out.
func _on_timer_timeout() -> void:
	create_stardust()
