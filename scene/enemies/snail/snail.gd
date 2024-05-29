extends EnemyBase

@onready var floor_detection: RayCast2D = $FloorDetection
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if is_on_floor() == false:
		velocity.y += gravity * delta
	else:
		velocity.x = speed * facing
		
	move_and_slide()
	
	if is_on_floor() == true :
		if is_on_wall() == true or floor_detection.is_colliding() == false:
			flip_me()


func flip_me() -> void:
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	floor_detection.position.x = floor_detection.position.x * -1
	
	if facing == FACING.LEFT:
		facing = FACING.RIGHT
	else:
		facing = FACING.LEFT
