class_name NumberLevel extends Node3D

signal won_game
signal try_again

@onready var math_question_label: Label3D = $MathQuestionLabel
@onready var deposit_area_1: DepositArea = $DepositArea1

var first_num : int
var second_num : int

@onready var math_question_node: Node3D = $MathQuestionNode
@onready var audio_stream_player = $AudioStreamPlayer

func _ready() -> void:
	_generate_math_calc()
	audio_stream_player.play()
	
	#deposit_area_1.planets_inside_changed.connect(_verify_planed_stored)


func _generate_math_calc() -> void:
	first_num = randi_range(1,5)
	second_num = randi_range(1,5)
	
	math_question_node._prepare_digits(first_num, second_num, "+")
	#math_question_label.text = str(first_num, " + ", second_num, " = ?")


func _verify_planed_stored() -> void:
	if (deposit_area_1.planets_inside) == (first_num + second_num):
		won_game.emit()
		print("YAAAYYY ACERTOU!")
		
		math_question_label.text = str(
			first_num, " + ", second_num, " = ", (first_num + second_num), "\n",
			"Acertou!"
		
		)
	else:
		try_again.emit()
