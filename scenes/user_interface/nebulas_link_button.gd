extends LinkButton


## Check if the players has unlocked Nebulas.
func _ready() -> void:
	if Game.ref.data.cc_upgrades.u_03_unlock_nebulas:
		visible = true
	
	else:
		visible = false
		HandlerCCUpgrades.ref.u_03_unlock_nebulas.leveled_up.connect(_on_ccu03_level_up)


## Triggered when CCU03 levels up.
## Makes the link visible.
func _on_ccu03_level_up() -> void:
	visible = true
	HandlerCCUpgrades.ref.u_03_unlock_nebulas.leveled_up.disconnect(_on_ccu03_level_up)
