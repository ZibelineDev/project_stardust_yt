class_name LabelStardust
extends Label
## Displays the current amount of stardust available.


## Temporary function to update the text.
func _process(_delta: float) -> void:
	update_text()


## Updates the text the reflect the current amount of stardust.
func update_text() -> void:
	text = "Stardust : %s" %Game.ref.data.stardust
