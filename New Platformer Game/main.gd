extends Node2D


func _on_quit_pressed():
	#get_tree() -> everything in the main LOL
	#quit() -> x the window quit the game
	get_tree().quit();




func _on_play_pressed():
	#When click the button it change the scene
	get_tree().change_scene_to_file("res://world.tscn")
