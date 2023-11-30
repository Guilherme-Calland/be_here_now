extends CharacterBody2D

var speed: int = 50

enum Direction { NORTH, SOUTH, EAST, WEST }

func _physics_process(delta):
	velocity = Vector2.ZERO

	if buttonPressed(Direction.NORTH):
		if not (buttonPressed(Direction.SOUTH) or buttonPressed(Direction.EAST) or buttonPressed(Direction.WEST)):
			velocity.y = -speed
	elif buttonPressed(Direction.SOUTH):
		if not (buttonPressed(Direction.EAST) or buttonPressed(Direction.WEST)):
			velocity.y = speed
	elif buttonPressed(Direction.EAST):
		if not (buttonPressed(Direction.WEST)):
			velocity.x = speed
	elif buttonPressed(Direction.WEST):
		velocity.x = -speed

	move_and_slide()

func buttonPressed(direction: Direction) -> bool:
	match direction:
		Direction.NORTH:
			return Input.is_action_pressed("north")
		Direction.SOUTH:
			return Input.is_action_pressed("south")
		Direction.EAST:
			return Input.is_action_pressed("east")
		Direction.WEST:
			return Input.is_action_pressed("west")

	# Default case
	return false

