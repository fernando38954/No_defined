extends Slime

var burnArea = []

func _ready():
	HP = 100
	WEIGHT = 2
	SPEED = 20 + randi_range(-5, 5)
	NORMAL_ATTACK_CD = 1
	NORMAL_ATTACK_RANGE = 30
	SPECIAL_ATTACK_CD = 5
	SPECIAL_ATTACK_RANGE = 70
	COLLISION_CD = .3
	collision_damage = 5
	timer_attack_normal = NORMAL_ATTACK_CD
	timer_attack_special = SPECIAL_ATTACK_CD
	
	$Sprite.play("appear")

func additional_process(delta):
	timer_stun = 0
	timer_slow = 0
	velocity_rate = 1
	timer_poison = 0
	poison_damage = 0
	timer_burn = 0
	burn_damage = 0

func _on_body_died():
	var drop = load("res://object/Drops/ElementBall.tscn").instantiate()
	drop.global_position = global_position
	drop.start(3)
	get_tree().root.add_child(drop)
	queue_free()
