extends CharacterBody2D


const SPEED = 300.0
const ACCEL = 3
const STEER = .02
const DRAG = 2

@onready var cannon = $Cannon
@onready var laser = $Cannon/Laser
@onready var timer = $Cannon/Timer


func _ready():
	Input.set_default_cursor_shape(Input.CURSOR_CROSS)

func _physics_process(_delta: float) -> void:

	var forward = Vector2(1, 0).rotated(rotation).normalized()

	var vel_normal = velocity.normalized()


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var rotation_speed := 2.0

	#rotation -= rotation_speed * delta * 0.01

	velocity += forward * ACCEL
	

	if Input.is_key_pressed(KEY_SPACE):
		velocity -= forward * ACCEL

	
	if Input.is_key_pressed(KEY_A):
		rotation -= STEER
	elif Input.is_key_pressed(KEY_D):
		rotation += STEER

	if forward != vel_normal:
		velocity -= vel_normal * DRAG

	if velocity.length() > SPEED:
		velocity = vel_normal * SPEED
	
	
	var mouse_position = get_global_mouse_position()
	cannon.look_at(mouse_position)


	if Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT):
		var shoot_dir = cannon.global_position.direction_to(mouse_position)

		var angle = shoot_dir.angle_to(forward)
		print(angle)

		if abs(angle) < .5:
			velocity -= forward * ACCEL
		elif abs(angle) > PI - .5:
			velocity += forward * ACCEL
		else:
			rotation -= STEER * angle

		laser.visible = true
		timer.start()
		timer.timeout.connect(_timer_timeout)
		
	
	move_and_slide()

func _timer_timeout():
	laser.visible = false