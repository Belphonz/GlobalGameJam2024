extends Node2D


func _on_controls_pressed():
	var audio = get_child(0) as AudioStreamPlayer2D
	audio.play()
	await audio.finished
	pass # Replace with function body.


func _on_start_button_pressed():
	var audio = get_child(0) as AudioStreamPlayer2D
	audio.play()
	await audio.finished
	get_tree().change_scene_to_file("res://scenes/MainScene.tscn")


func _on_quit_button_pressed():
	var audio = get_child(0) as AudioStreamPlayer2D
	audio.play()
	await audio.finished
	get_tree().quit()
