extends CharacterBody2D


const SPEED = 300.0
const ACCEL = 5
const STEER = .04

func _physics_process(_delta: float) -> void:

	var forward = Vector2(1, 0).rotated(rotation).normalized()

	print(forward)


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var rotation_speed := 2.0

	#rotation -= rotation_speed * delta * 0.01

	if Input.is_key_pressed(KEY_W):
		velocity += forward * ACCEL
	elif Input.is_key_pressed(KEY_S):
		velocity -= forward * ACCEL
	if Input.is_key_pressed(KEY_A):
		rotation -= STEER
	elif Input.is_key_pressed(KEY_D):
		rotation += STEER


	move_and_slide()
