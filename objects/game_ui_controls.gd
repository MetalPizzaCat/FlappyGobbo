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
			highscore_changed = true

var highscore_changed : bool = false
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
	highscore = file.get_32()

func _on_gobbo_died():
	restart_button.visible = true
	if highscore_changed:
		highscore_changed = false
		var file = FileAccess.open("user://score.dat", FileAccess.WRITE)
		file.store_32(highscore)

func _on_button_pressed():
	restart_button.visible = false
	game_restart_requested.emit()
	score = 0
