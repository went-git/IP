extends Node2D

func _on_start_pressed():
	ChangeScene.change_scene("res://scenes/class_choice.tscn")


func _on_quit_pressed():
	get_tree().quit()
 
