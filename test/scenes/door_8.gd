extends Area2D

func _ready():
	# Соединяем сигналы
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node):
	# Проверяем, что вошел игрок
	if body.is_in_group("player"):
		body._remember_scene8(self)

func _on_body_exited(body: Node):
	# Проверяем, что вышел игрок
	if body.is_in_group("player"):
		body._forget_scene8(self)
