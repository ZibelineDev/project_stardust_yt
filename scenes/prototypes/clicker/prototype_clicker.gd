class_name PrototypeClicker
extends Control
## A clicker prototype creating stardust.


## Reference to the label displaying the current amount of stardust created.
@export var label : Label

## Reference to the user interface.
@export var user_interface : UserInterface
## View reference.
@export var view : UserInterface.Views

## Current amount of stardust created.
var stardust : int = 0


## Initialize the label at launch.
func _ready() -> void:
	update_label_text()
	
	visible = false
	
	user_interface.navigation_requested.connect(_on_navigation_request)


## Create 1 stardust.
func create_stardust() -> void:
	stardust += 1
	update_label_text()


## Update the text of the label to reflect a change in stardust amount.
func update_label_text() -> void:
	label.text = "Stardust : %s" %stardust


## Triggered when the create stardust button is pressed.
func _on_button_pressed() -> void:
	create_stardust()


## Watch for navigation requests and react accordingly.
func _on_navigation_request(requested_view : UserInterface.Views ) -> void:
	if requested_view == view:
		visible = true
		return
	
	visible = false
