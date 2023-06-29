extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation = get_node("AnimationPlayer")
var player
var chase = false
var alive = true



func _ready():
	animation.play("Idle")



func _physics_process(delta):
	player = get_node("../../Player/Player")
	var direction = (player.position - self.position).normalized()
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
#	Horizontal
	if chase == true:
		if direction.x > 0.1:
			velocity.x = direction.x * SPEED
			get_node("AnimatedSprite2D").flip_h = true
		elif direction.x < -0.1:
			velocity.x = direction.x * SPEED
			get_node("AnimatedSprite2D").flip_h = false
		else:
			velocity.x = 0
			velocity.y += gravity * delta
			chase = false
	
#	Vertical movement
	if chase == true and is_on_floor():
		velocity.y = JUMP_VELOCITY
#	Vertical animation
	if velocity.y <= -10:
		animation.play("Jump")
	elif velocity.y >= 10:
		animation.play("Fall")
	elif alive == true:
		animation.play("Idle")
		
	move_and_slide()



func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true



func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false
		velocity.x = 0


func _on_player_death_body_entered(body):
	if body.name == "Player":
		chase = false
		alive = false
		get_node("AnimatedSprite2D").play("Death")
		await get_node("AnimatedSprite2D").animation_finished
		self.queue_free()
		
