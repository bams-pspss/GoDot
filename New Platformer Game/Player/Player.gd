extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#Must use onready -> to access the animation node
@onready var anim = get_node("AnimationPlayer")
#Will animate the sprite "idle" thingy -> match with the animators name
func _ready():
	anim.play("idle")
	
	
func _physics_process(delta):
	# Add the gravity.
	#If the player is not on the floor
	if not is_on_floor():
		#Pull the player down
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("Jump")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	# IF it's go to the right = 1
	# IF it's go to the left = -1
	# IF Neither its gotta be 0
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction == -1:
		#Flip_h is for flipping the image
		#So here we check if the directio is left
		#We flip the animation
		get_node("AnimatedSprite2D").flip_h = true
	else:
		get_node("AnimatedSprite2D").flip_h = false
	if direction:
		velocity.x = direction * SPEED
		#Check if sprite is not on floor(?) or in air
		if velocity.y == 0:
			anim.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("Idle")
		if velocity.y > 0:
			anim.play("Fall")


	#Build-in function -> let character move and slide
	move_and_slide()
