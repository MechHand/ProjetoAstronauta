extends Node


## Singleton required to change scenes quickly


## A collection of all relevant scenes in the project.
@onready var scene_collection : Dictionary = {
	"MainMenu" : "res://Scenes/GameMenu/game_menu.tscn",
	"TestScene1" : "res://Scenes/TestScenes/test_scene_1.tscn",
	"Abacaba" : "res://Scenes/AbacabaLevel/abacaba_level.tscn",
	"Acelerometro" : "res://Scenes/TestScenes/accelerometer_test.tscn",
	"Numeros" : "res://Scenes/NumberLevel/number_level.tscn"
}


## Function to call when needed to change scene. Needs a String compatible with some KEY in the scene_collection dictionary.
func _change_scene_to(scene_name : String) -> void:
	if scene_collection.get(scene_name) != null:
		print("Scene changed to : ", scene_collection.get(scene_name))
		get_tree().change_scene_to_file(scene_collection.get(scene_name))
	else:
		print("Invalid Scene!")
