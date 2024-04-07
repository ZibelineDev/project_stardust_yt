class_name IonizedStardustSiftingTile
extends TextureButton
## Ionized Stardust Sifting game Tile.

## Different Tile States.
enum Tiles {
	EMPTY,
	STARDUST,
	CONSCIOUSNESS_CORE,
}

## Covered tile Texture.
@export var texture_covered : Texture2D
## Uncovered Stardust Tile.
@export var texture_stardust : Texture2D
## Uncovered CC Tile.
@export var texture_cc : Texture2D

## Coordinate in the grid.
var coordinates : String
## Current State of the Tile.
var state : Tiles
## Reveal state of the Tile.
var is_revealed : bool = false
## Texture Node.
var texture : TextureRect


##
func _ready() -> void:
	texture = get_node("Texture")
	texture.texture = texture_covered


## Triggered when the tile is pressed.
func _on_pressed() -> void:
	var error : Error = HandlerIonizedStardust.ref.consume_ionized_stardust(1)
	
	if error:
		return
	
	if state == Tiles.EMPTY:
		texture.texture = null
	
	if state == Tiles.STARDUST:
		texture.texture = texture_stardust
		var generated_stardust : int = randi_range(2, 5)
		HandlerStardust.ref.create_stardust(generated_stardust)
	
	if state == Tiles.CONSCIOUSNESS_CORE:
		texture.texture = texture_cc
		HandlerConsciousnessCore.ref.create_consciousness_core(1)


## Reset the tile to a Covered Empty state.
func reset_tile() -> void:
	texture.texture = texture_covered
	is_revealed = false
	state = Tiles.EMPTY