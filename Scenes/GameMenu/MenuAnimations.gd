extends AnimationPlayer

@export var iniciar_button : ClickableModel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	iniciar_button.was_clicked.connect(_play_level_select_anim)


func _play_level_select_anim() -> void:
	play(&"LevelSelection")
