extends Node

const ENEMY_SPAWN_CD = 2

var timer_enemy = 0

func _process(delta):
	if timer_enemy == 0:
		var enemy = load("res://object/Character/enemy.tscn").instantiate()
		var rand_position = Vector2(randf_range(-384, 384), randf_range(-384, 384))
		while abs(PlayerStatus.global_position.x - rand_position.x) < 213:
			rand_position.x = randf_range(-384, 384)
		while abs(PlayerStatus.global_position.y - rand_position.y) < 120:
			rand_position.y = randf_range(-384, 384)
		enemy.global_position = rand_position
		add_child(enemy)
		timer_enemy = ENEMY_SPAWN_CD
	timer_enemy = move_toward(timer_enemy, 0, delta)
