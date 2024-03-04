extends CharacterBody2D

var wait_time = 0.0
var end_time = 0.3
var destroy_time = 0.7
var hp = 1

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	set_process(true)
	pass 
	
func _process(delta):
	translate(Vector2(-0.2,0))
	var collision = move_and_collide(Vector2(0,15))
	if collision:
		if collision.get_collider().name == "bullet(Clone)":
			hp = hp-1
			print("Hit",hp)
			get_node("AnimatedSprite2D").play("Death")
	
	if hp < 0:
		translate(Vector2.ZERO)
		wait_time += delta
		if wait_time > end_time:
			#get_node("CollisionShape2D").disabled = true
			if wait_time >= destroy_time:
				destroy()		

func destroy():
	queue_free()
