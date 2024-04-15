extends Control
class_name GameUiControls

signal game_restart_requested

@onready var score_label : Label = $ScoreBox/ScoreLabel
@onready var highscore_label : Label = $HighscoreBox/HighscoreLabel
@onready var restart_button : Button = $Button

var _score: int = 0
var _highscore: int = 0

var score: int = 0:
	get:
		return _score
	set(value):
		_score = value
		score_label.text = str(value)
		if value > highscore:
			highscore = value 


var highscore: int = 0:
	get:
		return _highscore
	set(value):
		_highscore = value
		highscore_label.text = str(value)


func _ready():
	if not FileAccess.file_exists("user://score.dat"):
		return
	var file = FileAccess.open("user://score.dat", FileAccess.READ)
	highscore = int(file.get_as_text())

func _on_gobbo_died():
	restart_button.visible = true


func _on_button_pressed():
	restart_button.visible = false
	game_restart_requested.emit()
