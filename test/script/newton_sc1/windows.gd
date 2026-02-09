extends Area2D

@export var interaction_type: String = "dialog"  # "dialog" или "teleport"
@export var dialog_text: String = "Тумбочка..а что в ней.?"
@export var target_scene_path: String = ""


func _ready():
	# Добавляем в группу для фильтрации
	add_to_group("interactable")
	
	# Соединяем сигналы
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node):
	if body.is_in_group("player"):
		body.set_interactable(self)

func _on_body_exited(body: Node):
	if body.is_in_group("player"):
		body.clear_interactable(self)

# Главный метод взаимодействия - будет переопределяться в дочерних классах
func interact(player: CharacterBody2D) -> void:
	var messages = PackedStringArray([
		"Кажется почти все уехали",
		"Интересно, почему стекло пропускает свет?",
		"Чем луч с той стороны",
		"Отличается от луча с этой?"
	])
	player.show_labels(messages)	

	#$Area2D/CollisionShape2D.disabled = true
