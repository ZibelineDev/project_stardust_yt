class_name LabelIonizedStardust
extends Label
## Displays the current amount of Ionized Stardust available.


## Connecting signals.
func _ready() -> void:
	update_text()
	HandlerIonizedStardust.ref.ionized_stardust_created.connect(update_text)
	HandlerIonizedStardust.ref.ionized_stardust_consumed.connect(update_text)


## Updates the text the reflect the current amount of Ionized Stardust.
func update_text(_quantity : int = -1) -> void:
	if HandlerIonizedStardust.ref.ionized_stardust():
		text = "Ionized Stardust : %s" %HandlerIonizedStardust.ref.ionized_stardust()
	
	else:
		text = ""
