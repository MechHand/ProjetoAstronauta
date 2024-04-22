class_name NumberModel extends Node3D

@export_category("Numbers Model")
@export var number_array : Array[MeshInstance3D]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for number in number_array:
		number.visible = false


func _show_number(index : int) -> void:
	for i in number_array.size():
		if i == index:
			number_array[i].visible = true
		else:
			number_array[i].visible = false
