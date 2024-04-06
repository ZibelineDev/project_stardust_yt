extends TextureButton
## Dungeon Tile
##
## @experimental


##
@export var texture_node : TextureRect

@export var texture_stardust : Texture

@export var texture_empty : Texture

##
var coordinates : String
##
var content : ViewDugeon.Tiles = ViewDugeon.Tiles.EMPTY

var is_revealed : bool = false


##
func _on_pressed() -> void:
	print("Coordinates : %s" %coordinates)
	
	if is_revealed:
		return
	
	if content == ViewDugeon.Tiles.STARDUST:
		texture_node.texture = texture_stardust
		
		is_revealed = true
		return
	
	if content == ViewDugeon.Tiles.EMPTY:
		texture_node.texture = texture_empty
		
		is_revealed = true
		
		return
