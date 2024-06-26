class_name CCU02StardustBoost
extends Upgrade
## CCU02 Upgrade : Increases the amount of stardust generated per second.


## Initialize values.
func _init() -> void:
	max_level = 5
	level = Game.ref.data.cc_upgrades.u_02_stardust_boost_level
	base_cost = 1
	cost = 1
	
	if not is_unlocked():
		HandlerCCUpgrades.ref.u_01_stardust_generation.leveled_up.connect(_on_ccu01_level_up)


## Returns the title of the upgrade.
func title() -> String:
	var text : String = "Stardust Generator Efficiency"
	
	match level:
		0:
			text += " "
		1:
			text += " I"
		2:
			text += " II"
		3:
			text += " III"
		4:
			text += " IV"
		5:
			text += " V"
	return text 


## Returns the description of the upgrade.
func description() -> String:
	var text : String = "Increase the amount of Stardust generated by the Universe Core."
	text += "\n[b]Effects :[/b] +2 stardust / sec."
	
	if level < max_level:
		text += "\n[b]Cost :[/b] %s Consciousness Cores" %cost
	return text


## Returns whether or not the player can afford buying the upgrade.
func can_afford() -> bool:
	if level >= max_level:
		return false
	
	if Game.ref.data.consciousness_core >= cost:
		return true
	
	return false


## Consumes Consciousness Core to level up.
func level_up() -> void:
	if level >= max_level:
		return
	
	var error : Error = HandlerConsciousnessCore.ref.consume_consciousness_core(cost)
	
	if error:
		return
	
	level += 1
	Game.ref.data.cc_upgrades.u_02_stardust_boost_level = level
	
	leveled_up.emit()
	HandlerCCUpgrades.ref.upgrade_leveled_up.emit(self)


## Returns whether or not the upgrade has been unlocked.
func is_unlocked() -> bool:
	if Game.ref.data.cc_upgrades.u_01_stardust_generation_level:
		return true
	
	return false


## Triggered when CCU01 is purchased. Unlocks this upgrade.
func _on_ccu01_level_up() -> void:
	HandlerCCUpgrades.ref.u_01_stardust_generation.leveled_up.disconnect(_on_ccu01_level_up)
	HandlerCCUpgrades.ref.upgrade_unlocked.emit(self)


## Returns whether or not the upgrade has been disabled.
func is_disabled() -> bool:
	if level >= max_level:
		return true
	
	return false
