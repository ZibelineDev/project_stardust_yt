class_name PrototypeClicker
extends Control
## A clicker prototype creating stardust.


## Reference to the user interface.
@export var user_interface : UserInterface
## View reference.
@export var view : UserInterface.Views


## Initialize visibility and connect signals.
func _ready() -> void:
	visible = false
	
	user_interface.navigation_requested.connect(_on_navigation_request)


## Triggered when the create stardust button is pressed.
func _on_button_pressed() -> void:
	HandlerStardust.ref.trigger_stardust_clicker()


## Watch for navigation requests and react accordingly.
func _on_navigation_request(requested_view : UserInterface.Views ) -> void:
	if requested_view == view:
		visible = true
		return
	
	visible = false
