class_name IonizedStardustSiftingTile
extends TextureButton
## Ionized Stardust Sifting game Tile.

## Different Tile States.
enum Tiles {
	EMPTY,
	STARDUST,
	CONSCIOUSNESS_CORE,
	LIQUID_STARDUST,
}

## Emitted when the tile is revelead.
signal tile_revealed

## Covered tile Texture.
@export var texture_covered : Texture2D
## Uncovered Stardust Tile.
@export var texture_stardust : Texture2D
## Uncovered Liquid Stardust Tile.
@export var texture_liquid_stardust : Texture2D
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
	reveal(1)


## Try to reveal the Tile.
func reveal(cost : int) -> void:
	if is_revealed:
		return
	
	var error : Error = HandlerIonizedStardust.ref.consume_ionized_stardust(cost)
	
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
	
	if state == Tiles.LIQUID_STARDUST:
		texture.texture = texture_liquid_stardust
		var quantity : int = randi_range(2, 3)
		HandlerLiquidStardust.ref.create_liquid_stardust(quantity)
	
	is_revealed = true
	tile_revealed.emit()



## Reset the tile to a Covered Empty state.
func reset_tile() -> void:
	texture.texture = texture_covered
	is_revealed = false
	state = Tiles.EMPTY
