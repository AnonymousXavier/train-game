extends Area3D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

func start_dialogue():
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
