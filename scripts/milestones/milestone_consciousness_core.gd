class_name MilestoneConsciousnessCore
extends Node
## Manages the milestones to generate Consciousness Cores.


## Table containing stardust milestones.
var milestones : Array[int] = [
	4, 8, 16, 24, 32, 40, 48, 56, 64, 72,
	80, 88, 96, 104, 112, 120, 128, 136, 144, 152,
]

## Amount of stardust which must be generated to create a new consciousness core.
var stardust_goal : int = -1
## Amount of stardust which have been generated for this milestone.
var stardust_progress : int = -1
## Excess of stardust from the previous milestone which must be transfered.
var stardust_excess : int = 0

## Reference to universe data.
var universe : DataUniverse


## Initialization & Load.
func _init() -> void:
	universe = Game.ref.data.universe
	HandlerStardust.ref.stardust_created.connect(_on_stardust_created)
	stardust_goal = milestones[universe.consciousness_core]
	stardust_progress = universe.cc_milestone_progress


## Initialize a new milestone.
func start_new_milestone() -> void:
	stardust_goal = milestones[universe.consciousness_core]
	stardust_progress = 0
	universe.cc_milestone_progress = stardust_progress


## Checks if the milestone is compelted.
func check_for_milestone_completion() -> void:
	if stardust_progress >= stardust_goal:
		milestone_completion()


## Completes a milestone.
func milestone_completion() -> void:
	stardust_excess = stardust_progress - stardust_goal
	HandlerConsciousnessCore.ref.create_consciousness_core(1)
	start_new_milestone()
	stardust_progress = stardust_excess
	universe.cc_milestone_progress = stardust_progress
	stardust_excess = 0
	check_for_milestone_completion()


## Triggered when stardust is created. Progresses the current milestone.
func _on_stardust_created(quantity : int) -> void:
	stardust_progress += quantity
	universe.cc_milestone_progress = stardust_progress
	check_for_milestone_completion()
