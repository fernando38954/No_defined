extends Golem

var enemy = []

var REGENERATE_CD = .1
var timer_regenerate = REGENERATE_CD
var Regenerate = 5

func _ready():
	HP = 300
	MAX_HP = 300
	WEIGHT = 3
	SPEED = 10 + randi_range(-2, 2)
	NORMAL_ATTACK_CD = 2
	NORMAL_ATTACK_RANGE = 80
	SPECIAL_ATTACK_CD = 10
	SPECIAL_ATTACK_RANGE = 250
	SELF_REGENERATE = 3
	COLLISION_CD = .3
	collision_damage = 10
	timer_attack_normal = NORMAL_ATTACK_CD
	timer_attack_special = SPECIAL_ATTACK_CD
	
	scale = Vector2(.1, .1)
	$HPbar.max_value = HP
	$Sprite.play("appear")
	$NormalAttackArea/AttackSprite.visible = false

func special_attack():
	$SpecialAttackArea/CollisionShape2D.disabled = false
	$Sprite.play("attack_special")
	velocity = Vector2(0, 0)
	#print(enemy)
	
	if timer_regenerate == 0:
		for body in enemy:
			body.HP += Regenerate
		timer_regenerate = REGENERATE_CD
	timer_regenerate = move_toward(timer_regenerate, 0, .06)

func _on_body_died():
	for i in 2:
		var drop = load("res://object/Drops/ElementBall.tscn").instantiate()
		drop.global_position = global_position
		drop.start(4)
		get_tree().root.add_child(drop)
	PlayerStatus.golem_defeat += 1
	queue_free()

func _on_frozen_area_body_entered(body):
	if body is Player:
		PlayerStatus.in_frozenArea += 1

func _on_frozen_area_body_exited(body):
	if body is Player:
		PlayerStatus.in_frozenArea -= 1

func _on_special_attack_area_body_entered(body):
	if body is Enemy:
		enemy.append(body)

func _on_special_attack_area_body_exited(body):
	if enemy.has(body):
		enemy.erase(body)
