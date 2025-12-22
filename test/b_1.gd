extends Button

func _ready() -> void:
	# ПРОСТО устанавливаем размер шрифта
	add_theme_font_size_override("font_size", 5)
	size = Vector2(35, 13)
