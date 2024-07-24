extends Enemy

var damage_limit = 0
var damage_counter = 0

func _ready():
	NORMAL_ATTACK_CD = 1
	NORMAL_ATTACK_RANGE = 30
	SPECIAL_ATTACK_CD = 5
	SPECIAL_ATTACK_RANGE = 70
	timer_attack_normal = NORMAL_ATTACK_CD
	timer_attack_special = SPECIAL_ATTACK_CD
	
	HP = 100
	$Sprite.play("appear")
	
func normal_attack():
	in_attack = true
	damage_limit = 1
	damage_counter = 0
	$Sprite.play("attack_normal")
	velocity = position.direction_to(PlayerStatus.global_position) * 100

func special_attack():
	in_attack = true
	damage_limit = 2
	damage_counter = 0
	$Sprite.play("attack_normal")
	velocity = position.direction_to(PlayerStatus.global_position) * 100

func _on_normal_attack_area_body_entered(body):
	if body is Player and damage_counter < damage_limit:
		damage_counter += 1
		body.receive_damage(global_position, 4, 5)
