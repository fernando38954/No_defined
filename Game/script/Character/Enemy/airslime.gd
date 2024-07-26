extends Slime

var burnArea = []

func _ready():
	HP = 100
	MAX_HP = 100
	WEIGHT = .8
	SPEED = 30 + randi_range(-5, 5)
	NORMAL_ATTACK_CD = .5
	NORMAL_ATTACK_RANGE = 30
	SPECIAL_ATTACK_CD = 3
	SPECIAL_ATTACK_RANGE = 70
	COLLISION_CD = .3
	collision_damage = 5
	timer_attack_normal = NORMAL_ATTACK_CD
	timer_attack_special = SPECIAL_ATTACK_CD
	
	scale = Vector2(1.3, 1.3)
	$Sprite.play("appear")

func _on_body_died():
	var drop = load("res://object/Drops/ElementBall.tscn").instantiate()
	drop.global_position = global_position
	drop.start(1)
	get_tree().root.add_child(drop)
	queue_free()
