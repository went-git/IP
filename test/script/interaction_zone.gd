extends Area2D

func _ready():
	# Соединяем сигналы
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node):
	# Проверяем, что вошел игрок
	if body.is_in_group("player"):
		# Вызываем метод у игрока
		if body.has_method("_on_interact_area_entered"):
			body._on_interact_area_entered(self)

func _on_body_exited(body: Node):
	# Проверяем, что вышел игрок
	if body.is_in_group("player"):
		# Вызываем метод у игрока
		if body.has_method("_on_interact_area_exited"):
			body._on_interact_area_exited(self)
