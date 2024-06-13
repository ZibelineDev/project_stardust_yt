class_name ViewAchievement
extends View


@export
var packed_achievement_component : PackedScene

func _ready() -> void:
	super()
	_initialise_achievements_children()


func _initialise_achievements_children() -> void:
	var achievements : Array[Node] = HandlerAchievements.ref.get_children()
	
	for achievement : Achievement in achievements:
		_create_achievement_child(achievement)


func _create_achievement_child(achievement : Achievement) -> void:
	var achievement_component : CompoAchievement = (
			packed_achievement_component.instantiate() as CompoAchievement
	)
	
	achievement_component.inject_achievement_data(achievement)
	get_node("%AchievementsList").add_child(achievement_component)
