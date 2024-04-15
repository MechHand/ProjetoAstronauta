extends Area3D

@export_category("Ball Parameters")
@export_enum("Red", "Green", "Blue") var color_ball : String = "Red"
@export var mesh_color : Color

@onready var pipe: MeshInstance3D = $Pipe

func _ready() -> void:
	pipe.mesh.material.albedo_color = mesh_color


func _on_body_entered(body: Node3D) -> void:
	print(body)
	if body is ColorBall:
		if body.color_ball == color_ball:
			body.is_stored = true
			body.visible = false
			print("Right Color!!!")
