extends WorldEnvironment


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	environment.adjustment_enabled = true
	_adjust_visuals()
	
	GameConfigurations.visuals_changed.connect(_adjust_visuals)





func _adjust_visuals() -> void:
	environment.adjustment_brightness = GameConfigurations.shineness_scale + 0.5
	environment.adjustment_contrast = GameConfigurations.contrast_scale + 0.5
	environment.adjustment_saturation = GameConfigurations.saturation_scale + 0.5
