extends Node3D

@export_category("Nodes")
@export var first_model : NumberModel
@export var second_model : NumberModel
@export var operation_digit : Label3D


func _prepare_digits(first_number : int, second_number : int, operation : String) -> void:
	first_model._show_number(first_number)
	second_model._show_number(second_number)
	operation_digit.text = operation
