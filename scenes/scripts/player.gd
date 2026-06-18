extends CharacterBody2D


const SPEED = 200

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	velocity = direction * SPEED

	if direction != Vector2.ZERO:
		if abs(direction.x) >= abs(direction.y):
			animated_sprite.play("walk_right")
			animated_sprite.flip_h = direction.x < 0
		elif direction.y < 0:
			animated_sprite.play("walk_up")
			animated_sprite.flip_h = false
		else:
			animated_sprite.play("walk_down")
			animated_sprite.flip_h = false
	else:
		animated_sprite.stop()

	move_and_slide()
