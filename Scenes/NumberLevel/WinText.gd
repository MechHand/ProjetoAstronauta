extends Label3D


func _ready() -> void:
	visible = false


func _on_number_level_won_game() -> void:
	visible = true
