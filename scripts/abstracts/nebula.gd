class_name Nebula
extends Node
## Abstract class containing the common features of all Nebulas.

signal composition_updated

## Name of the Nebula.
var given_name : String = "Unnamed Nebulas"
## Index of the Nebula in Data.
var data_index : int = -1
## Amount of stardust inside the Nebula.
var stardust : int = 0
## Amount of stardust the nebula attracts every seconds.
var stardust_consumed : int = 0


## Tries to consume Stardust.
func _on_consume_stardust() -> void:
	var error : Error = HandlerStardust.ref.consume_stardust(stardust_consumed)
	
	if error:
		return
	
	stardust += stardust_consumed
	Game.ref.data.nebulas[data_index].stardust = stardust
	
	composition_updated.emit()
