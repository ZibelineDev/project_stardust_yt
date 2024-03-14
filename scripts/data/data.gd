class_name Data
extends Resource
## Contain data to save and load.


## Current amount of stardust available.
@export var stardust : int = 0

## Current amount of Consciousness Cores.
@export var consciousness_core : int = 1
## Current of spent Consciousness Cores.
@export var spent_consciousness_core : int = 0

## Contains Upgrades related Data.
@export var upgrades : DataUpgrades = DataUpgrades.new()
## Upgrade 01 Clicker Upgrade Level.
@export var up_01_level : int = 0
