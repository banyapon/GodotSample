extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var speed = 200 # Adjust as needed
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#var player = get_tree().get_root().find_node("Player", true, false) # Assume "Player" exists
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		var direction_to_player = (global_position - player.global_position).normalized()
		velocity.x = direction_to_player * speed
		move_and_slide()
	pass
	
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		print("Hit Player")

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		print("Exit Player")
