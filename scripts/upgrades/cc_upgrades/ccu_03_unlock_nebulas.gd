class_name CCU03UnlockNebulas
extends Upgrade
## CCUpgrade 03 : Unlocks Nebulas.


## Max Level.
var max_level : int = 1


## Initialize values.
func _init() -> void:
	level = Game.ref.data.cc_upgrades.u_03_unlock_nebulas
	base_cost = 2
	cost = 2
	if not is_unlocked():
		HandlerCCUpgrades.ref.u_01_stardust_generation.leveled_up.connect(_on_ccu01_level_up)


## Returns the title of the upgrade.
func title() -> String:
	return "Unlock Nebulas"


## Returns the description of the upgrade.
func description() -> String:
	var text : String = "[b]Effects :[/b] unlock the ability to create Nebulas."
	
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
	Game.ref.data.cc_upgrades.u_03_unlock_nebulas = true
	
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
