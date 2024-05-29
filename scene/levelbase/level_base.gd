extends Node2D

@onready var player_cam: Camera2D = $PlayerCam
@onready var player: CharacterBody2D = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previou frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	player_cam.position = player.position
