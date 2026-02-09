extends CanvasLayer

@onready var bottom_panel: Panel = $BottomPanel
@onready var label: Label = $BottomPanel/Label

var message_queue: Array[Dictionary] = []  # Храним словари с текстом
var is_showing: bool = false
var can_proceed: bool = true  # Можно ли перейти к следующему сообщению
var action_name: String = "ui_accept"  # Кнопка для продолжения

func _ready():
	# Создаем узлы если их нет
	if not bottom_panel:
		setup_bottom_panel()
	
	hide_panel_instant()

func setup_bottom_panel():
	# Удаляем старые узлы если есть
	if bottom_panel:
		bottom_panel.queue_free()
	
	# Создаем панель
	bottom_panel = Panel.new()
	bottom_panel.name = "BottomPanel"
	add_child(bottom_panel)
	
	
	# Настройка панели
	bottom_panel.layout_mode = 1  # Anchors
	bottom_panel.anchor_left = 0.15
	bottom_panel.anchor_right = 0.85
	bottom_panel.anchor_top = 0.8  # Можно сделать побольше
	bottom_panel.anchor_bottom = 1.0
	bottom_panel.offset_top = -10
	
	# Черный фон
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0, 0, 0, 0.75)
	style.border_width_top = 2
	style.border_color = Color.GRAY
	style.corner_radius_top_left = 15
	style.corner_radius_top_right = 15
	bottom_panel.add_theme_stylebox_override("panel", style)
	
	# Создаем текст
	label = Label.new()
	bottom_panel.add_child(label)
	
	label.name = "Label"
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	
	# Настройки шрифта
	label.add_theme_color_override("font_color", Color.WHITE)
	var font_path = "res://fonts/Fester_Trial-Regular.otf"
	var font = FontFile.new()
	font.font_data = load(font_path)
	label.add_theme_font_override("font", font)
	label.add_theme_font_size_override("font_size", 28)
	# Отступы
	
	label.add_theme_constant_override("margin_left", 70)
	label.add_theme_constant_override("margin_right", 30)
	label.add_theme_constant_override("margin_top", 25)
	label.add_theme_constant_override("margin_bottom", 25)
	
	'''
	# Добавляем подсказку внизу
	var hint_label = Label.new()
	bottom_panel.add_child(hint_label)
	hint_label.name = "HintLabel"
	hint_label.text = "[Нажмите space чтобы продолжить]"
	hint_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	hint_label.vertical_alignment = VERTICAL_ALIGNMENT_BOTTOM
	hint_label.anchor_bottom = 1.0
	hint_label.offset_bottom = -10
	hint_label.add_theme_font_size_override("font_size", 16)
	hint_label.add_theme_color_override("font_color", Color.LIGHT_GRAY)
	hint_label.add_theme_constant_override("margin_bottom", 10)
'''
# Основная функция для показа текста
func show_text(text: String) -> void:
	message_queue.append({"text": text})
	
	if not is_showing:
		_show_next_message()

# Показать несколько сообщений сразу
func show_texts(texts: Array[String]) -> void:
	for text in texts:
		message_queue.append({"text": text})
	
	if not is_showing:
		_show_next_message()

# Показать следующее сообщение
func _show_next_message() -> void:
	if message_queue.size() > 0:
		is_showing = true
		can_proceed = true
		
		var message_data = message_queue.pop_front()
		_display_message(message_data["text"])
	else:
		_hide_panel()
		is_showing = false

# Отобразить сообщение
func _display_message(text: String) -> void:
	label.text = text
	
	# Анимация появления
	bottom_panel.modulate = Color(1, 1, 1, 0)
	bottom_panel.visible = true
	
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(bottom_panel, "modulate", Color(1, 1, 1, 1), 0.3)

# Обработка ввода для продолжения
func _input(event: InputEvent) -> void:
	# Проверяем только если показывается сообщение и можно продолжить
	if is_showing and can_proceed and event.is_action_pressed(action_name):
		can_proceed = false  # Блокируем повторное нажатие
		_proceed_to_next()

# Перейти к следующему сообщению
func _proceed_to_next() -> void:
	# Анимация исчезновения
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(bottom_panel, "modulate", Color(1, 1, 1, 0), 0.2)
	tween.tween_callback(_show_next_message)  # После анимации показываем следующее

# Скрыть панель
func _hide_panel() -> void:
	var tween = create_tween()
	tween.tween_property(bottom_panel, "modulate", Color(1, 1, 1, 0), 0.3)
	tween.tween_callback(func(): bottom_panel.visible = false)

# Мгновенно скрыть панель
func hide_panel_instant() -> void:
	bottom_panel.visible = false
	bottom_panel.modulate = Color(1, 1, 1, 0)
	is_showing = false
	message_queue.clear()

# Пропустить текущее сообщение (из другого кода)
func skip_current_message() -> void:
	if is_showing:
		_proceed_to_next()

# Пропустить все сообщения
func skip_all_messages() -> void:
	message_queue.clear()
	_hide_panel()
	is_showing = false

# Изменить кнопку для продолжения
func set_action_button(action: String) -> void:
	action_name = action
	if has_node("BottomPanel/HintLabel"):
		var hint = get_node("BottomPanel/HintLabel")
		hint.text = "[Нажмите " + action_name + " чтобы продолжить]"

# Проверить, показывается ли сейчас сообщение
func is_message_showing() -> bool:
	return is_showing

# Получить текущий текст
func get_current_text() -> String:
	return label.text if bottom_panel.visible else ""

# Получить размер очереди
func get_queue_size() -> int:
	return message_queue.size()
