class_name AbacabaLevel extends Node3D

signal reset_game

@export var abacaba_nodes : Array[AbacabaNode]
static var camera_on_focus : bool = false

@onready var game_camera: Camera3D = $GameCamera
@onready var win_text: Label3D = $WinText
@onready var audio_stream_player = $AudioStreamPlayer

var selected_words : Array[String]

var game_started_once : bool = false

func _ready() -> void:
	_randomize_words(2)
	_randomize_words(1)
	_randomize_words(0)
	
	win_text.visible = false
	
	if game_started_once == false:
		game_started_once = true
		_get_abacabas_and_listen()
		audio_stream_player.play()


func _randomize_words(abacaba_index : int) -> void:
	var selected_letter : String = abacaba_nodes[abacaba_index].letter_array.pick_random()
	var letter_index : int = abacaba_nodes[abacaba_index].letter_array.find(selected_letter)
	
	if (selected_words.has(selected_letter) == true):
		_randomize_words(abacaba_index)
	else:
		abacaba_nodes[abacaba_index].correct_letter = selected_letter
		abacaba_nodes[abacaba_index].creature = abacaba_nodes[abacaba_index].creature_names[letter_index]
		
		print(
			"Selected Letter : ", selected_letter, "\n",
			"Letter Index : ", letter_index
		)
		
		abacaba_nodes[abacaba_index]._set_words()
		
		selected_words.append(selected_letter)


func _get_abacabas_and_listen() -> void:
	for child in get_children():
		if child is AbacabaNode:
			child._was_clicked.connect(_focus_camera)
			child._player_won.connect(_unfocus_camera)


func _focus_camera(abacaba_node : AbacabaNode) -> void:
	if camera_on_focus == false:
		camera_on_focus = true
		var camera_tween := create_tween().set_parallel(true)
		var final_pos : Vector3 = Vector3(abacaba_node.global_position.x, abacaba_node.global_position.y +5, 20.0)
		
		camera_tween.set_trans(Tween.TRANS_CUBIC)
		camera_tween.set_ease(Tween.EASE_OUT)
		
		camera_tween.tween_property(game_camera, "global_position", final_pos, 1)


func _unfocus_camera() -> void:
	if camera_on_focus == true:
		camera_on_focus = false
		var camera_tween := create_tween().set_parallel(true)
		
		camera_tween.set_trans(Tween.TRANS_CUBIC)
		camera_tween.set_ease(Tween.EASE_OUT)
		
		camera_tween.tween_property(game_camera, "global_position", Vector3(0.0, 0.0, 30.0), 1)
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
		
		await get_tree().create_timer(3.0).timeout
		
		_unfocus_camera()
		reset_game.emit()
		
		selected_words.clear()
		_ready()
