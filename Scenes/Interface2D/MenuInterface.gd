extends Control

@onready var click_sound = $ClickSound
@onready var selecione_jogar = $SelecioneJogar

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_jogar_pressed():
	click_sound.play()


func _on_settings_pressed():
	click_sound.play()


func _on_ajuda_pressed():
	click_sound.play()
	selecione_jogar.play()