extends CharacterBody2D

var isAttackPressed = false
var fire_rate = 0.0
var next_fire = 0.2

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var animator

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var input_direction = 0
var direction = 0
const bulletPath = preload("res://Bullet.tscn")

func _ready():
	animator = get_node("AnimatedSprite2D")
	pass

func _physics_process(delta):
	if not is_on_floor():
		animator.play("Jump")
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		
		velocity.y = JUMP_VELOCITY

	direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction > 0:
		Global.global_direction = 1
	elif direction < 0:
		Global.global_direction = -1
		
	if velocity.x > 0:
		animator.play("Run")
		animator.set_flip_h(false)
	elif velocity.x < 0:
		animator.play("Run")
		animator.set_flip_h(true)
	else:
		animator.play("Idle")

	move_and_slide()
	
	if Input.is_key_pressed(KEY_P):
		animator.play("Shoot")
		if direction:
			animator.play("Run")
		if isAttackPressed == false:
			fire()
			isAttackPressed = true
	
	fire_rate += delta
	if fire_rate >= next_fire:
		fire_rate = 0.0
		isAttackPressed = false
		
	var collision = move_and_collide(Vector2(direction,0))
	if collision:
		print("check: ",str(collision.get_collider().name))
		if "Enemy" in collision.get_collider().name:
			await get_tree().create_timer(0.5).timeout
			get_tree().change_scene_to_file("res://GameOver.tscn")
			
	var collisionDeath = move_and_collide(Vector2(direction,450))
	if collisionDeath:
		if "Death" in collisionDeath.get_collider().name:
			await get_tree().create_timer(0.5).timeout
			get_tree().change_scene_to_file("res://GameOver.tscn")
			print ("hit")
	pass


func fire():
	var bullet = bulletPath.instantiate()
	bullet.set_name("bullet(Clone)")
	get_node(".").add_child(bullet)
	pass
