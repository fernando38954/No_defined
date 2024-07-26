extends Golem

func _ready():
	HP = 300
	MAX_HP = 300
	WEIGHT = 3
	SPEED = 10 + randi_range(-2, 2)
	NORMAL_ATTACK_CD = 2
	NORMAL_ATTACK_RANGE = 80
	SPECIAL_ATTACK_CD = 10
	SPECIAL_ATTACK_RANGE = 250
	COLLISION_CD = .3
	collision_damage = 10
	timer_attack_normal = NORMAL_ATTACK_CD
	timer_attack_special = SPECIAL_ATTACK_CD
	
	scale = Vector2(.1, .1)
	$Sprite.play("appear")
	$NormalAttackArea/AttackSprite.visible = false

func special_attack():
	$Sprite.play("attack_special")
	velocity = Vector2(0, 0)
	
	if not special_attack_summoned:
		var attack_type = load("res://object/EnemyAttack/meteor.tscn").instantiate()
		attack_type.start(40, 30)
		get_tree().root.add_child(attack_type)
		special_attack_summoned = true
		
func _on_burn_area_body_entered(body):
	if body is Player:
		PlayerStatus.in_burnArea += 1

func _on_burn_area_body_exited(body):
	if body is Player:
		PlayerStatus.in_burnArea -= 1

func _on_body_died():
	for i in 2:
		var drop = load("res://object/Drops/ElementBall.tscn").instantiate()
		drop.global_position = global_position
		drop.start(2)
		get_tree().root.add_child(drop)
	PlayerStatus.golem_defeat += 1
	queue_free()
