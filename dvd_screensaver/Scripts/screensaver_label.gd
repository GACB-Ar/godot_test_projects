extends Label

var x_velocity: int = 150
var y_velocity: int = 120
var velocity: Vector2 = Vector2(x_velocity, y_velocity)
var screen_size_x: float
var screen_size_y: float
var label_size_x: float
var label_size_y: float

# initialzation of counter for wait_delta()
var tu_counter: float = 0.01


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "DVD\nPlayer"
	# get screen data
	screen_size_x = get_viewport_rect().size.x
	screen_size_y = get_viewport_rect().size.y
	
	# get label data
	label_size_x = size.x
	label_size_y = size.y
	
	## viewport and label details:
	game_state_data("viewport")
	game_state_data("label")
	print("\n")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = position + velocity * delta
	
	## Current velocity direction and position
	if wait_delta(delta, 1):
		game_state_data("velocity")
		game_state_data("position")
	
	if position.x < 0 or position.x + label_size_x > screen_size_x:
		velocity.x *= -1
		position.x = clamp(position.x, 0, screen_size_x - label_size_x)

	if position.y < 0 or position.y + label_size_y > screen_size_y:
		velocity.y *= -1
		position.y = clamp(position.y, 0, screen_size_y - label_size_y)
	

func wait_delta(delta_param: float, time_unit: float) -> bool:
	# Check if an specified time unit has passed in the game execution
	tu_counter += delta_param
	if tu_counter >= time_unit:
		tu_counter = 0.0 # reset counter
		return true
	return false

func game_state_data(subject: String) -> void:
	# Print the subject data in the current gamestate
	match subject:
		"viewport":
			print("Viewport size -> x:" + str(screen_size_x) + ", y:" + str(screen_size_y))
		"label":
			print("Label dimensions -> x:" + str(label_size_x) + ", y:" + str(label_size_y))
		"velocity":
			print("Velocity vector -> x:" + str(velocity.x) + ", y:" + str(velocity.y))
		"position":
			print("Current Position -> x:" + str(position.x) + ", y:" + str(position.y))
		_:
			print("No subject found")
