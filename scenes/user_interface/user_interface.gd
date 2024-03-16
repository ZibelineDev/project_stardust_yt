class_name UserInterface
extends Control
## Main class controling the user interface.


## List of views.
enum Views {
	PROTOTYPE_GENERATOR,
	PROTOTYPE_CLICKER,
	PROTOTYPE_UPGRADES,
	CONSCIOUSNESS_CORE,
}

## Emitted when something requested navigation. Includes the view target.
signal navigation_requested(view : Views)


## Triggered when the prototype generator link is clicked.
func _on_prototype_generator_link_pressed() -> void:
	navigation_requested.emit(Views.PROTOTYPE_GENERATOR)


## Triggered when the prototype clicker link is clicked.
func _on_prototype_clicker_link_pressed() -> void:
	navigation_requested.emit(Views.PROTOTYPE_CLICKER)


## Triggered when the prototype upgrades link is clicked.
func _on_prototype_upgrades_link_pressed() -> void:
	navigation_requested.emit(Views.PROTOTYPE_UPGRADES)


## Triggered when the Consciousness Core link is clicked.
func _on_consciousness_core_link_pressed() -> void:
	navigation_requested.emit(Views.CONSCIOUSNESS_CORE)
