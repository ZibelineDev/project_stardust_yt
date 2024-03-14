class_name CCU01AwakenUniverse
extends Upgrade
## Awaken the Universe to begin creating Stardust.

func _init() -> void:
	level = Game.ref.data.upgrades.ccu_01_awaken_universe
	base_cost = 1
	calculate_cost()


func calculate_cost() -> void:
	cost = base_cost


func can_afford() -> bool:
	if HandlerConsciousnessCore.ref.consciousness_core() >= cost:
		return true
	
	return false


func level_up() -> void:
	if level:
		return
	
	var error : Error = HandlerConsciousnessCore.ref.consume_consciousness_core(cost)
	
	if error:
		return
	
	level += 1
	Game.ref.data.upgrades.ccu_01_awaken_universe = true
	
	leveled_up.emit()
	HandlerCCUpgrades.ref.upgrade_leveled_up.emit(self)
