extends CharacterBody2D

var speed: int = 75
enum Direction { NORTH, SOUTH, EAST, WEST }
var currentDirection: Direction = Direction.SOUTH

func _physics_process(_delta):
	velocity = Vector2.ZERO

	if buttonPressed(Direction.NORTH):
		if not (buttonPressed(Direction.SOUTH) or buttonPressed(Direction.EAST) or buttonPressed(Direction.WEST)):
			velocity.y = -speed/2
			currentDirection = Direction.NORTH
			turnLeftAnimation(false)
	elif buttonPressed(Direction.SOUTH):
		if not (buttonPressed(Direction.EAST) or buttonPressed(Direction.WEST)):
			velocity.y = speed/2
			currentDirection = Direction.SOUTH
			turnLeftAnimation(false)
	elif buttonPressed(Direction.EAST):
		if not (buttonPressed(Direction.WEST)):
			currentDirection = Direction.EAST
			velocity.x = speed
			turnLeftAnimation(false)
	elif buttonPressed(Direction.WEST):
		velocity.x = -speed
		currentDirection = Direction.WEST
		turnLeftAnimation(true)

	move_and_slide()
	
	var animationKey: String = ""
	if(playerIsMoving()):
		animationKey = "walking_"
	match currentDirection:
		Direction.NORTH:
			animationKey += "north"
		Direction.SOUTH:
			animationKey += "south"
		Direction.EAST, Direction.WEST:
			animationKey += "horizontal"
	$AnimationPlayer.play(animationKey)
		

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

func turnLeftAnimation(flip: bool):
	$Sprite.flip_h = flip

func playerIsMoving():
	return velocity != Vector2.ZERO
	
