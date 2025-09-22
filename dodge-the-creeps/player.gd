extends Area2D
signal hit

@export var speed: int = 400
var screen_size
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity: Vector2 = Vector2.ZERO # player movement vector
	
	# Player controls
	if Input.is_action_pressed("move_right"): # Check if right directional key is pressed
		velocity.x = 1
	if Input.is_action_pressed("move_left"): # Check if left directional key is pressed
		velocity.x = -1
	if Input.is_action_pressed("move_up"): # Check if up directional key is pressed
		velocity.y = -1
	if Input.is_action_pressed("move_down"): # Check if down directional key is pressed
		velocity.y = 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func start(position_parameter):
	position = position_parameter
	show()
	$CollisionShape2D.disabled = false

func _on_body_entered(body: Node2D) -> void:
	hide() # Replace with function body.
	hit.emit()
	
	$CollisionShape2D.set_deferred("disabled", true)
