class_name ViewUniverse
extends View
## Main view of the game displaying Universe related informations.


## Text to display on launch on a new game.
@export var intro_text : Label
## Main content to display once the player has created the Universe.
@export var main_content : MarginContainer


func _ready() -> void:
	super()
	_initialize_view()


## Displays the relevant content based on CCU01 purchase status.
func _initialize_view() -> void:
	if not Game.ref.data.cc_upgrades.u_01_stardust_generation_level:
		intro_text.visible = true
		main_content.visible = false
		
		HandlerCCUpgrades.ref.u_01_stardust_generation.leveled_up.connect(_on_ccu01_level_up)
	
	else:
		intro_text.visible = false
		main_content.visible = true


## Wait for CCU01 to be bought. Displays the mains content & hide intro text.
func _on_ccu01_level_up() -> void:
	intro_text.visible = false
	main_content.visible = true
	
	HandlerCCUpgrades.ref.u_01_stardust_generation.leveled_up.disconnect(_on_ccu01_level_up)
