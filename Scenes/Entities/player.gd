extends CharacterBody3D

@onready var model: Node3D = $Node3D
@onready var animation_handler: Node3D = $"Animation Handler"
@onready var collider = $CollisionShape3D

const SPEED = 10.0
const JUMP_VELOCITY = 4.5

var direction: Vector3 = Vector3.ZERO

func _ready() -> void:
	SceneInstances.player = self

func get_move_rotation():
	return global_position + direction
	

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var move_direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	Global.player_movement_direction = input_dir
	
	if direction:
		velocity.x = move_direction.x * SPEED
		velocity.z = move_direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if move_direction != Vector3.ZERO:
		direction = move_direction
	
	animation_handler.move_velocity = velocity
	Misc.tween_look_at_target(model, get_move_rotation(), delta)

	move_and_slide()
