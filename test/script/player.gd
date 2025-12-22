extends CharacterBody2D

@export var speed: float = 70.0
@export var gravity: float = 980.0
@onready var _animation_player = $AnimationPlayer
@onready var label = $Label

var near_dresser: Area2D = null
var near_dresser1: Area2D = null
var near_dresser2: Area2D = null

func _remember_scene7(area: Area2D):
	near_dresser1 = area
func _forget_scene7(area: Area2D):
	# Если вышли из зоны текущей тумбочки
	if near_dresser1 == area:
		near_dresser1 = null
		
func _remember_back(area: Area2D):
	near_dresser2 = area
func _forget_back(area: Area2D):
	# Если вышли из зоны текущей тумбочки
	if near_dresser2 == area:
		near_dresser2 = null



func _ready():
	label.hide()

func _on_interact_area_entered(area: Area2D):
	# Запоминаем тумбочку, с которой взаимодействуем
	near_dresser = area

func _on_interact_area_exited(area: Area2D):
	# Если вышли из зоны текущей тумбочки
	if near_dresser == area:
		near_dresser = null
		label.hide()

func _physics_process(delta):
	if Input.is_action_just_pressed("interact") and near_dresser != null:
		show_label("Тумбочка...")
		
	if Input.is_action_just_pressed("interact") and near_dresser1 != null:
		get_tree().change_scene_to_file('res://scenes/class_7.tscn')
		
	if Input.is_action_just_pressed("interact") and near_dresser2 != null:
		get_tree().change_scene_to_file('res://scenes/world.tscn')
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

func show_label(text: String):
	label.text = text
	label.show()
	
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
		
