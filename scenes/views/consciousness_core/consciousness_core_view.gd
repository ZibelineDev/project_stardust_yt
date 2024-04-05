class_name ViewConsciousnessCore
extends View
## View displaying the upgrades purchasable with Consciousness Cores.


##
@export var ccu_area : Control
##
@export var compo_upgrade_scene : PackedScene
##
var show_max_level_upgrades : bool = true


## Initialize visibility.
func _ready() -> void:
	super()
	visible = false
	initialize_upgrades()
	HandlerCCUpgrades.ref.upgrade_unlocked.connect(_on_upgrade_unlocked)


##
func initialize_upgrades() -> void:
	var upgrades : Array[Upgrade]
	
	if show_max_level_upgrades:
		upgrades = HandlerCCUpgrades.ref.get_all_unlocked_upgrades()
	else:
		upgrades =  HandlerCCUpgrades.ref.get_all_unlocked_non_max_level_upgrades()
	
	if upgrades.size() == 0:
		return
	
	for upgrade : Upgrade in upgrades:
		var upgrade_node : CompoUpgrade = compo_upgrade_scene.instantiate() as CompoUpgrade
		
		upgrade_node.upgrade = upgrade
		
		ccu_area.add_child(upgrade_node)


##
func regenerate_upgrades() -> void:
	for child : Node in ccu_area.get_children():
		child.queue_free()
	
	initialize_upgrades()


## Triggered when an upgrade unlocks. Regenerate the upgrade nodes.
func _on_upgrade_unlocked(_upgrade : Upgrade) -> void:
	regenerate_upgrades()


##
func _on_hide_max_level_upgrades_button_toggle(toggled_on: bool) -> void:
	show_max_level_upgrades = not toggled_on
	regenerate_upgrades()
