extends Area3D
class_name Dialogue_Actionable

signal dialogue_finished
signal dialogue_started

@onready var active_region_marker: MeshInstance3D = $ActiveRegionMarker
@onready var hint_label: Label3D = $Label3D

@export var active = true ## Defines whether the dialogue will be interactable
@export var start_on_player_detected = true ## If false.. just means an external script will activate the dialogue
@export var is_designed_to_start_with_a_timer = false ## Just Extra Information for more streamlined Filtering Checks
@export var delete_on_dialogue_finished = false ## If its a scene, that occurs once
@export_group("Dialogue Depencies")
@export var dialogue_start: String = "start"
@export var hint_label_text: String = "Talk (X)"
@export var dialogue_resource: DialogueResource
@export_group("State Dependencies")
@export var global_state_condition_to_check_to_become_active = "" ## The GameState Variable the dialogue requires to appear or diappear. Note that "state_is_expected_to_be_true" and this variable need to true for the dialogue to be "active"
@export var state_is_expected_to_be_true = true

func _ready() -> void:
	hint_label.hide()
	DialogueManager.connect("dialogue_ended", _on_dialogue_finished)
	DialogueManager.connect("dialogue_started", _on_dialogue_started)
	
	active = global_state_condition_to_check_to_become_active == ""
	if not start_on_player_detected:
		active_region_marker.hide()
	
	update_hint_label_to(hint_label_text)
	
func update_hint_label_to(text: String):
	hint_label.text = text
	
func _process(_delta: float) -> void:
	if not active and global_state_condition_to_check_to_become_active != "":
		visible = GameStates.get(global_state_condition_to_check_to_become_active) and state_is_expected_to_be_true
	if GameStates.scene_on_going:
		hint_label.hide()

func start_dialogue():
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
	print(dialogue_resource.titles.keys())

func _on_body_entered(_body: Node3D) -> void:
	if start_on_player_detected:
		active = true
	else:
		hint_label.show()
		
	if active:
		active_region_marker.hide()
		if start_on_player_detected:
			start_dialogue()

func _on_body_exited(_body: Node3D) -> void:
	hint_label.hide()
	
func _on_dialogue_finished(ended_dialogue_resource: DialogueResource):
	if dialogue_resource == ended_dialogue_resource:
		dialogue_finished.emit()
		GameStates.scene_on_going = false
		if delete_on_dialogue_finished:
			queue_free()
		
func _on_dialogue_started(started_dialogue_resource: DialogueResource):
	if dialogue_resource == started_dialogue_resource:
		dialogue_started.emit()
		GameStates.scene_on_going = true
