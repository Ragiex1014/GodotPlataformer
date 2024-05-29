extends Node

enum BULLET_KEY {PLAYER, ENEMY}

const BULLETS = {
	BULLET_KEY.PLAYER : preload("res://scene/enemies/bullets/bulletplayer/bullet_player.tscn"),
	BULLET_KEY.ENEMY : preload("res://scene/enemies/bullets/bulletenemy/bullet_enemy.tscn")
}

func add_child_deferred(child_to_add) -> void :
	get_tree().root.add_child(child_to_add)

func call_add_child(child_to_add) -> void:
	call_deferred("add_child_deferred", child_to_add)

func create_bullet(speed : float, direction : Vector2, life_span : float, key: BULLET_KEY, start_position : Vector2) -> void:
	
	var new_bullet : Bullet = BULLETS[key].instantiate()
	new_bullet.setup(direction, life_span, speed)
	new_bullet.position = start_position
	call_add_child(new_bullet)
