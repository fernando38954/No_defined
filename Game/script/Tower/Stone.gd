class_name Stone
extends CharacterBody2D

const SpawnCD = 30
var timer_spawn = SpawnCD

var golem = ["res://object/Character/Enemy/airgolem.tscn", "res://object/Character/Enemy/firegolem.tscn",
			"res://object/Character/Enemy/earthgolem.tscn", "res://object/Character/Enemy/watergolem.tscn"]

func _physics_process(delta):
	if Function.erase:
		queue_free()
		
	Function.stoneHP = min(Function.stoneHP + 5 * delta, 3000)
	
	if timer_spawn == 0:
		for i in 4:
			var enemy = load(golem[i]).instantiate()
			var rand_position = Vector2(randf_range(-384, 384), randf_range(-384, 384))
			var diff = abs(PlayerStatus.global_position - rand_position)
			while diff.x < 50 or diff.x > 120:
				rand_position.x = randf_range(-384, 384)
				diff = abs(PlayerStatus.global_position - rand_position)
			while  diff.y < 50 or diff.y > 120:
				rand_position.y = randf_range(-384, 384)
				diff = abs(PlayerStatus.global_position - rand_position)
			enemy.global_position = rand_position
			get_tree().root.add_child(enemy)
		timer_spawn = SpawnCD
	timer_spawn = move_toward(timer_spawn, 0, delta)
	
	if Function.stoneHP <= 0:
		Function.erase = true
		get_tree().change_scene_to_file("res://scene/Title.tscn")
