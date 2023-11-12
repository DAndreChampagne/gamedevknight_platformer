extends CharacterBody2D

@export var speed = 200.0
@export var jump_velocity = -350.0

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D



var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
	if Input.is_action_just_pressed("left"):
		sprite.scale.x = abs(sprite.scale.x) * -1
	elif Input.is_action_just_pressed("right"):
		sprite.scale.x = abs(sprite.scale.x)
	
	
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		animation.play("idle")
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
