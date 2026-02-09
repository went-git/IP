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
		"Призма...",
		"Кажется их использовали ещё в Древней Греции",
		"...и Риме",
		"А сейчас пытаюся разложить свет",
		"Мне это пригодится"
	])
	player.show_labels(messages)	
	$NutonPrism.visible = false
	#$Area2D/CollisionShape2D.disabled = true
