extends Node3D

@onready var anim_player: AnimationPlayer = $AnimationPlayer
enum STATE {OPEN, CLOSED}

var state: STATE = STATE.CLOSED

func _on_actionable_activated() -> void:
	if state == STATE.CLOSED:
		anim_player.play("open")
		state = STATE.OPEN


func _on_actionable_out_of_range(_body) -> void:
	if state == STATE.OPEN:
		anim_player.play_backwards("open")
		state = STATE.CLOSED
