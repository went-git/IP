extends CanvasLayer

const class_7 = ("res://scenes/class_7.tscn")
const class_choice = ("res://scenes/world.tscn")


func change_scene(scene_path):
	%AnimationPlayer.play("fade")
	await %AnimationPlayer.animation_finished
	
	get_tree().change_scene_to_file(scene_path)
	
	%AnimationPlayer.play_backwards("fade")
