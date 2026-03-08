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
	print(move_velocity)
	if not (abs(move_velocity.x) < 0.01 and abs(move_velocity.z) < 0.01 and abs(move_velocity.y) < 0.01):
		if state == Enums.STATES.RUN:
			anim_player.animation_finished.emit("")
		state = Enums.STATES.RUN
	else:
		if state == Enums.STATES.IDLE:
			anim_player.animation_finished.emit("")
		state = Enums.STATES.IDLE
	
func _on_animation_finished(_anim_name: String):
	match state:
		Enums.STATES.IDLE:
			anim_player.play("Idle")
		Enums.STATES.RUN:
			anim_player.play("Run")
	
	
