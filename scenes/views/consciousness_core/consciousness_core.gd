class_name ViewConsciousnessCore
extends View

## Ref to Intro View.
@export var intro_view : Control
## Ref to Main View.
@export var main_view : Control

## Initialize visibility & inherited behaviour.
func _ready() -> void:
	super()
	visible = false
	load_data()


## Triggered when the awaken universe button is clicked.
func _on_awaken_universe_button_pressed() -> void:
	HandlerCCUpgrades.ref.ccu_01_awaken_universe.level_up()


func load_data() -> void:
	if not Game.ref.data.upgrades.ccu_01_awaken_universe:
		intro_view.visible = true
		main_view.visible = false
		watch_for_intro_completion()


func watch_for_intro_completion() -> void:
	HandlerCCUpgrades.ref.upgrade_leveled_up.connect(_on_upgrade_level_up)


func _on_upgrade_level_up(upgrade : Upgrade) -> void:
	if upgrade == HandlerCCUpgrades.ref.ccu_01_awaken_universe:
		complete_intro()


func complete_intro() -> void:
	HandlerCCUpgrades.ref.upgrade_leveled_up.disconnect(_on_upgrade_level_up)
	main_view.visible = true
	intro_view.visible = false
	
