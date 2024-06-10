class_name ClickAnimButtonTexture extends TextureButton


var old_scale : Vector2
func _ready() -> void:
	pressed.connect(_anim)
	old_scale = scale


func _anim() -> void:
	var click_tween : Tween = create_tween()
	if click_tween:
		click_tween.set_trans(Tween.TRANS_CUBIC)
		click_tween.set_ease(Tween.EASE_OUT_IN)
		
		click_tween.stop()
		click_tween.tween_property(self, "scale", old_scale - Vector2(0.1, 0.1), 0.05)
		click_tween.play()
		
		await click_tween.finished
		
		click_tween.stop()
		click_tween.tween_property(self, "scale", old_scale, 0.05)
		click_tween.play()
		
		await click_tween.finished
		click_tween.stop()
		
		click_tween.kill()
