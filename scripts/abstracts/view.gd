class_name View
extends Control
## Abstract class defining a view.

## Reference to the user interface.
@export var user_interface : UserInterface
## View reference.
@export var view : UserInterface.Views


## Initialize visibility at launch.
func _ready() -> void:
	user_interface.navigation_requested.connect(_on_navigation_request)


## Watch for navigation requests and react accordingly.
func _on_navigation_request(requested_view : UserInterface.Views ) -> void:
	if requested_view == view:
		visible = true
		return
	
	visible = false
