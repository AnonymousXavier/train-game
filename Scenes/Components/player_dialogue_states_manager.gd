extends Node3D

@onready var just_heard_scream_dialogue: Dialogue_Actionable = $"Just Heard Scream Dialogue"
@onready var delay_timer: Timer = $DelayTimer

func _on_game_start_delay_timer_timeout() -> void: ## Implements the beginning scream
	just_heard_scream_dialogue.start_dialogue()
