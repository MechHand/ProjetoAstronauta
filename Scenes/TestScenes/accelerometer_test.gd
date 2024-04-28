extends CanvasLayer

const MAX_Y : float = 288.0
const MAX_X : float = 288.0
const GRAVITY : float = 9.8


@onready var accelerometer_text = %AccelerometerText
@onready var invert_xbtn = %InvertXbtn
@onready var invert_ybtn = %InvertYbtn
@onready var invert_zbtn = %InvertZbtn
@onready var multiplier_slider: HSlider = %MultiplierSlider
@onready var camera_3d = %Camera3D
@onready var exemple_mesh = %ExempleMesh


var invert_x : bool = false
var invert_y : bool = false
var invert_z : bool = false
var multiplier : float = 1.0


func _process(delta):
	var event = Input
	if event:
		var accelerometer := event.get_accelerometer()
		
		accelerometer.y /= GRAVITY * MAX_Y
		accelerometer.x /= GRAVITY * MAX_X
		
		if invert_x == true:
			accelerometer.x *= -1 * multiplier
		if invert_y == true:
			accelerometer.y *= -1 * multiplier
		if invert_z == true:
			accelerometer.z *= -1 * multiplier
		
		accelerometer_text.text = str(
			"Accelerometer value : ", accelerometer, "\n",
			"Multiplier : ", multiplier, "\n",
			"Is tilting = ", accelerometer != Vector3.ZERO,
		)
		exemple_mesh.rotation_degrees = accelerometer


func _on_invert_xbtn_toggled(toggled_on):
	invert_x = toggled_on
	print(invert_x)


func _on_invert_ybtn_toggled(toggled_on):
	invert_y = toggled_on
	print(invert_y)


func _on_invert_zbtn_toggled(toggled_on):
	invert_z = toggled_on
	print(invert_z)
	


func _on_multiplier_slider_drag_ended(value_changed: bool) -> void:
	if value_changed == true:
		multiplier = multiplier_slider.value

