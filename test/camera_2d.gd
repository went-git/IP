extends Camera2D

func _ready():
	# Автоматически найти игрока по тегу
	var player = get_tree().get_nodes_in_group("player")
	if player.size() > 0:
		global_position = player[0].global_position

func _process(delta):
	var player = get_tree().get_nodes_in_group("player")
	if player.size() > 0:
		global_position = player[0].global_position
