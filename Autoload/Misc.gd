extends Node
class_name Misc

static func tween_look_at_target(node: Node3D, target_position: Vector3, delta: float, axis: Vector3 = Vector3.UP, rotation_speed: float = 12.0):
	var direction = target_position - node.global_position
	tween_look_at(node, direction, delta, axis, rotation_speed)
	
static func tween_look_at(node: Node3D, direction: Vector3, delta: float,axis: Vector3 = Vector3.UP, rotation_speed: float = 12.0):
	direction.y = 0
	direction = direction.normalized()
	
	if direction == Vector3.ZERO:
		return

	var facing_direction = node.global_transform.basis.z.normalized()
	var angle_diff = facing_direction.signed_angle_to(direction, axis)

	var rotation_step = rotation_speed * delta
	# Prevent Instantanious Rotation, Instead Clamp to rotation speed
	angle_diff = clamp(angle_diff, -rotation_step, rotation_step)
	
	node.rotate(axis, angle_diff)
