extends CharacterBody2D

var bulletSprite
var wait_time = 0.0
var visible_time = 0.08
var end_time = 0.15

var bulletDirection

func _ready():
	bulletDirection = Global.global_direction
	bulletSprite = get_node("AnimatedSprite2D")
	get_node("CollisionShape2D").disabled = true
	pass 


func _process(delta):
	if bulletDirection < 0:
		bulletSprite.set_flip_h(true)
		translate(Vector2(-7,0))
	else:
		bulletSprite.set_flip_h(false)
		translate(Vector2(7,0))
	
	wait_time += delta
	if wait_time > visible_time:
		get_node("CollisionShape2D").disabled = false
	
	if wait_time > end_time:
		queue_free()
	
	pass
