extends Node


func _on_back_pressed() -> void:
	SceneManager.start_menu_on_selection = false
	SceneManager._change_scene_to("MainMenu")


func _on_ajuda_pressed() -> void:
	pass # Replace with function body.
