extends Area2D
class_name Goblin


signal game_restarted
signal died
signal player_started


@export_group("Texture")
@export var rising_texture: Texture2D
@export var falling_texture: Texture2D
@export var dead_texture: Texture2D

@export_group("Physics")
@export var speed: float = 100
@export var jump_velocity : float = 150

@export_group("UI")
@export var ui : GameUiControls

@onready var sprite : Sprite2D = $Sprite2D

@onready var jump_sound_player : AudioStreamPlayer = $JumpSoundPlayer
@onready var death_sound_player : AudioStreamPlayer = $DeathSoundPlayer
@onready var point_sound_player : AudioStreamPlayer = $PointSoundPlayer

@onready var game_state_manager: GameStateManager = get_node("/root/GameState")

var gravity_force = 500
var velocity : Vector2 = Vector2.ZERO
var started = false

var start_position : Vector2

var _dead : bool = false

var dead : bool = false :
	get:
		return _dead
	set(value):
		_dead = value
		sprite.texture = dead_texture

func _ready():
	start_position = position

func _physics_process(delta):
	if dead:
		return
	if not started:
		if Input.is_action_just_pressed("ui_accept"):
			started = true
			velocity.y = -jump_velocity
			sprite.texture = rising_texture
			game_state_manager.is_game_running = true
		else:
			return

	velocity.y += gravity_force * delta
	if velocity.y > gravity_force:
		velocity.y = gravity_force

	if Input.is_action_just_pressed("ui_accept"):
		if dead:
			game_restarted.emit()
		jump_sound_player.play()
		velocity.y = -jump_velocity
		sprite.texture = rising_texture
		

	if sprite.texture != falling_texture and velocity.y > 0:
		sprite.texture = falling_texture
		
	position += velocity * delta

func _on_body_entered(_body:Node2D):
	dead = true
	died.emit()
	death_sound_player.play()


func add_point():
	point_sound_player.play()
	if ui != null:
		ui.score += 1

func restart():
	position = start_position
	dead = false
	started = false
	game_state_manager.is_game_running = false