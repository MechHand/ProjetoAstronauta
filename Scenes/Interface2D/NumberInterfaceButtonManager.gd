extends Node

@onready var click_sound = $"../ClickSound"
@onready var tutorial_sound = $"../TutorialSound"

func _on_back_pressed() -> void:
	SceneManager.start_menu_on_selection = false
	SceneManager._change_scene_to("MainMenu")


func _on_confirmar_pressed():
	click_sound.play()


func _on_ajuda_pressed():
	click_sound.play()
	tutorial_sound.play()
