extends RigidBody2D


const ACCEL = 60

const WEAPON_STRENGTH = 2

@onready var cannon = $Cannon
@onready var laser = $Cannon/Laser
@onready var timer = $Cannon/Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_CROSS)
	timer.timeout.connect(_timer_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var forward = Vector2(1, 0).rotated(rotation).normalized()


	var velocity_in_forward_direction = max(0, forward.dot(linear_velocity))
	
	apply_force(forward * ((1000.0 / (velocity_in_forward_direction + 2.0)) + ACCEL))

	var mouse_position = get_global_mouse_position()
	cannon.look_at(mouse_position)

	print(velocity_in_forward_direction)


	if Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT):
		var recoil_dir = mouse_position.direction_to(cannon.global_position)
		apply_impulse(recoil_dir * WEAPON_STRENGTH, cannon.global_position - global_position)
		laser.visible = true
		timer.start()


func _timer_timeout():
	laser.visible = false