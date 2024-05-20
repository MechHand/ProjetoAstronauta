extends Node

@export_category("External Nodes")
@export var menu_animation_node : AnimationPlayer

@onready var confirm_button: Button = %ConfirmButton

@onready var general_volume_slider: HSlider = %GeneralVolumeSlider
@onready var music_volume_slider: HSlider = %MusicVolumeSlider
@onready var effects_volume_slider: HSlider = %EffectsVolumeSlider
@onready var narration_volume_slider: HSlider = %NarrationVolumeSlider

@onready var bass_volume_slider: HSlider = %BassVolumeSlider
@onready var sharp_volume_slider: HSlider = %SharpVolumeSlider

@onready var saturation_scale_slider: HSlider = %SaturationScaleSlider
@onready var contrast_scale_slider: HSlider = %ContrastScaleSlider
@onready var shineness_scale_slider: HSlider = %ShinenessScaleSlider


func _ready() -> void:
	SceneManager.abacaba_dialogue_played = false
	
	general_volume_slider.value = GameConfigurations.general_volume
	music_volume_slider.value = GameConfigurations.music_volume
	effects_volume_slider.value = GameConfigurations.effects_volume
	narration_volume_slider.value = GameConfigurations.narration_volume
	
	saturation_scale_slider.value = GameConfigurations.saturation_scale
	contrast_scale_slider.value = GameConfigurations.contrast_scale
	shineness_scale_slider.value = GameConfigurations.shineness_scale


func _on_confirm_button_pressed() -> void:
	menu_animation_node.play_backwards(&"Options")


func _on_general_volume_slider_value_changed(value: float) -> void:
	GameConfigurations._update_general_volume(value)

func _on_music_volume_slider_value_changed(value: float) -> void:
	GameConfigurations._update_music_volume(value)

func _on_effects_volume_slider_value_changed(value: float) -> void:
	GameConfigurations._update_effects_volume(value)

func _on_narration_volume_slider_value_changed(value: float) -> void:
	GameConfigurations._update_narration_volume(value)


func _on_saturation_scale_slider_value_changed(value: float) -> void:
	GameConfigurations.saturation_scale = value
	GameConfigurations.visuals_changed.emit()

func _on_contrast_scale_slider_value_changed(value: float) -> void:
	GameConfigurations.contrast_scale = value
	GameConfigurations.visuals_changed.emit()

func _on_shineness_scale_slider_value_changed(value: float) -> void:
	GameConfigurations.shineness_scale = value
	GameConfigurations.visuals_changed.emit()
