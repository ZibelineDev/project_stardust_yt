class_name ViewSiftingMinigame
extends Control
## Ionized Stardust Sifting Minigame view.

## Reference to the Packed Scene containing a tile.
@export var packed_tile : PackedScene

## List of tiles
@export var tiles : Dictionary


##
func _ready() -> void:
	generate_tiles()
	generate_loot()


## Generate 25 tiles.
func generate_tiles() -> void:
	for x : int in 5:
		for y : int in 5:
			var key : String = "%s%s" %[x, y]
			
			var node : IonizedStardustSiftingTile = packed_tile.instantiate() as IonizedStardustSiftingTile
			
			node.coordinates = key
			node.state = IonizedStardustSiftingTile.Tiles.EMPTY
			
			get_node("GridContainer").add_child(node)
			
			tiles[key] = node


## Generates random loot.
func generate_loot() -> void:
	var random_tile : int = -1
	
	if randi_range(0, 99) == 99:
		random_tile = randi_range(1, 25)
		@warning_ignore("integer_division")
		var x : int = random_tile / 5
		var y : int = random_tile % 5
		var key : String = "%s%s" %[x, y]
		
		tiles[key].state = IonizedStardustSiftingTile.Tiles.CONSCIOUSNESS_CORE
	
	const BASE_STARDUST : int = 5
	var stardust : int = randi_range(0, 5) + BASE_STARDUST
	
	var counter : int = 0
	
	while counter < stardust:
		random_tile = randi_range(0, 24)
		@warning_ignore("integer_division")
		var x : int = random_tile / 5
		var y : int = random_tile % 5
		var key : String = "%s%s" %[x, y]
		
		if tiles[key].state == IonizedStardustSiftingTile.Tiles.EMPTY:
			tiles[key].state = IonizedStardustSiftingTile.Tiles.STARDUST
			counter += 1
