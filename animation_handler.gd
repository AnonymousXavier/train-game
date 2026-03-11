extends Node3D

@export var model: Node3D

var anim_player: AnimationPlayer
var move_velocity = Vector3.ZERO

var state: Enums.STATES = Enums.STATES.IDLE

func _ready() -> void:
	anim_player = model.get_node("AnimationPlayer") as AnimationPlayer
	anim_player.connect("animation_finished", _on_animation_finished)
	anim_player.play("Idle")
	
func _process(_delta: float) -> void:
	state_handler()
	
func state_handler():
	if move_velocity != Vector3.ZERO:
		change_state_to(Enums.STATES.WALK)
	else:
		change_state_to(Enums.STATES.IDLE)
		
func change_state_to(new_state: Enums.STATES):
	if state == new_state:
		anim_player.animation_finished.emit("")
	state = new_state
	
func _on_animation_finished(_anim_name: String):
	match state:
		Enums.STATES.IDLE:
			anim_player.play("Idle")
		Enums.STATES.WALK:
			anim_player.play("Walk")
	
	
