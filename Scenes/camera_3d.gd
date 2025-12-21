extends Camera3D

@export var target: Node3D
@export var left_limit_node: Node3D
@export var right_limit_node: Node3D
@export var lerp_speed: float = 2.0
@export var track_z_direction: bool = false

@onready var transparency_object_handler: Node3D = $"Transparency Object Handler"
@onready var default_position: Vector3

var half_camera_width: float ##

enum AXIS {X, Z}

func get_compute_camera_half_width():
	var distance = abs(global_position.z)  # distance from camera to your world
	return distance * tan(deg_to_rad(fov * 0.5))

func _ready() -> void:
	SceneInstances.main_camera = self
	default_position = global_position
	half_camera_width = get_compute_camera_half_width()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Make the camera maintain a constant distance from the target
	var desired_position = (target.global_position + default_position)
	var clamped_x = clamp_camera(desired_position.x, AXIS.X)
	
	global_position.x = lerp(global_position.x, clamped_x, lerp_speed * delta)
	
	if track_z_direction:
		global_position.z = lerp(global_position.z, clamp_camera(desired_position.z, AXIS.Z), lerp_speed * delta)
		
func clamp_camera(desired: float, axis: AXIS) -> float:
	var left_edge
	var right_edge
	
	match axis:
		AXIS.X:
			left_edge = left_limit_node.global_position.x + half_camera_width
			right_edge = right_limit_node.global_position.x - half_camera_width
		AXIS.Z:
			left_edge = -INF
			right_edge = INF
	
	return clamp(desired, left_edge, right_edge)
	
