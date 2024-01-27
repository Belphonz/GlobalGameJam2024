extends Node2D

var file_data
var ID : int
var data_received
var Player : Node2D

func _ready():
	Player = get_node("../Player")
	var highscore = Player.score
	print ("go go go")

	loadScores()
	var newscore = [1, "ADL", 1921]
	var json_string = JSON.stringify(file_data)
	var json = JSON.new()
	#var scorelist = json.parse()
	
	var error = json.parse(json_string)
	if error == OK:
		data_received = json.data
		if typeof(data_received) == TYPE_ARRAY:
			
			print (data_received[0][1], "\t", data_received[0][2], "\n")
			ID = data_received[-1][0]
		else:
			print("uh oh not array")
			print(data_received)
	else:
		print("Parse eror")
	
func save():
	var file = FileAccess.open("res://highscores.json", FileAccess.WRITE)
	file.flush()
	file.store_line(JSON.stringify(file_data))

func loadScores():
	var file
	if not FileAccess.file_exists("res://highscores.json"):
		save()
		return
	file = FileAccess.open("res://highscores.json", FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	file_data = data

func _process(delta):
	var json = JSON.new()
	var hi
	var json_string = JSON.stringify(file_data)
	var error = json.parse(json_string)
	var fileArray = json.data
	fileArray.push_back([ID + 1, "GOO", 23])
	if Input.is_action_pressed("ui_right"):
		print(fileArray)


func sortScores(a, b):
	if a[2] < b[2]:
		return true
	return false
