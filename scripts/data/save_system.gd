class_name SaveSystem
## Save manager.

## Path of the file we want to save & load.
const PATH : String = "user://save.tres"
## Whether or not we should load the game.
const SHOULD_LOAD : bool = false
## Maximum offline time in seconds.
const MAX_OFFLINE_TIME : int = 3600 * 24


## Save Game.ref.data object in a save file.
static func save_data() -> void:
	Game.ref.data.save_time = int(Time.get_unix_time_from_system())
	ResourceSaver.save(Game.ref.data, PATH)


## Loads the data and overrides Game.ref.data object.
static func load_data() -> void:
	if not SHOULD_LOAD:
		return
	
	if ResourceLoader.exists(PATH):
		Game.ref.data = load(PATH)


static func offline_time() -> int:
	if Game.ref.data.save_time <= 0:
		return 0
	
	var save_time : int = Game.ref.data.save_time
	var load_time : int = int(Time.get_unix_time_from_system())
	
	if load_time <= save_time:
		return 0
	
	var delta_time : int = load_time - save_time
	
	if delta_time > MAX_OFFLINE_TIME:
		delta_time = MAX_OFFLINE_TIME
	
	return delta_time
