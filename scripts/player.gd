extends CharacterBody2D


const SPEED = 200

const WALK_FRAMES = preload("res://assets/sprite_frames/player_frames.tres")
const IDLE_FRAMES = preload("res://assets/sprite_frames/player_idle_frames.tres")

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var _last_direction := "down"
var _last_flip := false

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	velocity = direction * SPEED

	if direction != Vector2.ZERO:
		animated_sprite.sprite_frames = WALK_FRAMES
		if abs(direction.x) >= abs(direction.y):
			_last_direction = "right"
			_last_flip = direction.x < 0
			animated_sprite.play("walk_right")
			animated_sprite.flip_h = _last_flip
		elif direction.y < 0:
			_last_direction = "up"
			_last_flip = false
			animated_sprite.play("walk_up")
			animated_sprite.flip_h = false
		else:
			_last_direction = "down"
			_last_flip = false
			animated_sprite.play("walk_down")
			animated_sprite.flip_h = false
	else:
		animated_sprite.sprite_frames = IDLE_FRAMES
		animated_sprite.flip_h = _last_flip
		animated_sprite.play("idle_" + _last_direction)

	move_and_slide()
