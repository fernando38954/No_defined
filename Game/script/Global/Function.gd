extends Node

var stoneSpawned = false
var stoneHP = 3000
var erase = true

func rand_Vector2():
	var new_dir = Vector2()
	new_dir.x = randf_range(-1, 1)
	new_dir.y = randf_range(-1, 1)
	return new_dir.normalized()

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout

func reset_all():
	get_tree().paused = false
	
	stoneSpawned = false
	stoneHP = 300
	erase = false

	PlayerStatus.global_position = Vector2(0, 0)

	PlayerStatus.can_move = true
	PlayerStatus.can_dash = true
	PlayerStatus.in_dash = false
	PlayerStatus.timer_dash = 0

	PlayerStatus.can_attack = true
	PlayerStatus.in_attack = false
	PlayerStatus.need_reset = false

	PlayerStatus.in_attack_range = false

	PlayerStatus.muzzle_position = Vector2(0, 0)
	PlayerStatus.direction = Vector2(0, 0)

	PlayerStatus.attack_position = null
	PlayerStatus.golem_defeat = 0

	PlayerStatus.in_burnArea = 0
	PlayerStatus.in_frozenArea = 0

	PlayerStatus.maxHP = 100
	PlayerStatus.HP = 100
	PlayerStatus.backHP = 100
	PlayerStatus.maxShield = 100
	PlayerStatus.Shield = 0
	PlayerStatus.backShield = 0

	PlayerStatus.ElementSet = [PlayerStatus.Element.Null, PlayerStatus.Element.Null, PlayerStatus.Element.Null, PlayerStatus.Element.Null, PlayerStatus.Element.Null]
	PlayerStatus.ElementQty = [5, 0, 0, 0, 0]
