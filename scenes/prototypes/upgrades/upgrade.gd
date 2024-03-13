class_name SceneUpgrade
extends Control
## Scene displaying an upgrade.


@export var title_label : Label

@export var description_label : RichTextLabel

@export var purchase_button : Button


## Upgrade to display.
var upgrade : Up01ClickerUpgrade


func _ready() -> void:
	upgrade = Up01ClickerUpgrade.new()
	update_title()
	update_description()
	update_button()
	
	upgrade.leveled_up.connect(update_title)
	upgrade.leveled_up.connect(update_description)
	HandlerStardust.ref.stardust_created.connect(update_button)
	HandlerStardust.ref.stardust_consumed.connect(update_button)


func update_title() -> void:
	var text : String = upgrade.title()
	text += " [%s]" %upgrade.level
	
	title_label.text = text


func update_description() -> void:
	description_label.text = upgrade.description()


func update_button(_quantity : int = -1) -> void:
	if upgrade.can_afford():
		purchase_button.disabled = false
		return
	
	purchase_button.disabled = true


func _on_purchase_button_pressed() -> void:
	upgrade.level_up()
