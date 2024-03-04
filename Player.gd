extends CharacterBody2D

var input_direction = 0
var direction = 0
const bulletPath = preload("res://Bullet.tscn")

const SPEED = 300.0
const JUMP_VELOCITY = -300.0

var isAttackPressed = false
var fire_rate = 0.0
var next_fire = 0.2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		
		velocity.y = JUMP_VELOCITY
		
	if !is_on_floor():
		get_node("AnimatedSprite2D").play("Jump")
	else:
		get_node("AnimatedSprite2D").play("RunShoot")
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
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
		get_node("AnimatedSprite2D").play("RunShoot")
		get_node("AnimatedSprite2D").set_flip_h(false)
	elif velocity.x < 0:
		get_node("AnimatedSprite2D").play("RunShoot")
		get_node("AnimatedSprite2D").set_flip_h(true)
	else:
		get_node("AnimatedSprite2D").play("Idle")
	move_and_slide()
	
	if isAttackPressed == true:
		get_node("AnimatedSprite2D").play("Idle")

	if Input.is_key_pressed(KEY_P):
		if isAttackPressed == false:
			fire()
			isAttackPressed = true
		else:
			get_node("AnimatedSprite2D").play("Idle")
			
	fire_rate += delta
	if fire_rate >= next_fire:
		fire_rate = 0.0
		isAttackPressed = false

func fire():
	get_node("AnimatedSprite2D").play("Attack")
	var bullet = bulletPath.instantiate()
	bullet.set_name("bullet(Clone)")
	get_node(".").add_child(bullet)
	pass
