class_name Slime
extends Enemy

var damage_limit = 0
var damage_counter = 0

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
	
	$Sprite.play("appear")
	
func normal_attack():
	damage_limit = 1
	damage_counter = 0
	$Sprite.play("attack_normal")
	if $Sprite.frame > 3:
		$NormalAttackArea/CollisionShape2D.disabled = false
	velocity = Vector2(0, 0)

func special_attack():
	damage_limit = 2
	damage_counter = 0
	$SpecialAttackArea/CollisionShape2D.disabled = false
	$Sprite.play("attack_special")
	velocity = position.direction_to(PlayerStatus.global_position) * SPEED * 3 * velocity_rate

func _on_normal_attack_area_body_entered(body):
	if body is Player and damage_counter < damage_limit:
		damage_counter += 1
		body.receive_damage(global_position, 4, 5)

func _on_special_attack_area_body_entered(body):
	if body is Player and damage_counter < damage_limit:
		damage_counter += 1
		body.receive_damage(global_position, 4, 5)

func _on_body_died():
	queue_free()
