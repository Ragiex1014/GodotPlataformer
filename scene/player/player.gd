extends CharacterBody2D

class_name Player

@onready var debug_label: Label = $DebugLabel
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sound: AudioStreamPlayer2D = $Sound

enum  PLAYER_STATE {IDLE, JUMP, RUN, HURT, FALL}

var state : PLAYER_STATE = PLAYER_STATE.IDLE

const GRAVITY :float = 1000.0
const RUN_SPEED :float = 120.0
const MAX_FALL :float = 400.0
const HURT_TIME :float = 0.3
const JUMP_VELOCITY :float = -400.0


func _physics_process(delta: float) -> void:
	if is_on_floor() == false:
		velocity.y += GRAVITY * delta
		
	get_input()
	move_and_slide()
	calculate_states()
	update_debug_label()

func get_input() -> void :
	
	velocity.x = 0
	
	if Input.is_action_pressed("left") == true :
		sprite_2d.flip_h = true
		velocity.x = -RUN_SPEED
	elif Input.is_action_pressed("right") == true :
		sprite_2d.flip_h = false
		velocity.x = RUN_SPEED
	
	if Input.is_action_just_pressed("jump") and is_on_floor() == true :
		velocity.y = JUMP_VELOCITY
		SoundManager.play_clip(sound,SoundManager.SOUND_JUMP)
	
	if Input.is_action_just_pressed("shoot") == true :
		Factory.create_bullet(250.0 , Vector2.RIGHT, 20.0, Factory.BULLET_KEY.PLAYER, global_position)
	velocity.y = clampf(velocity.y, JUMP_VELOCITY, MAX_FALL)

func calculate_states() -> void :
	
	if state == PLAYER_STATE.HURT:
		pass
	
	
	if is_on_floor() == true:
		if velocity.x == 0:
			set_state(PLAYER_STATE.IDLE)
		else :
			set_state(PLAYER_STATE.RUN)
	else:
		if velocity.y >= 0:
			set_state(PLAYER_STATE.FALL)
		else :
			set_state(PLAYER_STATE.JUMP)
			
			

func set_state(new_state : PLAYER_STATE) -> void:
	if new_state == state:
		return
	
	if state == PLAYER_STATE.FALL:
		if new_state == PLAYER_STATE.IDLE or new_state == PLAYER_STATE.RUN:
			SoundManager.play_clip(sound,SoundManager.SOUND_LAND)
	
	state = new_state
	
	match state :
		PLAYER_STATE.IDLE:
			animation_player.play("idle")
		PLAYER_STATE.RUN:
			animation_player.play("run")
		PLAYER_STATE.FALL:
			animation_player.play("fall")
		PLAYER_STATE.JUMP:
			animation_player.play("jump")
		PLAYER_STATE.HURT:
			animation_player.play("hurt")
			
func update_debug_label() -> void:
	debug_label.text = "isFloor: %s\n state: %s\n x: %.0f y: %.0f" %[
		is_on_floor(),
		PLAYER_STATE.keys()[state],
		velocity.x,
		velocity.y
	] 


func _on_hurt_box_area_entered(area: Area2D) -> void:
	print("player HIT : ", area)
