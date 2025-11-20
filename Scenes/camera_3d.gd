extends Camera3D

@export var target: Node3D
@export var left_limit_node: Node3D
@export var right_limit_node: Node3D
@export var lerp_speed: float = 2.0

@onready var default_position: Vector3

var half_camera_width: float ##

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
	var desired_x = (target.global_position + default_position).x
	var clamped_x = clamp_camera_x(desired_x)
	
	SceneInstances.main_viewport = get_viewport()
	
	global_position.x = lerp(global_position.x, clamped_x, lerp_speed * delta)
	
func clamp_camera_x(desired_x: float) -> float:
	var left_edge_x = left_limit_node.global_position.x + half_camera_width
	var right_edge_x = right_limit_node.global_position.x - half_camera_width
	
	return clamp(desired_x, left_edge_x, right_edge_x)
	
