extends Node2D

# Настройки предмета
@export var interaction_text: String = "Вы нашли предмет!"

func _ready():
	# Добавляем себя в группу интерактивных объектов
	add_to_group("interactable")
	
	# Получаем существующий CollisionShape2D для копирования его формы
	var existing_collision_shape = get_node_or_null("CollisionShape2D")
	var shape_to_use = null
	
	if existing_collision_shape and existing_collision_shape.shape:
		# Используем существующую форму
		shape_to_use = existing_collision_shape.shape.duplicate()
		print("Используем существующую форму коллизии")
	
	# Создаем Area2D для взаимодействия
	var area = Area2D.new()
	area.name = "InteractionArea"
	
	# ВАЖНО: Настраиваем слои коллизий ПРАВИЛЬНО
	area.collision_layer = 2  # Предмет находится на слое 2
	area.collision_mask = 0   # Не нужно никого обнаруживать
	
	# Добавляем CollisionShape2D с скопированной формой
	var collision = CollisionShape2D.new()
	collision.shape = shape_to_use
	area.add_child(collision)
	
	add_child(area)
	
	print("Предмет создан: ", name)
	print("Слой предмета: ", area.collision_layer)
	print("Маска предмета: ", area.collision_mask)

# Метод взаимодействия
func interact(_interactor: Node):
	print(interaction_text)
	
	
