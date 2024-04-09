class_name ViewSiftingMinigame
extends View
## Ionized Stardust Sifting Minigame view.

## Automation Timer.
@export var automation_timer : Timer
## Reference to the Packed Scene containing a tile.
@export var packed_tile : PackedScene
## List of tiles
@export var tiles : Dictionary
## Whether or not the game is revealing tiles automatically. 
var is_automated : bool = false


##
func _ready() -> void:
	super()
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
		random_tile = randi_range(0, 24)
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


## Reset the tiles to Empty & Covered State.
func reset_tiles() -> void:
	for x : int in 5:
		for y : int in 5:
			var key : String = "%s%s" %[x, y]
			
			@warning_ignore("unsafe_method_access")
			tiles[key].reset_tile()


## Reset the tiles & regenerate new loots.
func regenerate_grid() -> void:
	reset_tiles()
	generate_loot()


## Triggered when the Reset Button is Pressed.
func _on_reset_button_pressed() -> void:
	regenerate_grid()


## Automation tried to reveal a Tile.
func automation_tile_reveal() -> void:
	for tile_index : int in 25:
		@warning_ignore("integer_division")
		var x : int = tile_index / 5
		var y : int = tile_index % 5
		var key : String = "%s%s" %[x, y]
		
		if not (tiles[key] as IonizedStardustSiftingTile).is_revealed:
			(tiles[key] as IonizedStardustSiftingTile).reveal(3)
			return
	
	regenerate_grid()
	automation_tile_reveal()


## Triggered when the automation timers completes a loop.
func _on_automation_timer_timeout() -> void:
	automation_tile_reveal()


## Triggered when the automation button is toggled.
func _on_automation_check_button_toggled(toggled_on: bool) -> void:
	is_automated = toggled_on
	
	if toggled_on:
		automation_timer.start()
	
	if not toggled_on:
		automation_timer.stop()
