class_name CompoUpgrade
extends Control
## Component displaying an upgrade.


## Reference to the title label.
@export var label_title : Label
## Reference to the Rich text label description.
@export var label_description : RichTextLabel
## Reference to the purchase button.
@export var button : Button

@export var veil : ColorRect

## Upgrade to display.
var upgrade : Upgrade


func _ready() -> void:
	if not upgrade:
		upgrade = Up01ClickerUpgrade.new()
	
	update_label_title()
	update_label_description()
	update_button()
	update_veil()
	
	HandlerStardust.ref.stardust_created.connect(update_button)
	HandlerStardust.ref.stardust_consumed.connect(update_button)
	
	upgrade.leveled_up.connect(update_label_title)
	upgrade.leveled_up.connect(update_label_description)
	upgrade.leveled_up.connect(update_button)
	upgrade.leveled_up.connect(update_veil)


## Updates the title of the upgrade.
func update_label_title() -> void:
	label_title.text = upgrade.title()


## Updates the description of the upgrade.
func update_label_description() -> void:
	label_description.text = upgrade.description()


## Updates the button availability.
func update_button(_quantity : int = -1) -> void:
	if upgrade.can_afford():
		button.disabled = false
		return
	
	button.disabled = true


## Hides or Displays the veil based on the upgrade status.
func update_veil() -> void:
	if upgrade.is_disabled():
		veil.visible = true
	
	else:
		veil.visible = false


## Triggered when the purchase button is pressed.
func _on_purchase_button_pressed() -> void:
	upgrade.level_up()
