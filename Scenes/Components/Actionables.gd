extends Area3D
class_name Actionable

signal activated
signal in_range(body)
signal out_of_range(body)

@onready var hint_label: Label3D = $Label3D
@export var prompt_text: String = "Talk (X)"
var body_in_range = false

func _ready() -> void:
	hint_label.text = prompt_text
	hint_label.hide()
	
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if Input.get_action_strength("interact") and body_in_range:
			activated.emit()

func _on_body_entered(body: Node3D) -> void:
	hint_label.show()
	in_range.emit(body)
	body_in_range = true
	
func _on_body_exited(body: Node3D) -> void:
	hint_label.hide()
	out_of_range.emit(body)
	body_in_range = false
