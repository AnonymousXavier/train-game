extends CharacterBody3D
class_name Player

signal initiated_dialogue(Area2D)

@onready var model: Node3D = %Model
@onready var animation_handler: Node3D = $"Animation Handler"
@onready var collider = $CollisionShape3D
@onready var dialogue_interactables_finder: Area3D = $Node3D/Dialogue_Interactables_Finder

<<<<<<< Updated upstream

const SPEED = 2.0

const JUMP_VELOCITY = 4.5
=======
@export var SPEED = 2.0
@export var JUMP_VELOCITY = 4.5
>>>>>>> Stashed changes

var direction: Vector3 = Vector3.ZERO

func _ready() -> void:
	SceneInstances.player = self

func get_move_rotation():
	return global_position + direction

func handle_dialogue_interactions():
	if Input.is_action_just_pressed("interact"):
		if dialogue_interactables_finder.has_overlapping_areas():
			var dialogue_interactable = dialogue_interactables_finder.get_overlapping_areas()[0] as Dialogue_Actionable
			#  Only Activate if it wasnt designed to start automatically
			if not (dialogue_interactable.start_on_player_detected and dialogue_interactable.is_designed_to_start_with_a_timer):
				initiated_dialogue.emit(dialogue_interactable)
				dialogue_interactable.start_dialogue()

func handle_movement_controls():
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
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

func _physics_process(delta: float) -> void:
	if not GameStates.scene_on_going: # Dont move during Scenes
		handle_movement_controls()
	else:
		velocity = Vector3.ZERO

	Misc.tween_look_at_target(model, get_move_rotation(), delta)
	
	handle_dialogue_interactions()
	move_and_slide()
	animation_handler.move_velocity = velocity
