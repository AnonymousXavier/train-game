extends Node

@onready var player: Player = null
@onready var main_camera = null
@onready var main_viewport = null
@onready var navigation_region: NavigationRegion3D = null
@onready var bark_components_container: Node3D = null

@onready var player_default_position_marker: Marker3D = null
@onready var you_died_control_scene: Control = null

var npc_scenes: Dictionary[Enums.NPCS, NPC] = {}
var npc_target_positions_for_scream_scene: Dictionary[Enums.NPCS, Marker3D] = {}
var npc_target_positions_for_caught_player_in_storage_room_scene: Dictionary[Enums.NPCS, Marker3D] = {}
