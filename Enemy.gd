extends CharacterBody2D

var wait_time = 0.0
var end_time = 0.1
var hp = 2
var destroy_time = 0.7

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	get_node("CollisionShape2D").disabled = false
	set_process(true)
	pass 


func _process(delta):
	translate(Vector2(-0.3,0))
	var collision = move_and_collide(Vector2(0,3))
	if collision:
		if collision.get_collider().name == "Death":
			queue_free()
		if collision.get_collider().name == "bullet(Clone)":
			hp = hp-1
			print("HP:",hp)
			
		if hp < 0:
			hp =0
			wait_time += delta
			if wait_time > end_time:
				get_node("CollisionShape2D").disabled = true
				translate(Vector2(0,0))
				get_node("AnimatedSprite2D").play("Death")
				if wait_time >= destroy_time:
					queue_free()
	pass
