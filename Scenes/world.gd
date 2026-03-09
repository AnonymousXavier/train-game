extends Node3D
class_name World

@onready var npcs: Node3D = $NPCs ## NPCs Node 2D containing the NPCS arranged in the same order as the enum
@onready var markers: Node3D = $"Markers/Scream Scene"
@onready var bark_components: Node3D = $Barks

func _ready() -> void:
	update_npc_data_in_scene_instances(npcs, SceneInstances.npc_scenes)
	update_npc_data_in_scene_instances(markers, SceneInstances.npc_target_positions_for_scream_scene)
		
	SceneInstances.npc_target_positions_for_caught_player_in_storage_room_scene[Enums.NPCS.MAID_BOT] = $"Markers/Caught Player Snooping in Storage Room/MaidBot"
	SceneInstances.bark_components_container = bark_components
	
func update_npc_data_in_scene_instances(container: Node3D, scene_instances_property: Dictionary):
	var id = 0
	for child in container.get_children():
		scene_instances_property[Enums.NPCS.values()[id]] = child
		id += 1
