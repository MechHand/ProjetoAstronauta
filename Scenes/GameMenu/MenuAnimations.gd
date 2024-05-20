extends AnimationPlayer

@export var iniciar_button : ClickableModel
@export var options_button : ClickableModel
@export var return_button : ClickableModel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#iniciar_button.was_clicked.connect(_play_level_select_anim)
	#options_button.was_clicked.connect(_play_options_select_anim)
	#return_button.was_clicked.connect(_play_return_select_anim)
	
	await animation_finished
	
	if SceneManager.start_menu_on_selection == true:
		_play_level_select_anim()


func _play_level_select_anim() -> void:
	play(&"LevelSelection")
	SceneManager.start_menu_on_selection = false


func _play_options_select_anim() -> void:
	play(&"Options")


func _play_return_select_anim() -> void:
	play_backwards(&"LevelSelection")


func _on_jogar_pressed() -> void:
	play(&"LevelSelection")
	SceneManager.start_menu_on_selection = false


func _on_settings_pressed() -> void:
	play(&"Options")
