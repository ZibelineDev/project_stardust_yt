extends TextureButton
## Dungeon Tile
##
## @experimental


##
var coordinates : String


##
func _on_pressed() -> void:
	print("Coordinates : %s" %coordinates)
