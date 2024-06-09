extends Node
@onready var click_sound = $"../ClickSound"
@onready var selecione_fase = $"../SelecioneFase"

func _on_abacaba_selecionar_pressed() -> void:
	click_sound.play()
	SceneManager._change_scene_to("Abacaba")
	


func _on_numeros_selecionar_pressed() -> void:
	click_sound.play()
	SceneManager._change_scene_to("Numeros")


func _on_cores_selecionar_pressed() -> void:
	SceneManager._change_scene_to("Cores")


func _on_back_pressed() -> void:
	click_sound.play()
	


func _on_ajuda_pressed() -> void:
	selecione_fase.play()
