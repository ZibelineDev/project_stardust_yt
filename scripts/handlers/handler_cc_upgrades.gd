class_name HandlerCCUpgrades
extends Node

## Singleton Ref
static var ref : HandlerCCUpgrades

## Singleton Check.
func _enter_tree() -> void:
	if not ref:
		ref = self
		return
	
	queue_free()


## Emitted when an upgrades levels up.
signal upgrade_leveled_up(upgrade : Upgrade)

## Ref to ccu_01_awaken_universe.
@onready var ccu_01_awaken_universe : Upgrade = CCU01AwakenUniverse.new()
