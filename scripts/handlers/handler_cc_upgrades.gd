class_name HandlerCCUpgrades
extends Node
## Manages Consciousness Core Upgrades.

## Singleton reference.
static var ref : HandlerCCUpgrades


## Singleton check.
func _enter_tree() -> void:
	if not ref:
		ref = self
		return
	
	queue_free()


## Emitted when an upgrade has leveled up.
signal upgrade_leveled_up(upgrade : Upgrade)
## Emitted when an upgrade unlocks.
signal upgrade_unlocked(upgrade : Upgrade)
## Emitted when an upgrade reaches max level.
signal upgrade_reached_max_level(upgrade : Upgrade)


## Reference to CCUpgrade 01.
@onready var u_01_stardust_generation : CCU01StardustGenerator = CCU01StardustGenerator.new()
## Reference to CCUpgrade 02.
@onready var u_02_stardust_boost : CCU02StardustBoost = CCU02StardustBoost.new()
## Reference to CCUpgrade 03.
@onready var u_03_unlock_nebulas : CCU03UnlockNebulas = CCU03UnlockNebulas.new()
## Reference to CCUpgrade 04.
@onready var u_04_max_nebulas : CCU04MaxNebulas = CCU04MaxNebulas.new()
## Reference to CCUpgrade 05.
@onready var u_05_attraction_power : CCU05AttractionPower = CCU05AttractionPower.new()
## Reference to CCUpgrade 06.
@onready var u_06_unlock_sifting : CCU06UnlockSifting = CCU06UnlockSifting.new()


##
func _ready() -> void:
	upgrade_leveled_up.connect(_on_upgrade_level_up)


## Returns all CCUpgrades.
func get_all_upgrades() -> Array[Upgrade]:
	return [
		u_01_stardust_generation,
		u_02_stardust_boost,
		u_03_unlock_nebulas,
		u_04_max_nebulas,
		u_05_attraction_power,
		u_06_unlock_sifting,
	]


## 
func get_all_unlocked_upgrades() -> Array[Upgrade]:
	var list : Array[Upgrade] = []
	
	for upgrade : Upgrade in get_all_upgrades():
		if upgrade.is_unlocked():
			list.append(upgrade)
	
	return list


##
func get_all_unlocked_non_max_level_upgrades() -> Array[Upgrade]:
	var list : Array[Upgrade] = []
	
	for upgrade : Upgrade in get_all_unlocked_upgrades():
		if upgrade.level < upgrade.max_level:
			list.append(upgrade)
	
	return list


## Triggered when an upgrade levels up.
func _on_upgrade_level_up(upgrade : Upgrade) -> void:
	if upgrade.level >= upgrade.max_level:
		upgrade_reached_max_level.emit(upgrade)
