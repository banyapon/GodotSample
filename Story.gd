extends Node2D

func _process(delta):
	if Input.is_key_pressed(KEY_ENTER):
		await get_tree().create_timer(0.8).timeout
		get_tree().change_scene_to_file("res://World.tscn")
	pass
