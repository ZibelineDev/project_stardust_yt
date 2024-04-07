class_name UserInterface
extends Control
## Main class controling the user interface.


## List of views.
enum Views {
	UNIVERSE,
	CONSCIOUSNESS_CORE,
	NEBULAS,
	SIFTING,
}

## Emitted when something requested navigation. Includes the view target.
signal navigation_requested(view : Views)


## Navigate to Universe View on Launch.
func _ready() -> void:
	navigation_requested.emit(Views.UNIVERSE)


## Triggered when the Consciousness Core link is clicked.
func _on_consciousness_core_link_pressed() -> void:
	navigation_requested.emit(Views.CONSCIOUSNESS_CORE)


## Triggerend when the Universe Link Button is clicked.
func _on_universe_link_pressed() -> void:
	navigation_requested.emit(Views.UNIVERSE)


## Triggerend when the Nebulas Link Button is clicked.
func _on_nebulas_link_pressed() -> void:
	navigation_requested.emit(Views.NEBULAS)


## Triggered when the Sifting Link Button is clicked.
func _on_sifting_link_pressed() -> void:
	navigation_requested.emit(Views.SIFTING)
