class_name AbacabaLevel extends Node3D

@export var abacaba_nodes : Array[AbacabaNode]
static var camera_on_focus : bool = false

@onready var game_camera: Camera3D = $GameCamera
@onready var win_text: Label3D = $WinText


func _ready() -> void:
	win_text.visible = false
	_get_abacabas_and_listen()


func _get_abacabas_and_listen() -> void:
	for child in get_children():
		if child is AbacabaNode:
			child._was_clicked.connect(_focus_camera)
			child._player_won.connect(_unfocus_camera)


func _focus_camera(abacaba_node : AbacabaNode) -> void:
	if camera_on_focus == false:
		camera_on_focus = true
		var camera_tween := create_tween().set_parallel(true)
		var final_pos : Vector3 = Vector3(abacaba_node.global_position.x, abacaba_node.global_position.y, 5.0)
		
		camera_tween.tween_property(game_camera, "global_position", final_pos, 1.0)


func _unfocus_camera() -> void:
	if camera_on_focus == true:
		camera_on_focus = false
		var camera_tween := create_tween().set_parallel(true)
		
		camera_tween.tween_property(game_camera, "global_position", Vector3(0.0, 0.0, 10.0), 1.0)
	_check_for_victory()


func _check_for_victory() -> void:
	var needed_amount := abacaba_nodes.size()
	var win_amount : int = 0
	
	for child in get_children():
		if child is AbacabaNode:
			if child.has_won == true:
				win_amount += 1
	
	print("Has won : ", win_amount, " | Needs : ", needed_amount)
	
	if win_amount == needed_amount:
		win_text.visible = true
	
