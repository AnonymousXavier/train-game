extends Node3D

@onready var ray_cast_points: Array
var objects_blocking_player: Array # All objects currently blocking the player
var hidden_objects: Array ## Objects with their opacity changed

@onready var ray_cast_delay_timer: Timer = $RayCastDelayTimer
@onready var rays_container: Node3D = $Rays

@export var target_to_always_show: CharacterBody3D
@export var ray_cast_rate = 5 ## Number of times per sec the ray check is done

func _ready() -> void:
	create_rays()
	ray_cast_delay_timer.start()
	
func update_objects_transparency() -> void:
	if not target_to_always_show:
		return
		
	for hidden_object in hidden_objects:
		if hidden_object not in objects_blocking_player:
			var object_mesh = hidden_object.get_parent() as MeshInstance3D
			change_mesh_color_to(object_mesh, null)
			
			hidden_objects.erase(hidden_object)
	
	for object in objects_blocking_player:
		var object_mesh = object.get_parent() as MeshInstance3D
		
		change_mesh_color_to(object_mesh, Color(1,1,1,0.5))
		hidden_objects.append(object)

func change_mesh_color_to(object_mesh: MeshInstance3D, color):
	if color:
		if object_mesh.get_surface_override_material(0) and object_mesh.get_surface_override_material(0).albedo_color.a == color.a:
			return
			
		var object_material =  StandardMaterial3D.new()
		object_material.resource_local_to_scene = true
		object_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		object_material.albedo_color = Color(color.r, color.g, color.b, 0.5)
		
		object_mesh.set_surface_override_material(0, object_material)
		get_tree().create_tween().tween_property(object_material, "albedo_color:a", color.a, 0.5)
		
	else:
		get_tree().create_tween().tween_property(object_mesh.get_surface_override_material(0), "albedo_color:a", 1.0, 0.5)
		await get_tree().create_timer(0.5).timeout
		object_mesh.set_surface_override_material(0, null)

func create_rays():
	for point in get_ray_cast_points_from_target_collider():
		var ray = RayCast3D.new()
		
		rays_container.add_child(ray)
		ray.collide_with_bodies = true
	
func get_ray_cast_points_from_target_collider():
	var ray_points = []
	var collider = target_to_always_show.collider as CollisionShape3D
	var collider_shape = collider.shape as CapsuleShape3D
	
	var left_edge_point = target_to_always_show.global_position - Vector3(collider_shape.radius, - collider_shape.height / 2, 0)
	var middle_point = target_to_always_show.global_position - Vector3(0, - collider_shape.height / 2, 0)
	var right_edge_point = target_to_always_show.global_position + Vector3(collider_shape.radius, collider_shape.height / 2, 0)
	
	ray_points.append(left_edge_point)
	ray_points.append(middle_point)
	ray_points.append(right_edge_point)
	
	return ray_points

func get_objects_blocking_player():
	var i = 0
	var objects = []
	
	for point in ray_cast_points:
		var blocking_object = cast_ray_to(point, i)
		if blocking_object:
			objects.append(blocking_object)
		i += 1

	return objects
	
func cast_ray_to(ray_point: Vector3, index):
	var ray = rays_container.get_children()[index]
	
	ray.global_position = global_position
	ray.target_position = ray_point - global_position
	
	return ray.get_collider()

func _on_ray_cast_delay_timer_timeout() -> void:
	ray_cast_points = get_ray_cast_points_from_target_collider()
	objects_blocking_player = get_objects_blocking_player()
	update_objects_transparency()
	
	ray_cast_delay_timer.wait_time = 1.0 / ray_cast_rate
