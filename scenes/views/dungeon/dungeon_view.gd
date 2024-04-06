extends Control
## Dungeon
##
## @experimental


##
@export var scene_dungeon_tile : PackedScene
##
@export var dungeon_container : GridContainer

##
var dungeon_tiles : Dictionary


##
func _ready() -> void:
	dungeon_tiles.clear()
	
	for x in 5:
		for y in 5:
			var node : TextureButton = scene_dungeon_tile.instantiate() as TextureButton
			dungeon_container.add_child(node)
			
			node.coordinates = "%s%s" %[x, y]
			
			dungeon_tiles[str(x+y)] = node
