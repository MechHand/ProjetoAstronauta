class_name AbacabaNode extends Node3D

signal _was_clicked (abacaba_node : AbacabaNode)
signal _player_won

@export_category("Abacaba Rules")
@export var correct_letter : String = "A"
@export_enum("Cachorro", "Gato", "Pato") var creature : String = "Cachorro"

@onready var first_word: Label3D = %FirstWord
@onready var second_word: Label3D = %SecondWord
@onready var creature_sprite: Sprite3D = %CreatureSprite

@onready var creature_images : Dictionary = {
	"Cachorro" : load("res://Nodes/AbacabaNode/PlaceholdImgs/cachorro.png"),
	"Gato" : load("res://Nodes/AbacabaNode/PlaceholdImgs/gato.png"),
	"Pato" : load("res://Nodes/AbacabaNode/PlaceholdImgs/pato.png")
}

var has_focus : bool = false
var correct_word : int = 0
var has_won : bool = false

const letter_array : Array[String] = [
	"A",
	"BA",
	"CA",
	"DA",
	"FA",
	"GA",
	"JA",
	"LA",
	"MA",
	"NA",
	"PA",
	"QUA",
	"RA",
	"SA",
	"TA",
	"VA",
	"XA",
	"ZA",
]


## Return a letter that is not the current Abacaba letter.
static func _get_random_letter(except : String = "A") -> String:
	randomize()
	var avaiable_letters : Array[String]
	
	for letter in letter_array:
		if letter != except:
			avaiable_letters.append(letter)
	
	var random_letter : String = avaiable_letters.pick_random()
	#print(avaiable_letters)
	#print(random_letter)
	
	return random_letter


func _ready() -> void:
	_set_words()


func _set_words() -> void:
	randomize()
	var choosen_word : int = randi_range(0, 1)
	
	match choosen_word:
		0:
			first_word.text = correct_letter
			second_word.text = _get_random_letter(correct_letter)
		1:
			second_word.text = correct_letter
			first_word.text = _get_random_letter(correct_letter)
	
	correct_word = choosen_word
	first_word.visible = false
	second_word.visible = false


func _handle_win() -> void:
	visible = false
	has_won = true
	_player_won.emit()


func _show_creature() -> void:
	first_word.visible = true
	second_word.visible = true
	
	creature_sprite.texture = creature_images.get(creature)
	
	_was_clicked.emit(self)


func _input(event: InputEvent) -> void:
	if has_focus == true and AbacabaLevel.camera_on_focus == false and has_won == false:
		if event is InputEventMouseButton:
			if event.pressed == true:
				_show_creature()
		if event is InputEventScreenTouch:
			_show_creature()


func _on_mouse_collision_mouse_entered() -> void:
	has_focus = true
	print("Mouse on : ", name)

func _on_mouse_collision_mouse_exited() -> void:
	has_focus = false
	print("Mouse out of : ", name)


func _on_first_word_collision_input_event(camera: Node, event: InputEvent, position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if first_word.visible == true and has_won == false:
		if event is InputEventMouseButton:
				if event.pressed == true:
					if correct_word == 0:
						print("Correct word! ", "(", first_word.text, ")")
						_handle_win()
					else:
						print("Wrong word!")


func _on_second_word_collision_input_event(camera: Node, event: InputEvent, position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if second_word.visible == true and has_won == false:
		if event is InputEventMouseButton:
				if event.pressed == true:
					if correct_word == 1:
						print("Correct word! ", "(", second_word.text, ")")
						_handle_win()
					else:
						print("Wrong word!")