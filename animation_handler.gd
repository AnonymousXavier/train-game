extends Node3D

@export var model: Node3D

var anim_player: AnimationPlayer
var move_velocity = Vector3.ZERO

enum STATES {IDLE, RUN}
var state: STATES = STATES.IDLE

func _ready() -> void:
	anim_player = model.get_node("AnimationPlayer") as AnimationPlayer
	anim_player.connect("animation_finished", _on_animation_finished)
	anim_player.play("Idle")
	
func _process(_delta: float) -> void:
	state_handler()
	
func state_handler():
	if move_velocity != Vector3.ZERO:
		if state == STATES.RUN:
			anim_player.animation_finished.emit("")
		state = STATES.RUN
	else:
		if state == STATES.IDLE:
			anim_player.animation_finished.emit("")
		state = STATES.IDLE
	
func _on_animation_finished(_anim_name: String):
	match state:
		STATES.IDLE:
			anim_player.play("Idle")
		STATES.RUN:
			anim_player.play("Run")
	
	
