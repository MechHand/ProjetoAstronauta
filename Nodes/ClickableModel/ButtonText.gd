@tool extends Label3D

@onready var clickable_button : ClickableModel = get_parent()


func _ready() -> void:
	text = clickable_button.text_to_show


func _process(delta: float) -> void:
	if Engine.is_editor_hint() == true:
		text = clickable_button.text_to_show
