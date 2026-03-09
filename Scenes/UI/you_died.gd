extends Control

func _on_return_to_last_checkpoint_pressed() -> void:
	Misc.reset_scene_to_last_checkpoint()
	SceneInstances.you_died_control_scene.hide()
