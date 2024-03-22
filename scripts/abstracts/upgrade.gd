class_name Upgrade
extends Node
## Abstract class defining an upgrade.

## Emitted when the upgrades has leveled up.
signal leveled_up
## Emitted when an upgrade is unlocked.
signal upgrade_unlocked

## Level of the upgrade.
var level : int = -1
## Base cost of the upgrade.
var base_cost : int = -1
## Current cost of the upgrade.
var cost : int = -1


## Virtual class, must be overwritten.[br]
## Returns the title of the upgrade.
func title() -> String:
	return "Title not defined."


## Virtual class, must be overwritten.[br]
## Returns the description of the upgrade.
func description() -> String:
	return "Description not defined."


## Virtual class, must be overwritten.[br]
## Returns the current cost based on level and base cost.
func calculate_cost() -> void:
	printerr("calculate_cost() method not defined.")


## Virtual class, must be overwritten.[br]
## Returns whether or not the player can afford buying the upgrade.
func can_afford() -> bool:
	return false


## Virtual class, must be overwritten.[br]
## Consumes stardust to level up.
func level_up() -> void:
	printerr("level_up() method not defined.")


## Virtual class, must be overwritten.[br]
## Returns whether or not the upgrade has been unlocked.
func is_unlocked() -> bool:
	return false


## Virtual class, must be overwritten.[br]
## Returns whether or not the upgrade has been disabled.
func is_disabled() -> bool:
	return false
