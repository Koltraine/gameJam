extends CharacterBody2D

const ACCEL = 3
const BOOST_ACCEL = 10
const STEER = .02
const DRAG = 1
const SPEED_DRAG = .001

@onready var cannon = $Cannon
@onready var laser = $Cannon/Laser
@onready var timer = $Cannon/Timer

var is_drifting = false

func _ready():
	Input.set_default_cursor_shape(Input.CURSOR_CROSS)
	timer.timeout.connect(_timer_timeout)

func _physics_process(_delta: float) -> void:

	var forward = Vector2(1, 0).rotated(rotation)
	var vel_normal = velocity.normalized()

	velocity += forward * ACCEL

	var drift_ang = abs(forward.angle_to(vel_normal))
	
	if drift_ang > PI / 2:
		drift_ang = PI / 2 - (drift_ang - PI / 2)
	
	is_drifting = drift_ang > .3;


	var base_drag = SPEED_DRAG * velocity
	var drift_drag = (drift_ang / (PI / 2)) * base_drag

	var new_vel = velocity - base_drag - drift_drag

	velocity = new_vel
	
	if Input.is_key_pressed(KEY_SPACE):
		velocity -= forward * ACCEL
	
	
	var mouse_position = get_global_mouse_position()
	cannon.look_at(mouse_position)

	if Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT):
		var shoot_dir = cannon.global_position.direction_to(mouse_position)

		var angle = shoot_dir.angle_to(forward)

		if abs(angle) < .5:
			velocity -= forward * ACCEL
		elif abs(angle) > PI - .6:
			velocity += forward * ACCEL
		else:
			rotation -= STEER * angle

		laser.visible = true
		timer.start()

	move_and_slide()

func _timer_timeout():
	laser.visible = false
