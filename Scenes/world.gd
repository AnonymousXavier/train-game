extends Node3D

@onready var animPlayer = $AnimationPlayer
@onready var player: CharacterBody3D = $Player

func _ready() -> void:
	(player.initiated_dialogue as Signal).connect(play_scene_animations)
	animPlayer.npc_animPlayer = $"NPCs/Cargo 2/Business Woman/AnimationPlayer"
	print($"NPCs/Cargo 2/Business Woman/AnimationPlayer", animPlayer.npc_animPlayer)

func play_scene_animations(_dialogue_interactable):
	print(_dialogue_interactable)
	$AnimationPlayer.play("Scene 1")
