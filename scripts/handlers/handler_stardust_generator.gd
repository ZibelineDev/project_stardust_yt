class_name HandlerStardustGenerator
extends Node
## Passively generates Stardust.

## Singleton reference.
static var ref : HandlerStardustGenerator

## Singleton check.
func _enter_tree() -> void:
	if not ref:
		ref = self
		return
	
	queue_free()


## Emitted when generator power was calculated.
signal generator_power_calculated

## Reference to the generator timer.
@export var timer : Timer

## Amount of Stardust generated every loop.
var generator_power : int = 1

## Loads data.
func _ready() -> void:
	calculate_generator_power()
	
	HandlerCCUpgrades.ref.upgrade_leveled_up.connect(watch_for_upgrades_level_up)
	HandlerNebulas.ref.nebula_effect_updated.connect(_on_nebula_effect_updated)
	
	if Game.ref.data.cc_upgrades.u_01_stardust_generation_level:
		timer.start()
		return
	
	HandlerCCUpgrades.ref.u_01_stardust_generation.leveled_up.connect(watch_for_ccu01_level_up)


## Triggered when the timer completes a loop.
func _on_timer_timeout() -> void:
	HandlerStardust.ref.create_stardust(generator_power)


## Triggered when an upgrade levels up. Recalculate generator power.
func watch_for_upgrades_level_up(_upgrade : Upgrade) -> void:
	calculate_generator_power()


func _on_nebula_effect_updated() -> void:
	calculate_generator_power()



## Wait for ccu_01 to be purchased.
func watch_for_ccu01_level_up() -> void:
	timer.start()
	HandlerCCUpgrades.ref.u_01_stardust_generation.leveled_up.disconnect(watch_for_ccu01_level_up)


## Calculate the amount of stardust which should be created every seconds.
func calculate_generator_power() -> void:
	var new_power : int = 1
	new_power += Game.ref.data.cc_upgrades.u_02_stardust_boost_level * 2
	new_power += HandlerNebulas.ref.effect_stardust_generation
	new_power += Game.ref.data.sifting.level
	
	generator_power = new_power
	
	generator_power_calculated.emit()
