class_name NumberLevel extends Node3D

@onready var math_question_label: Label3D = $MathQuestionLabel
@onready var deposit_area_1: DepositArea = $DepositArea1
@onready var deposit_area_2: DepositArea = $DepositArea2

var first_num : int
var second_num : int


func _ready() -> void:
	_generate_math_calc()
	
	deposit_area_1.planets_inside_changed.connect(_verify_planed_stored)
	deposit_area_2.planets_inside_changed.connect(_verify_planed_stored)


func _generate_math_calc() -> void:
	first_num = randi_range(1,5)
	second_num = randi_range(1,5)
	
	math_question_label.text = str(first_num, " + ", second_num, " = ?")


func _verify_planed_stored() -> void:
	if (deposit_area_1.planets_inside + deposit_area_2.planets_inside) == (first_num + second_num):
		print("YAAAYYY ACERTOU!")
		
		math_question_label.text = str(
			first_num, " + ", second_num, " = ", (first_num + second_num), "\n",
			"Acertou!"
		)
