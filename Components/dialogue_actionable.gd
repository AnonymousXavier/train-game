extends Area3D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
@onready var hint_label: Label3D = $Label3D

func _ready() -> void:
	hint_label.hide()

func start_dialogue():
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)

func _on_body_entered(_body: Node3D) -> void:
	hint_label.show()

func _on_body_exited(_body: Node3D) -> void:
	hint_label.hide()
