extends CharacterBody2D

class_name EnemyBase

enum FACING {LEFT = -1, RIGHT = 1}

const OFF_SCREEN_KILL_ME: float = 1000.0

@export var default_facing : FACING = FACING.LEFT
@export var points: int = 1
@export var speed : float = 30.0


var gravity: float = 800.0
var facing : FACING = default_facing
var player_ref : Player
var dying : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_ref = get_tree().get_nodes_in_group(GameManager.GROUP_PLAYER)[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	fallen_off()


func fallen_off() -> void:
	if global_position.y > OFF_SCREEN_KILL_ME:
		queue_free()

func die() :
	
	if dying == true:
		return
	
	dying = true
	SignalManager.on_enemy_hit.emit(points, global_position)
	set_physics_process(false)
	hide()
	queue_free()



func _on_visible_on_screen_enabler_2d_screen_entered() -> void:
	pass # Replace with function body.


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	pass # Replace with function body.
