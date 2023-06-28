extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#@onready var animation = get_node("AnimatedSprite2D")
@onready var animation = get_node("AnimationPlayer")

#func _ready():
#	get_node("AnimatedSprite2D").play("Idle")
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		animation.play("Jump")
		velocity.y = JUMP_VELOCITY
	if velocity.y > 0:
		animation.play("Fall")
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		if velocity.y == 0:
			animation.play("Run")
		velocity.x = direction * SPEED
	else:
		if velocity.y == 0:
			animation.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
		
	
	move_and_slide()
