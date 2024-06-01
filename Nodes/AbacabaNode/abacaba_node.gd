class_name AbacabaNode extends Node3D

signal _was_clicked (abacaba_node : AbacabaNode)
signal _player_won

@export var star_particle : StarParticle

@export_category("Abacaba Rules")
@export var abacaba_level : AbacabaLevel
@export var correct_letter : String = "A"
@export_enum("Abelha","Baleia","Cachorro","Dado","Farol", "Gato","Jacaré","Laranja","Macaco","Nabo","Pato","Quadrado","Rato","Sapo","Taça","Vaca","Xadrez","Zabumba") var creature : String = "Cachorro"

static var creature_names : Array[String] = ["Abelha","Baleia","Cachorro","Dado","Farol", "Gato","Jacaré","Laranja","Macaco","Nabo","Pato","Quadrado","Rato","Sapo","Taça","Vaca","Xadrez","Zabumba"]
static var uncomplete_creature_names : Array[String] = ["_belha","__leia","__chorro","__do","__rol", "__to","__caré","__ranja","__caco","__bo","_to","___drado","__to","__po","__ça","__ca","__drez","__bumba"]

@onready var first_word: Label3D = %FirstWord
@onready var second_word: Label3D = %SecondWord
@onready var creature_sprite: Sprite3D = %CreatureSprite
@onready var creature_mesh: MeshInstance3D = %CreatureMesh
@onready var box_animations: AnimationPlayer = %BoxAnimations
@onready var word_hint: Label3D = %WordHint
@onready var first_letter_animation = $FirstWord/FirstLetterAnimation
@onready var second_letter_animation = $SecondWord/SecondLetterAnimation


@onready var creature_images : Dictionary = {
	"Cachorro" : load("res://Nodes/AbacabaNode/PlaceholdImgs/cachorro.png"),
	"Gato" : load("res://Nodes/AbacabaNode/PlaceholdImgs/gato.png"),
	"Pato" : load("res://Nodes/AbacabaNode/PlaceholdImgs/pato.png")
}

@onready var creature_meshes : Dictionary = {
	"Abelha" : load("res://Resources/AbacabaLevel_Assets/Models/BeeModel_abelha.res"),
	"Baleia" : load("res://Resources/AbacabaLevel_Assets/Models/WhaleModel_Cube_003.res"),
	"Cachorro" : load("res://Resources/AbacabaLevel_Assets/Models/DogModel_Cylinder_004.res"),
	"Dado" : load("res://Resources/AbacabaLevel_Assets/Models/DiceModel_dado.res"),
	"Farol" : load("res://Resources/AbacabaLevel_Assets/Models/LighhouseModel_farol.res"),
	"Gato" : load("res://Resources/AbacabaLevel_Assets/Models/CatModel_Cube_002.res"),
	"Jacaré" : load("res://Resources/AbacabaLevel_Assets/Models/AlligatorModel_jacaré.res"),
	"Laranja" : load("res://Resources/AbacabaLevel_Assets/Models/OrangeModel_laranja.res"),
	"Macaco" : load("res://Resources/AbacabaLevel_Assets/Models/MonkeyModel_Cube_004.res"),
	"Nabo" : load("res://Resources/AbacabaLevel_Assets/Models/NaboModel_nabo.res"),
	"Pato" : load("res://Resources/AbacabaLevel_Assets/Models/DuckModel_Cube_001.res"),
	"Quadrado" : load("res://Resources/AbacabaLevel_Assets/Models/SquareModel_quadrado.res"),
	"Rato" : load("res://Resources/AbacabaLevel_Assets/Models/RatModel_Cube.res"),
	"Sapo" : load("res://Resources/AbacabaLevel_Assets/Models/FrogModel_sapo.res"),
	"Taça" : load("res://Resources/AbacabaLevel_Assets/Models/GobletModel_TaçaMesh.res"),
	"Vaca" : load("res://Resources/AbacabaLevel_Assets/Models/CowModel_VacaMesh.res"),
	"Xadrez" : load("res://Resources/AbacabaLevel_Assets/Models/ChessModel_xadrez.res"),
	"Zabumba" : load("res://Resources/AbacabaLevel_Assets/Models/ZabumbaModel_Zabumba.res")
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


func _ready() -> void:
	star_particle._emit_particle()
	abacaba_level.reset_game.connect(_restart_node)
	_restart_node()


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
	
	word_hint.text = uncomplete_creature_names[creature_names.find(creature)]


func _handle_win() -> void:
	has_won = true
	await get_tree().create_timer(0.5).timeout
	word_hint.text = creature_names[creature_names.find(creature)]
	
	await get_tree().create_timer(1.5).timeout
	
	visible = false
	_player_won.emit()


func _show_creature() -> void:
	first_word.visible = true
	second_word.visible = true
	box_animations.play("Opening")
	
	creature_sprite.texture = creature_images.get(creature)
	creature_mesh.mesh = creature_meshes.get(creature)
	
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
	print(name, " Has won : ", has_won)
	if first_word.visible == true and has_won == false:
		if event is InputEventMouseButton:
				if event.pressed == true:
					if correct_word == 0:
						print("Correct word! ", "(", first_word.text, ")")
						first_letter_animation.play("FirstLetterUp")
						_handle_win()
					else:
						print("Wrong word!")


func _on_second_word_collision_input_event(camera: Node, event: InputEvent, position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if second_word.visible == true and has_won == false:
		if event is InputEventMouseButton:
				if event.pressed == true:
					if correct_word == 1:
						print("Correct word! ", "(", second_word.text, ")")
						second_letter_animation.play("SecondLetterUp")
						_handle_win()
					else:
						print("Wrong word!")


func _restart_node() -> void:
	visible = true
	has_won = false
	creature_mesh.mesh = null
	has_focus = false
	box_animations.play(&"RESET")
