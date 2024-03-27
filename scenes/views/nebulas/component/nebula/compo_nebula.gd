class_name CompoNebula
extends VBoxContainer
## Displays the information of a Nebula.


## References the label displaying the name.
@export var label_name : Label
## References the label displaying the composition.
@export var label_composition : RichTextLabel
## References the slider managing Stardust Attraction.
@export var attraction_slider : HSlider
## References the slider maanaging Ionized Stardust Release.
@export var release_slider : HSlider


## References the Nebula to display.
var nebula : Nebula


func _ready() -> void:
	update_component()
	nebula.composition_updated.connect(update_label_composition)


## Update all the nodes of the the component.
func update_component() -> void:
	update_label_name()
	update_label_composition()
	update_attraction_slider()


func update_label_name() -> void:
	label_name.text = nebula.given_name


func update_label_composition() -> void:
	var text : String = "Stardust : %s" %nebula.stardust
	if nebula.ionized_stardust:
		text += "\nIonized Stardust : %s" %nebula.ionized_stardust
	
	label_composition.text = text


func update_attraction_slider() -> void:
	attraction_slider.min_value = HandlerNebulas.ref.min_attraction_value
	attraction_slider.max_value = HandlerNebulas.ref.max_attraction_value
	attraction_slider.value = nebula.attraction_value


func update_release_slider() -> void:
	release_slider.min_value = HandlerNebulas.ref.min_release_value
	release_slider.max_value = HandlerNebulas.ref.max_release_value
	release_slider.value = nebula.release_value


## Triggered when the Attraction Slider value is changed.
func _on_attraction_slider_value_changed(value: float) -> void:
	HandlerNebulas.ref.update_nebula_stardust_attraction_value(nebula.data_index, int(value))


## Triggered when the Release Slider value is changed.
func _on_release_slider_value_changed(value: float) -> void:
	HandlerNebulas.ref.update_nebula_release_value(nebula.data_index, int(value))
