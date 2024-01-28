extends Node2D

var FinalArray

func _on_line_edit_ready():
	var liner : LineEdit = get_child(2)
	$LineEdit.grab_focus()
	var texty : Label = get_child(1)
	texty.text = "Score: " + str(Highscore.runscore) + "\nEnter Name"



func _on_line_edit_text_submitted(nam):
	if nam.length() == 3:
		nam = nam.to_upper()
		FinalArray = Highscore.fileArray
		FinalArray.push_back([Highscore.ID + 1, nam, Highscore.runscore])
		Highscore.ID = FinalArray[-1][0]
		print (FinalArray)
		get_tree().change_scene_to_file("res://scenes/Menu.tscn")
