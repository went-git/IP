extends PopupPanel
# PopupWindow.gd (присоедините к корневому узлу окна)

func _ready() -> void:
	# Закрыть при нажатии на крестик
	close_requested.connect(hide)
	
func _on_close_button_pressed() -> void:
	hide()
