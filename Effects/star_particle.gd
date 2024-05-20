class_name StarParticle
extends Node3D

@onready var star_particle = $GPUParticles3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _emit_particle():
	star_particle.emitting = true
	await get_tree().create_timer(0.1).timeout
	star_particle.emitting = false
	
