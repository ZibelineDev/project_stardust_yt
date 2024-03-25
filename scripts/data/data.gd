class_name Data
extends Resource
## Contain data to save and load.


## Current amount of stardust available.
@export var stardust : int = 0
## Current amount of consciousness cores available.
@export var consciousness_core : int = 1


## Contains CCUpgrades data to save & load.
@export var cc_upgrades : DataCCUpgrades = DataCCUpgrades.new()
## Contains Universe data to save & load.
@export var universe : DataUniverse = DataUniverse.new()


## Contains Nebulas data.
@export var nebulas : Array[DataNebula] = []
