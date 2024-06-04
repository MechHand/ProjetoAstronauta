extends Node
@onready var click_sound = $"../ClickSound"

func _on_abacaba_selecionar_pressed() -> void:
	SceneManager._change_scene_to("Abacaba")
	click_sound.play()
	


func _on_numeros_selecionar_pressed() -> void:
	SceneManager._change_scene_to("Numeros")
	click_sound.play()


func _on_cores_selecionar_pressed() -> void:
	SceneManager._change_scene_to("Cores")


func _on_back_pressed() -> void:
	click_sound.play()
	


func _on_ajuda_pressed() -> void:
	pass # Replace with function body.
