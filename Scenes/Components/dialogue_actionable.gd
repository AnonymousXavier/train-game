extends Area3D
class_name Dialogue_Actionable

signal dialogue_finished
signal dialogue_started

@onready var active_region_marker: MeshInstance3D = $ActiveRegionMarker
@onready var hint_label: Label3D = $Label3D

@export var active = true
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
@export var start_on_player_detected = true
@export var global_state_condition_to_check_to_become_active = ""

func _ready() -> void:
	hint_label.hide()
	DialogueManager.connect("dialogue_ended", _on_dialogue_finished)
	DialogueManager.connect("dialogue_started", _on_dialogue_started)
	
	active = global_state_condition_to_check_to_become_active == ""
	
func _process(delta: float) -> void:
	if not active and global_state_condition_to_check_to_become_active != "":
		visible = GameStates.get(global_state_condition_to_check_to_become_active)

func start_dialogue():
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)

func _on_body_entered(_body: Node3D) -> void:
	if active:
		active_region_marker.hide()
		if start_on_player_detected:
			start_dialogue()

func _on_body_exited(_body: Node3D) -> void:
	pass
	
func _on_dialogue_finished(ended_dialogue_resource: DialogueResource):
	if dialogue_resource == ended_dialogue_resource:
		dialogue_finished.emit()
		
func _on_dialogue_started(started_dialogue_resource: DialogueResource):
	if dialogue_resource == started_dialogue_resource:
		dialogue_started.emit()
