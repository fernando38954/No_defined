extends Node

const NEARBY_ENEMY_SPAWN_CD = 5
const PORTAL_ENEMY_SPWAN_CD = 20

var timer_nearby_enemy_spawn = 5
var timer_portal_enemy_spawn = 10

var timer_spawn_stone = 5

func _ready():
	Function.reset_all()
	$GameUi/Pause.hide()
	$PortalTop.play("default")
	$PortalLeft.play("default")
	$PortalDown.play("default")
	$PortalRight.play("default")
	DialogueManager.show_example_dialogue_balloon(load("res://dialog/Intro.dialogue"), "battle")

func _process(delta):	
	# Pause
	if Input.is_action_just_pressed("key_pause") and DialogueManager.dialogue_ended:
		$GameUi/TransitionScreen.hide()
		$GameUi/Pause.show()
		$GameUi/Pause.active = true
		$GameUi/Pause.delay_pause = $GameUi/Pause.PauseCD
		get_tree().paused = true
	
	# Nearby enemy spawn
	if timer_nearby_enemy_spawn == 0:
		var enemy = load("res://object/Character/Enemy/slime.tscn").instantiate()
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
		timer_nearby_enemy_spawn = NEARBY_ENEMY_SPAWN_CD
	timer_nearby_enemy_spawn = move_toward(timer_nearby_enemy_spawn, 0, delta)
	
	# Portal enemy spawn
	if timer_portal_enemy_spawn == 0:
		# Special Slime
		var special_enemy_id = [randi_range(0, 3), randi_range(0, 3), randi_range(0, 3), randi_range(0, 3)]
		var special_enemy = [load("res://object/Character/Enemy/airslime.tscn"), load("res://object/Character/Enemy/fireslime.tscn"),
							load("res://object/Character/Enemy/earthslime.tscn"), load("res://object/Character/Enemy/waterslime.tscn")]
			
		# Normal Slime
		for i in randi_range(2, 4) + 1:
			var enemy = load("res://object/Character/Enemy/slime.tscn").instantiate() if i > 0 else special_enemy[special_enemy_id[0]].instantiate()
			var rand_position = Vector2(randf_range(-30, 30), randf_range(0, 40))
			enemy.global_position = $PortalTop.global_position + rand_position
			add_child(enemy)
		for i in randi_range(2, 4) + 1:
			var enemy = load("res://object/Character/Enemy/slime.tscn").instantiate() if i > 0 else special_enemy[special_enemy_id[1]].instantiate()
			var rand_position = Vector2(randf_range(0, 40), randf_range(-30, 30))
			enemy.global_position = $PortalLeft.global_position + rand_position
			add_child(enemy)
		for i in randi_range(2, 4) + 1:
			var enemy = load("res://object/Character/Enemy/slime.tscn").instantiate() if i > 0 else special_enemy[special_enemy_id[2]].instantiate()
			var rand_position = Vector2(randf_range(-30, 30), randf_range(-40, 0))
			enemy.global_position = $PortalDown.global_position + rand_position
			add_child(enemy)
		for i in randi_range(2, 4) + 1:
			var enemy = load("res://object/Character/Enemy/slime.tscn").instantiate() if i > 0 else special_enemy[special_enemy_id[3]].instantiate()
			var rand_position = Vector2(randf_range(-40, 0), randf_range(-30, 30))
			enemy.global_position = $PortalRight.global_position + rand_position
			add_child(enemy)
		
		timer_portal_enemy_spawn = PORTAL_ENEMY_SPWAN_CD
	timer_portal_enemy_spawn = move_toward(timer_portal_enemy_spawn, 0, delta)
	
	if PlayerStatus.HP <= 0:
		$GameUi/TransitionScreen.transition("fade_out")
		await get_tree().create_timer(1).timeout
		Function.erase = true
		get_tree().change_scene_to_file("res://scene/FinalScene.tscn")
	
	if PlayerStatus.golem_defeat >= 4 and not Function.stoneSpawned:
		if timer_spawn_stone == 0:
			var enemy = load("res://object/Tower/Stone.tscn").instantiate()
			enemy.global_position = Vector2(0, 0)
			add_child(enemy)
			Function.stoneSpawned = true
		timer_spawn_stone = move_toward(timer_spawn_stone, 0, delta)
	
	if Input.is_action_just_pressed("TestAir"):
		var drop = load("res://object/Drops/ElementBall.tscn").instantiate()
		drop.global_position = Vector2(0, 0)
		drop.start(1)
		add_child(drop)
	
	if Input.is_action_just_pressed("TestFire"):
		var drop = load("res://object/Drops/ElementBall.tscn").instantiate()
		drop.global_position = Vector2(0, 0)
		drop.start(2)
		add_child(drop)
	
	if Input.is_action_just_pressed("TestEarth"):
		var drop = load("res://object/Drops/ElementBall.tscn").instantiate()
		drop.global_position = Vector2(0, 0)
		drop.start(3)
		add_child(drop)
	
	if Input.is_action_just_pressed("TestWater"):
		var drop = load("res://object/Drops/ElementBall.tscn").instantiate()
		drop.global_position = Vector2(0, 0)
		drop.start(4)
		add_child(drop)
