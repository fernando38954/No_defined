extends Slime

func _ready():
	HP = 100
	MAX_HP = 100
	WEIGHT = 1
	SPEED = 20 + randi_range(-5, 5)
	NORMAL_ATTACK_CD = 1
	NORMAL_ATTACK_RANGE = 30
	SPECIAL_ATTACK_CD = 5
	SPECIAL_ATTACK_RANGE = 70
	COLLISION_CD = .3
	collision_damage = 5
	timer_attack_normal = NORMAL_ATTACK_CD
	timer_attack_special = SPECIAL_ATTACK_CD
	
	scale = Vector2(1.3, 1.3)
	$Sprite.play("appear")

func _on_burn_area_body_entered(body):
	if body is Player:
		PlayerStatus.in_burnArea += 1

func _on_burn_area_body_exited(body):
	if body is Player:
		PlayerStatus.in_burnArea -= 1

func _on_body_died():
	var drop = load("res://object/Drops/ElementBall.tscn").instantiate()
	drop.global_position = global_position
	drop.start(2)
	get_tree().root.add_child(drop)
	queue_free()
