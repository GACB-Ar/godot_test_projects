extends Label

var x_velocity: int = 150
var y_velocity: int = 120
var velocity: Vector2 = Vector2(x_velocity, y_velocity)
var screen_size_x: float
var screen_size_y: float
var label_size_x: float
var label_size_y: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "DVD\nPlayer"
	# Get the viewport size	
	screen_size_x = get_viewport_rect().size.x
	screen_size_y = get_viewport_rect().size.y
	label_size_x = size.x
	label_size_y = size.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = position + velocity * delta
	if position.x < 0 or position.x + label_size_x > screen_size_x:
		velocity.x*= -1
		position.x = clamp(position.x, 0, screen_size_x - label_size_x)

	if position.y < 0 or position.y + label_size_y > screen_size_y:
		velocity.y *= -1
		position.y = clamp(position.y, 0, screen_size_y - label_size_y)
