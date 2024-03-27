class_name DataNebula
extends Resource
## Save design of a single Nebula.

## Name givent to the Nebula.
@export var name : String

## Amount of Stardust composing the Nebula.
@export var stardust : int
## Amount of Ionized Stardust in the Nebula.
@export var ionized_stardust : int

## Amount of Stardust consumed per seconds.
@export var attraction_value : int
## Amount of Ionized Stardust being released.
@export var release_value : int
