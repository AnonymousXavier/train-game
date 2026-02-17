extends Node3D
class_name World

@onready var npcs: Node3D = $NPCs ## NPCs Node 2D containing the NPCS arranged in the same order as the enum
@onready var markers: Node3D = $"Markers/Scream Scene"

func _ready() -> void:
	var id = 0
	for npc_scene in npcs.get_children():
		SceneInstances.npc_scenes[Enums.NPCS.values()[id]] = npc_scene
		id += 1
		
	id = 0
	for marker in markers.get_children():
		SceneInstances.npc_target_positions_for_scream_scene[Enums.NPCS.values()[id]] = marker
		id += 1
