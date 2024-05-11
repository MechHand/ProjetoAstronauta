extends Label3D


func _ready() -> void:
	visible = false


func _on_number_level_won_game() -> void:
	text = "Acertou!"
	visible = true
	await  get_tree().create_timer(1).timeout
	visible = false


func _on_number_level_try_again():
	text = "Tente Novamente!"
	visible = true
	await get_tree().create_timer(3).timeout
	visible = false
