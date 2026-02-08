extends CanvasLayer

const class_7 = ("res://scenes/class_7.tscn")
const class_8 = ("res://scenes/class_8.tscn")
const class_9 = ("res://scenes/class_9.tscn")
const class_choice = ("res://scenes/class_choice.tscn")


func change_scene(scene_path):
	%AnimationPlayer.play("fade")
	await %AnimationPlayer.animation_finished
	
	get_tree().change_scene_to_file(scene_path)
	
	%AnimationPlayer.play_backwards("fade")
