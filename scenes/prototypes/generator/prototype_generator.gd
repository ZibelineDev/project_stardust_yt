class_name PrototypeGenerator
extends Control
## Generator prototype creating stardust every seconds.


## Reference to the button starting the generation.
@export var button : Button
## Reference to the timer.
@export var timer : Timer

## Reference to the user interface.
@export var user_interface : UserInterface
## View reference.
@export var view : UserInterface.Views


## Initizalize the label.
func _ready() -> void:
	visible = true
	
	user_interface.navigation_requested.connect(_on_navigation_request)


## Creates stardust and store it.
func create_stardust() -> void:
	HandlerStardust.ref.create_stardust(1)


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


## Watch for navigation requests and react accordingly.
func _on_navigation_request(requested_view : UserInterface.Views) -> void:
	if requested_view == view:
		visible = true
		return
	
	visible = false
