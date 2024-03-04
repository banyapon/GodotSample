extends CharacterBody2D

var bulletSprite
var wait_time = 0.0
var visible_time = 0.1
var end_time = 0.19
var current_time = 0.0
var bulletDirection


func _ready():
	set_process(true)
	bulletDirection = Global.global_direction
	bulletSprite = get_node("AnimatedSprite2D")
	get_node("CollisionShape2D").disabled = true
	pass

func _process(delta):
	current_time += delta
	wait_time += delta
	if bulletDirection < 0:
		bulletSprite.set_flip_h(true)
		translate(Vector2(-2,0))
	else:
		bulletSprite.set_flip_h(false)
		translate(Vector2(2,0))
	if current_time >= end_time:
		queue_free()
		current_time = 0
	if wait_time >= visible_time:
		get_node("CollisionShape2D").disabled = false
		wait_time = 0
	pass
