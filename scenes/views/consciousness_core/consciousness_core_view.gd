class_name ViewConsciousnessCore
extends View
## View displaying the upgrades purchasable with Consciousness Cores.


@export var ccu_area : Control

@export var compo_upgrade_scene : PackedScene


## Initialize visibility.
func _ready() -> void:
	super()
	visible = false
	initialize_upgrades()


func initialize_upgrades() -> void:
	var upgrades : Array[Upgrade] = HandlerCCUpgrades.ref.get_all_upgrades()
	
	if upgrades.size() == 0:
		return
	
	for upgrade : Upgrade in upgrades:
		var upgrade_node : CompoUpgrade = compo_upgrade_scene.instantiate() as CompoUpgrade
		
		upgrade_node.upgrade = upgrade
		
		ccu_area.add_child(upgrade_node)
