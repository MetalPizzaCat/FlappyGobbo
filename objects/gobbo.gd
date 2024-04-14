extends Area2D

signal game_restarted
signal died


@export_group("Texture")
@export var rising_texture: Texture2D
@export var falling_texture: Texture2D
@export var dead_texture: Texture2D

@export_group("Physics")
@export var speed: float = 100
@export var jump_velocity : float = 150

@onready var sprite : Sprite2D = $Sprite2D

var gravity_force = 500
var velocity : Vector2 = Vector2.ZERO

var _dead : bool = false

var dead : bool = false :
	get:
		return _dead
	set(value):
		_dead = value
		sprite.texture = dead_texture

func _physics_process(delta):
	if dead:
		return
	velocity.y += gravity_force * delta
	if velocity.y > gravity_force:
		velocity.y = gravity_force

	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = -jump_velocity
		sprite.texture = rising_texture

	if sprite.texture != falling_texture and velocity.y > 0:
		sprite.texture = falling_texture
		
	position += velocity * delta

func _on_body_entered(body:Node2D):
	return
	dead = true
	died.emit()
