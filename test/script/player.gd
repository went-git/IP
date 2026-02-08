extends CharacterBody2D

@export var speed: float = 70.0
@export var gravity: float = 980.0
@onready var _animation_player = $AnimationPlayer
@onready var label = $Label

var current_interactable: Node = null

func _ready():
	label.hide()

func _physics_process(delta):
	# Взаимодействие с предметами
	if Input.is_action_just_pressed("interact") and current_interactable != null:
		current_interactable.interact(self)
	
	
	# Движение
	var direction = 0
	
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		direction -= 1
	
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		direction += 1
	
	velocity.x = direction * speed
	move_and_slide()

func _process(_delta):
	# Анимация
	if Input.is_key_pressed(KEY_D):
		_animation_player.play("Walk_cycle")
		$Sprite2D.flip_h = false
	elif Input.is_key_pressed(KEY_A):
		_animation_player.play("Walk_cycle")
		$Sprite2D.flip_h = true
	else:
		_animation_player.play("Idle")





# Для одиночной строки (оставляем как было)
func show_label(text: String) -> void:
	if UIManager:
		UIManager.show_text(text)

# Для массива строк - отдельная функция
func show_labels(texts: PackedStringArray) -> void:
	if UIManager:
		for text in texts:
			UIManager.show_text(text)

func hide_label():
	label.hide()

func set_interactable(node: Node):
	current_interactable = node

func clear_interactable(node: Node):
	if current_interactable == node:
		current_interactable = null
		hide_label()
