extends Node

const ENEMY_SPAWN_CD = 2

var timer_enemy = 0
var timer_drop = 5

func _ready():
	Function.reset_all()

func _process(delta):
	if timer_enemy == 0:
		var enemy = load("res://object/Character/Enemy/Slime.tscn").instantiate()
		var rand_position = Vector2(randf_range(-384, 384), randf_range(-384, 384))
		var diff = abs(PlayerStatus.global_position - rand_position)
		while diff.x < 50 or diff.x > 120:
			rand_position.x = randf_range(-384, 384)
			diff = abs(PlayerStatus.global_position - rand_position)
		while  diff.y < 50 or diff.y > 120:
			rand_position.y = randf_range(-384, 384)
			diff = abs(PlayerStatus.global_position - rand_position)
		enemy.global_position = rand_position
		add_child(enemy)
		timer_enemy = ENEMY_SPAWN_CD
	timer_enemy = move_toward(timer_enemy, 0, delta)
	
	if timer_drop == 0:
		var drop = load("res://object/Drops/ElementBall.tscn").instantiate()
		drop.global_position = Vector2(0, 0)
		drop.start(randi_range(1,4))
		add_child(drop)
		timer_drop = 10
	timer_drop = move_toward(timer_drop, 0, delta)
	
	if PlayerStatus.HP <= 0:
		get_tree().change_scene_to_file("res://scene/Main.tscn")
