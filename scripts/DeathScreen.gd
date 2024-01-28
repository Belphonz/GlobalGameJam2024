extends Node2D


func _on_quit_pressed():
	var audio = get_child(0) as AudioStreamPlayer2D
	audio.play()
	await audio.finished
	get_tree().quit()


func _on_button_pressed():
	var audio = get_child(0) as AudioStreamPlayer2D
	audio.play()
	await audio.finished
	get_tree().change_scene_to_file("res://scenes/ScoreScreen.tscn")


