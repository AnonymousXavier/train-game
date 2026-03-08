extends Node3D
class_name NPC

@export var npc_id: Enums.NPCS
@export var hint_label_text: String = "Text (X)"
@export var label_distance_from_models_head: float = 0.2

@onready var npc_name_label: Label3D = %tag
@onready var navAgent: NavigationAgent3D = $NavigationAgent3D
@onready var model: Node3D
@onready var dialogue_actionable: Dialogue_Actionable = $Dialogue_Actionable

const move_speed: float = 15.0 
var target_to_focus_on: Vector3
var default_position: Vector3

func _ready() -> void:
	default_position = global_position
	if npc_id in Cache.npc_models:
		model = Cache.npc_models[npc_id].instantiate()
		add_child(model)
	
	if npc_id in Cache.npc_dialogues:
		dialogue_actionable.dialogue_resource = Cache.npc_dialogues[npc_id]
		
	npc_name_label.text = Enums.NPCS.keys()[npc_id]
	dialogue_actionable.update_hint_label_to(hint_label_text)
	
	put_hint_and_npc_name_label_labels_above_models_head()

func _process(delta: float) -> void:
	if not navAgent.is_navigation_finished():
		pathfind(delta)
		focus_on_target(delta)

func move_to(target_position: Vector3):
	navAgent.target_position = target_position
	
	await navAgent.navigation_finished

func pathfind(delta: float):
	var next_path_pos = navAgent.get_next_path_position()
	var direction = global_position.direction_to(next_path_pos)
	var velocity = direction * move_speed * delta
	
	velocity.y = 0
	global_position += velocity
		
func focus_on_target(delta: float):
	Misc.tween_look_at_target(self, target_to_focus_on, delta)
	
func put_hint_and_npc_name_label_labels_above_models_head():
	var mesh: MeshInstance3D = model.get_child(0) # All models have a single mesh
	var mesh_height: float = mesh.get_aabb().size.y * model.scale.y
	var perfect_height = mesh_height * 1.5 + global_position.y
	
	var dialgue_hint_label = dialogue_actionable.hint_label
	npc_name_label.global_position.y = perfect_height + label_distance_from_models_head
	dialgue_hint_label.global_position.y = perfect_height + label_distance_from_models_head * 2.2
	
	
	
