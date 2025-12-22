extends CharacterBody2D

@export var speed: float = 70.0
@export var gravity: float = 980.0
@export var interaction_range: float = 50.0  # Дистанция взаимодействия

@onready var _animation_player = $AnimationPlayer
@onready var _sprite = $Sprite2D

var interactable_object: Node2D = null      # Текущий объект для взаимодействия

func _ready():
	# Подключаем сигналы для взаимодействия
	$InteractionArea.area_entered.connect(_on_area_entered)
	$InteractionArea.area_exited.connect(_on_area_exited)
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
	# Обработка нажатия клавиши взаимодействия
	if Input.is_action_just_pressed("interact") and interactable_object:
		interact_with_object()
	
	# Анимации движения
	if Input.is_key_pressed(KEY_D):
		_animation_player.play("Walk_cycle")
		# Сбрасываем отражение при движении вправо
		_sprite.flip_h = false
	elif Input.is_key_pressed(KEY_A):
		_animation_player.play("Walk_cycle")
		# Отзеркаливаем спрайт при движении влево
		_sprite.flip_h = true
	else:
		_animation_player.play("Idle")

# Обработка ввода для взаимодействия (опционально)
func _on_area_entered(area: Area2D):
	# Проверяем, является ли объект интерактивным
	var object_to_check = area
	
	# Проверяем саму area и ее родителя
	if not area.is_in_group("interactable"):
		object_to_check = area.get_parent()
	
	# Если нашли интерактивный объект
	if object_to_check and object_to_check.is_in_group("interactable"):
		interactable_object = object_to_check
		print("Обнаружен предмет: ", interactable_object.name)

func _on_area_exited(area: Area2D):
	# Проверяем, вышел ли тот же объект
	var object_to_check = area
	if not area.is_in_group("interactable"):
		object_to_check = area.get_parent()
	
	if object_to_check == interactable_object:
		interactable_object = null
		print("Предмет больше не в зоне")

func interact_with_object():
	if interactable_object and interactable_object.has_method("interact"):
		# Вызываем метод interact у предмета
		interactable_object.interact(self)
