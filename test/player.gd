extends CharacterBody2D

@export var speed: float = 100.0
@export var gravity: float = 980.0
@onready var _animation_player = $AnimationPlayer

func _physics_process(delta):
	# Гравитация
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Движение - проверяем конкретные клавиши
	var direction = 0
	
	# Влево: A или стрелка влево
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		direction -= 1
	
	# Вправо: D или стрелка вправо
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		direction += 1
	
	velocity.x = direction * speed
	move_and_slide()


func _process(_delta):
	if Input.is_key_pressed(KEY_D):
		_animation_player.play("Walk_cycle")
		# Сбрасываем отражение при движении вправо
		$Sprite2D.flip_h = false
	elif Input.is_key_pressed(KEY_A):
		_animation_player.play("Walk_cycle")
		# Отзеркаливаем спрайт при движении влево
		$Sprite2D.flip_h = true
	else:
		_animation_player.play("Idle")
		


func _on_button_pressed() -> void:
	pass # Replace with function body.
