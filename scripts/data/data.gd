class_name Data
extends Resource
## Contain data to save and load.


## Current amount of consciousness cores available.
@export var consciousness_core : int = 1
## Time of the last save.
@export var save_time : int = -1


## Current amount of stardust available.
@export var stardust : int = 0
## Current amount of Ionized Stardust available.
@export var ionized_stardust : int = 0
## Current amount of Liquid Stardust available.
@export var liquid_stardust : int = 0


## Contains CCUpgrades data to save & load.
@export var cc_upgrades : DataCCUpgrades = DataCCUpgrades.new()
## Contains Universe data to save & load.
@export var universe : DataUniverse = DataUniverse.new()
## Contains Sifting data.
@export var sifting : DataSifting = DataSifting.new()


## Contains Nebulas data.
@export var nebulas : Array[DataNebula] = []

