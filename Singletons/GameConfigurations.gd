extends Node


const MAX_DB : float = 10.0
const MIN_DB : float = -10.0


static var general_volume : float = 0.5
static var music_volume : float = 0.5
static var effects_volume : float = 0.5
static var narration_volume : float = 0.5

static var bass_volume : float = 0.5
static var sharp_volume : float = 0.5

static var saturation_scale : float = 0.5
static var contrast_scale : float = 0.5
static var shineness_scale : float = 0.5

signal visuals_changed

func _update_general_volume(value : float) -> void:
	AudioServer.set_bus_volume_db(0, lerpf(MIN_DB, MAX_DB, value))
	
	if value < 0.1:
		AudioServer.set_bus_mute(0, true)
	else:
		AudioServer.set_bus_mute(0, false)

func _update_music_volume(value : float) -> void:
	AudioServer.set_bus_volume_db(1, lerpf(MIN_DB, MAX_DB, value))
	
	if value < 0.1:
		AudioServer.set_bus_mute(1, true)
	else:
		AudioServer.set_bus_mute(1, false)

func _update_effects_volume(value : float) -> void:
	AudioServer.set_bus_volume_db(2, lerpf(MIN_DB, MAX_DB, value))
	
	if value < 0.1:
		AudioServer.set_bus_mute(2, true)
	else:
		AudioServer.set_bus_mute(2, false)

func _update_narration_volume(value : float) -> void:
	AudioServer.set_bus_volume_db(3, lerpf(MIN_DB, MAX_DB, value))
	
	if value < 0.1:
		AudioServer.set_bus_mute(3, true)
	else:
		AudioServer.set_bus_mute(3, false)
