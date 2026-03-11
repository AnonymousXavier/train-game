extends Node
class_name Misc

static func move_npc_scream_scene(id: Enums.NPCS):
	var target_marker = SceneInstances.npc_target_positions_for_scream_scene[id]
	move_npc(id, target_marker.global_position, SceneInstances.player.global_position)

static func move_npc(id: Enums.NPCS, target_pos: Vector3, look_at_pos: Vector3):
	var npc = SceneInstances.npc_scenes[id]
	npc.move_to(target_pos)
	npc.target_to_focus_on = look_at_pos
	
static func return_npc_to_default_position(id: Enums.NPCS):
	var npc = SceneInstances.npc_scenes[id]
	move_npc(id, npc.default_position, npc.default_position)

static func tween_look_at_target(node: Node3D, target_position: Vector3, delta: float, axis: Vector3 = Vector3.UP, rotation_speed: float = 7):
	var direction = target_position - node.global_position
	tween_look_at(node, direction, delta, axis, rotation_speed)
	
static func tween_look_at(node: Node3D, direction: Vector3, delta: float,axis: Vector3 = Vector3.UP, rotation_speed: float = 12.0):
	direction.y = 0
	direction = direction.normalized()
	if direction == Vector3.ZERO: return

	var facing_direction = node.global_transform.basis.z.normalized()
	var angle_diff = facing_direction.signed_angle_to(direction, axis)
	var rotation_step = rotation_speed * delta
	angle_diff = clamp(angle_diff, -rotation_step, rotation_step)
	node.rotate(axis, angle_diff)

static func move_caught_player_in_storage_room_scene(id: Enums.NPCS):
	var target_marker = SceneInstances.npc_target_positions_for_caught_player_in_storage_room_scene[id]
	move_npc(id, target_marker.global_position, SceneInstances.player.global_position)
	
static func bark(message: String, npc_id=null):
	var npc
	if npc_id != null:
		npc = SceneInstances.npc_scenes[npc_id]
	else:
		npc = SceneInstances.player
		
	var bark_component: Bark_Component = Cache.bark_system_component_scene.instantiate()

	SceneInstances.bark_components_container.add_child(bark_component)
	bark_component.hint_label.text = message
	bark_component.set_position_above(get_top_of_models_head(npc.model, npc.global_position))
	bark_component.show_bark()
	
	await bark_component.bark_complete
	
static func get_top_of_models_head(model: Node3D, position: Vector3):
	var mesh: MeshInstance3D = model.get_child(0) # All models have a single mesh
	var mesh_height: float = mesh.get_aabb().size.y * model.scale.y * 1.45
	
	return Vector3(0, mesh_height, 0) + position
	
static func reset_npcs_to_default_positions():
	for npc_id in Enums.NPCS.values():
		var npc = SceneInstances.npc_scenes[npc_id] as NPC
		npc.global_position = npc.default_position
	
static func reset_scene_to_last_checkpoint():
	SceneInstances.player.global_position = SceneInstances.player_default_position_marker.global_position
	reset_npcs_to_default_positions()
		
static func kill_player():
	SceneInstances.you_died_control_scene.show()
