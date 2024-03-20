extends ProgressBar
## Displays the current progression toward next Milestone.

## Reference to the label displaying numbered progress.
@export var label : Label

## Reference to the Milestone Node.
@onready var milestone : MilestoneStardust = HandlerConsciousnessCore.ref.stardust_milestone


func _ready() -> void:
	_connect_signals()


func _connect_signals() -> void:
	milestone.progressed.connect(_on_milestone_change)
	milestone.new_milestone_created.connect(_on_milestone_change)


func _update_progress() -> void:
	max_value = milestone.stardust_goal
	value = milestone.stardust_progress
	
	label.text = "%s / %s" %[milestone.stardust_progress, milestone.stardust_goal]


## Triggered when a new milestone is created or when the current milestones progresses.
func _on_milestone_change() -> void:
	_update_progress()
