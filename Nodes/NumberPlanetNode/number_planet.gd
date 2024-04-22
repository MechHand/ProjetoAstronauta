class_name NumberPlanet extends RigidBody3D

signal stopped_being_dragged
signal started_being_dragged

@export_category("Visual Parameters")
@export var min_hold_size : float = 0.5
@export var max_hold_size : float = 1.0
@onready var icosphere: MeshInstance3D = $Icosphere
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var can_be_dragged : bool = true
var is_on_sleep_area : bool = true
var is_being_dragged : bool = false
var is_stored : bool = false

var pos_x : float
var pos_y : float

var original_pos : Vector3

@onready var area_3d: Area3D = $Area3D


func _ready() -> void:
	original_pos = global_position
	animation_player.speed_scale = randf_range(0.05, 0.25)


func _physics_process(delta: float) -> void:
	global_position.z = 0.0
	
	if is_being_dragged == true:
		global_position = lerp(global_position, Vector3(pos_x, pos_y, 0.0), 0.96)
		icosphere.scale = lerp(icosphere.scale, Vector3(max_hold_size, max_hold_size, max_hold_size), 0.13)
	else:
		icosphere.scale = lerp(icosphere.scale, Vector3(min_hold_size, min_hold_size, min_hold_size), 0.13)
	
	if is_on_sleep_area == true or is_being_dragged == true:
		if is_stored == false:
			freeze = true
	else:
		freeze = false


func _on_area_3d_input_event(camera: Node, event: InputEvent, position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if can_be_dragged == true and event.pressed == true:
			is_being_dragged = true
			started_being_dragged.emit()
			area_3d.scale = Vector3(2.0,2.0,2.0)
		if can_be_dragged == true and event.pressed == false:
			is_being_dragged = false
			stopped_being_dragged.emit()
			area_3d.scale = Vector3(1.0,1.0,1.0)
	
	if event is InputEvent:
		pos_x = position.x
		pos_y = position.y


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("SleepArea"):
		is_on_sleep_area = true
		var tween_pos : Tween = create_tween().set_parallel(true)
		
		tween_pos.tween_property(self, "global_position", original_pos, 0.25)


func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.is_in_group("SleepArea"):
		is_on_sleep_area = false
		print("Exited of ",area.name)
