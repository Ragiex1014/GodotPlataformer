extends EnemyBase

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player_detector: RayCast2D = $PlayerDetector
@onready var direction_timer: Timer = $DirectionTimer

const FLY_SPEED: Vector2 = Vector2(35, 15)

var fly_direction : Vector2 = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	
	velocity = fly_direction
	move_and_slide()
	

func set_and_flip() -> void:
	var x_dir = sign(player_ref.global_position.x - global_position.x)
	
	if x_dir > 0:
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false
		
	fly_direction = Vector2(x_dir, 1) * FLY_SPEED

func fly_to_player() -> void:
	set_and_flip()
	direction_timer.start()

func _on_visible_on_screen_enabler_2d_screen_entered() -> void:
	animated_sprite_2d.play("fly")
	fly_to_player()



func _on_direction_timer_timeout() -> void:
	fly_to_player()
