extends CharacterBody2D


@export var speed : float = 200.0
@export var jump_velocity : float = -275.0

@onready var player: CharacterBody2D = $"."
#@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sword_swing: AudioStreamPlayer2D = $SwordSwing


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var isAttacking = false
@export var isDead = false

func swordAttack():
	if not isDead:
		print("Begin Sword Attack")
		isAttacking = true

	#get overlapping areas
	#var overlapping_objects = $AttackArea.get_overlapping_areas()
	
	#for area in overlapping_objects:
	#	var parent = area.get_parent()
	#	print(parent.name)
		
		sword_swing.play()
		animation_player.play("SwordAttack")
		print("End Sword Attack")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	
	# direction can = 0, 1, -1 determine the direction and flip if necesary
	if direction > 0:
		sprite_2d.flip_h = false
		get_node("AttackArea").set_scale(Vector2(1, 1))
	elif direction < 0:
		sprite_2d.flip_h = true
		get_node("AttackArea").set_scale(Vector2(-1, 1))
	
	#play animations
	if is_on_floor():
		if Input.is_action_just_pressed("attack") and not isAttacking:
				#isAttacking = true
				#animation_player.play("SwordAttack")
				swordAttack()
				#print("attacking")
		if direction == 0:
			if not isAttacking:
				animation_player.play("Idle")
				#qprint("idle")
		else:
			if not isAttacking:
				animation_player.play("Walk")
				#print("walking")
		
	else:
		#print("falling")
		animation_player.play("Jump")
			
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
