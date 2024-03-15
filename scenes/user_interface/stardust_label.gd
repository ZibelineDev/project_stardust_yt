class_name LabelStardust
extends Label
## Displays the current amount of stardust available.


## Connecting signals.
func _ready() -> void:
	if Game.ref.data.upgrades.ccu_01_awaken_universe:
		visible = true
	
	else:
		visible = false
		HandlerCCUpgrades.ref.upgrade_leveled_up.connect(_on_upgrade_level_up)
	
	update_text()
	HandlerStardust.ref.stardust_created.connect(update_text)
	HandlerStardust.ref.stardust_consumed.connect(update_text)


## Updates the text the reflect the current amount of stardust.
func update_text(_quantity : int = -1) -> void:
	text = "Stardust : %s" %HandlerStardust.ref.stardust()


func _on_upgrade_level_up(upgrade : Upgrade) -> void:
	if upgrade == HandlerCCUpgrades.ref.ccu_01_awaken_universe:
		visible = true
		HandlerCCUpgrades.ref.upgrade_leveled_up.disconnect(_on_upgrade_level_up)
