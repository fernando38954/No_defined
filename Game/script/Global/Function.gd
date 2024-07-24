extends Node

func rand_Vector2():
	var new_dir = Vector2()
	new_dir.x = randf_range(-1, 1)
	new_dir.y = randf_range(-1, 1)
	return new_dir.normalized()

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout

func reset_all():
	PlayerStatus.global_position = Vector2(0, 0)

	PlayerStatus.can_move = true
	PlayerStatus.can_dash = true
	PlayerStatus.in_dash = false

	PlayerStatus.can_attack = true
	PlayerStatus.in_attack = false
	PlayerStatus.need_reset = false

	PlayerStatus.in_attack_range = false

	PlayerStatus.muzzle_position = Vector2(0, 0)
	PlayerStatus.direction = Vector2(0, 0)

	PlayerStatus.maxHP = 100
	PlayerStatus.HP = 100
	PlayerStatus.backHP = 100
	PlayerStatus.maxShield = 100
	PlayerStatus.Shield = 100
	PlayerStatus.backShield = 100

	PlayerStatus.Element1 = PlayerStatus.Element.Null
	PlayerStatus.Element2 = PlayerStatus.Element.Null
	PlayerStatus.Element3 = PlayerStatus.Element.Null
	PlayerStatus.Element4 = PlayerStatus.Element.Null
	PlayerStatus.Element5 = PlayerStatus.Element.Null
