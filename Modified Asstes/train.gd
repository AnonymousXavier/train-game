extends Node3D

@onready var lights_markers_front: Node3D = $LightsMarkersFront
@onready var lights_markers_back: Node3D = $LightsMarkersBack

@onready var lights_container: Node3D = $Light

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# spawn_lights_at_windows()
	pass


func spawn_lights_at_windows():
	for marker in lights_markers_front.get_children():
		var light_scene = Cache.train_window_light_scene.instantiate()
		lights_container.add_child(light_scene)
		light_scene.global_position = marker.global_position
		
	for marker in lights_markers_back.get_children():
		var light_scene = Cache.train_window_light_scene.instantiate()
		lights_container.add_child(light_scene)
		light_scene.global_position = marker.global_position
		
		
