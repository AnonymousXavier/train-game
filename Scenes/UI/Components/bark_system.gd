extends Node3D
class_name Bark_Component

signal bark_complete

@export var update_background_size_now: bool: ## Allows the animation player to call the update function automatically
	set(value):
		update()

@onready var hint_label: Label3D = $Hint
@onready var background_sprite: Sprite3D = $Background
@onready var life_time_timer: Timer = $LifeTime
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var preparing_to_delete = false
var size: Vector3

func show_bark():
	animation_player.play("popup")

func update():
	if not preparing_to_delete:
		update_background_sprites_size_to_contain_label()
		update_wait_time()
	
func update_wait_time():
	var string_length = len(hint_label.text.split(" "))
	var length_to_delay_ratio = 0.3

	life_time_timer.wait_time = ceil(string_length * length_to_delay_ratio)
	await  animation_player.animation_finished
	life_time_timer.start()
	preparing_to_delete = true

func update_background_sprites_size_to_contain_label():
	var label_size = hint_label.get_aabb().size
	var req_backgrounds_scale = label_size / background_sprite.get_aabb().size
	background_sprite.scale = req_backgrounds_scale * 1.2
	
	size = background_sprite.get_aabb().size

func set_position_above(reference_position: Vector3):
	global_position = reference_position

func _on_life_timer_timeout() -> void:
	animation_player.play_backwards("popup")
	await animation_player.animation_finished
	bark_complete.emit()

func _on_bark_complete() -> void:
	call_deferred("queue_free")
