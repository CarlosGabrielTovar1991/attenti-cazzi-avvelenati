extends KinematicBody2D

export(float) var movement_speed = 300
export(float) var acceleration = 800
export(float) var friction = 1500

var velocity = Vector2.ZERO
var direction = 'left'
var collision

func _ready():
	pass
func _process(_delta):
	if (Input.is_action_pressed("ui_sprint")):
		movement_speed = 600
		acceleration = 1600
	else:
		movement_speed = 300
		acceleration = 800

func get_input():
	if (direction == 'left'):
		$Sprite.scale.x = $Sprite.scale.y * 1
	elif (direction == 'right'):
		$Sprite.scale.x = $Sprite.scale.y * -1
	if (velocity.length() != 0):
		$BodyAnimations.play("Running")
	if (velocity.length() == 0):
		$BodyAnimations.play("Steady")

func _physics_process(delta):
	var directional_input = Vector2.ZERO
	
	if (Input.is_action_pressed("ui_left")):
		if (!collision || (collision && collision.collider.name != 'AreaLeftWall')):
			directional_input.x = -1
			direction = 'left'
	elif (Input.is_action_pressed("ui_right")):
		if (!collision || (collision && collision.collider.name != 'AreaRightWall')):
			directional_input.x = 1
			direction = 'right'

	if (directional_input != Vector2.ZERO):
		velocity = velocity.move_toward(directional_input * movement_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	get_input()

	collision = move_and_collide(velocity * delta)
