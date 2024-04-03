class_name CCU04MaxNebulas
extends Upgrade
## Increases the max amount of Nebulas the player can create.

var max_level : int = 3 


func _init() -> void:
	level = Game.ref.data.cc_upgrades.u_04_max_nebulas_level
	base_cost = 2
	cost = 2
	if not is_unlocked():
		HandlerCCUpgrades.ref.u_03_unlock_nebulas.leveled_up.connect(_on_ccu03_level_up)



## Returns the title of the upgrade.
func title() -> String:
	var text : String = "Nebula Capacity"
	
	match level:
		0:
			pass
		1:
			text += " I"
		2:
			text += " II"
		3:
			text += " III"
	
	return text


## Returns the description of the upgrade.
func description() -> String:
	var text : String = "Increases the Nebula Capacity allowing you to create more Nebulas."
	text += "\n[b]Effects :[/b] Nebula Capacity +1"
	
	if level < max_level:
		text += "\n[b]Cost :[/b] %s Consciousness Cores" %cost
	
	return text


## Returns the current cost based on level and base cost.
func calculate_cost() -> void:
	match level:
		0:
			cost = base_cost
		
		1:
			cost = 5
		
		2:
			cost = 10
		
		3:
			cost = -1


## Returns whether or not the player can afford buying the upgrade.
func can_afford() -> bool:
	if level >= max_level:
		return false
	
	if Game.ref.data.consciousness_core >= cost:
		return true
	
	return false


## Consumes stardust to level up.
func level_up() -> void:
	if level >= max_level:
		return
	
	var error : Error = HandlerConsciousnessCore.ref.consume_consciousness_core(cost)
	
	if error:
		return
	
	level += 1
	Game.ref.data.cc_upgrades.u_04_max_nebulas_level = level
	
	calculate_cost()
	
	leveled_up.emit()
	HandlerCCUpgrades.ref.upgrade_leveled_up.emit(self)


## Returns whether or not the upgrade has been unlocked.
func is_unlocked() -> bool:
	return Game.ref.data.cc_upgrades.u_03_unlock_nebulas


## Returns whether or not the upgrade has been disabled.
func is_disabled() -> bool:
	if level >= max_level:
		return true
	
	return false


## Unlock this upgrade.
func _on_ccu03_level_up() -> void :
	HandlerCCUpgrades.ref.u_03_unlock_nebulas.leveled_up.disconnect(_on_ccu03_level_up)
	HandlerCCUpgrades.ref.upgrade_unlocked.emit(self)
