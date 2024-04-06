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
	print("Coordinates : %s" %coordinates)
	
	if state == Tiles.EMPTY:
		texture.texture = null
	
	if state == Tiles.STARDUST:
		texture.texture = texture_stardust
	
	if state == Tiles.CONSCIOUSNESS_CORE:
		texture.texture = texture_cc
