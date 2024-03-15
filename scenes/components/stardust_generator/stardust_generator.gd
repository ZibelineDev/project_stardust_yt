class_name StardustGenerator
extends Node
## Generates Stardust every seconds.

## Reference to the timer.
@export var timer : Timer
## Default amount of Stardust generated each seconds.
var base_power : int = 1


func _ready() -> void:
	if Game.ref.data.upgrades.ccu_01_awaken_universe:
		start_generating()
		return
	
	HandlerCCUpgrades.ref.upgrade_leveled_up.connect(_on_upgrade_level_up)


## Starts the timer.
func start_generating() -> void:
	timer.start()


## Checks if the upgrade leveling is ccu_01_awaken_universe.
func _on_upgrade_level_up(upgrade : Upgrade) -> void:
	if upgrade == HandlerCCUpgrades.ref.ccu_01_awaken_universe:
		start_generating()
		HandlerCCUpgrades.ref.upgrade_leveled_up.disconnect(_on_upgrade_level_up)


## Create Stardust every loop of  the timer.
func _on_timer_timeout() -> void:
	HandlerStardust.ref.create_stardust(base_power)
