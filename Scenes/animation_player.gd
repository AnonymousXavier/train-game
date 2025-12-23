extends AnimationPlayer

var npc_animPlayer: AnimationPlayer
@export var anim_state: Enums.STATES:
	set(value):
		anim_state =value
		play_animation(value)
	
func play_animation(value: int):
	var anim_name: String
	print(value)
	match value:
		Enums.STATES.IDLE:
			anim_name = "Idle"
		Enums.STATES.RUN:
			anim_name = "Run"
	
	print(npc_animPlayer)
	npc_animPlayer.play(anim_name)
