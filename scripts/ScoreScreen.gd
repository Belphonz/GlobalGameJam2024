extends Node2D

var FinalArray
var page = 0
var texty : Label
var liner : LineEdit
var fow : TextureButton
var bac : TextureButton

func _on_line_edit_ready():
	fow = get_child(4)
	bac = get_child(5)
	liner = get_child(2)
	$LineEdit.grab_focus()
	texty = get_child(1)
	texty.text = "Score: " + str(Highscore.runscore) + "\nEnter Name"
	bac.visible = false
	fow.visible = false



func _on_line_edit_text_submitted(nam):
		
	if nam.length() == 3:
		nam = nam.to_upper()
		FinalArray = Highscore.fileArray
		FinalArray.push_back([Highscore.ID + 1, nam, Highscore.runscore])
		Highscore.ID = FinalArray[-1][0]
		print (FinalArray)
		Highscore.save(FinalArray)
		FinalArray.sort_custom(func(a, b): return a[2] > b[2])
		displayPage()
		liner.visible = false
	
func _on_forward_pressed():
	page += 1
	displayPage()

func _on_back_pressed():
	page -= 1
	displayPage()

func _on_mainbutton_pressed():
	get_tree().change_scene_to_file("res://scenes/Menu.tscn")

func displayPage():
	texty.text = ""
	
	if page == 0:
		bac.visible = false
	else:
		bac.visible = true
	if page < floor((FinalArray.size() - 1) / 4):
		fow.visible = true
	else:
		fow.visible = false
	for i in 4:
		#if FinalArray[page * 4 + i]:
		if (4 * page) + i <= FinalArray.size() - 1:
			print(FinalArray.size())
			texty.text += str(FinalArray[page * 4 + i][1]) + "      " +str(FinalArray[page * 4 + i][2]) + "\n"
		else:
			texty.text += "---      ---- \n"

