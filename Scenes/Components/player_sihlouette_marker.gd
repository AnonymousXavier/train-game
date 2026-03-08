extends SubViewport

@onready var camera: Camera3D = $Camera3D
@onready var model_pivot: Node3D = $model_pivot
@onready var player_model_anim_handler: Node3D = $"Animation Handler"
@onready var skeleton_3d: Skeleton3D = $model_pivot/model/CharacterArmature/Skeleton3D

func update_shader_properties_of_all_mesh():
	for mesh in skeleton_3d.get_children():
		var depth_tex = get_tree().root.get_child(0).get_depth_texture()
		mesh.material.set_shader_parameter("screen_depth_texture", depth_tex)

func _process(delta):
	update_shader_properties_of_all_mesh()
	
	camera.global_position = SceneInstances.main_camera.global_position
	
	player_model_anim_handler.move_velocity = SceneInstances.player.velocity
	model_pivot.global_position = SceneInstances.player.global_position
	
	Misc.tween_look_at_target(model_pivot, SceneInstances.player.get_move_rotation(), delta)
