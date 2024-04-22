class_name ClickableModel extends Node3D

signal was_clicked 


## Class that already have a configuration to change scenes.
@export_category("Parameters")
@export var text_to_show : String = "Iniciar"
@export var area_to_verify : Area3D
@export var animation_player : AnimationPlayer
@export var should_change_scene : bool = false
@export_category("Scene Configuration")
## The scene that the game is suposed to change.
@export var scene_to_change : String


## Connects the pressed signal to call the SceneManager autoload.
func _ready() -> void:
	animation_player.speed_scale += randf_range(-0.05, 0.05)
	area_to_verify.input_event.connect(_clicked)


## When pressed, change to the scene stored in [param scene_to_change].
func _clicked(camera: Node, event: InputEvent, position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed == true:
		was_clicked.emit()
		if should_change_scene == true:
			SceneManager._change_scene_to(scene_to_change)
