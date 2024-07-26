class_name Golem
extends Enemy

var SELF_REGENERATE = 0

var appear = true
var special_attack_summoned = false
var damage_limit = 0
var damage_counter = 0

func _ready():
	HP = 200
	MAX_HP = 200
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

func additional_process(delta):
	HP += SELF_REGENERATE*delta
	if appear == true:
		if $Sprite.frame <= 9:
			global_position.y -= 1
		elif $Sprite.frame <= 18:
			global_position.y += 1
		scale = lerp(scale, Vector2(2.5, 2.5), 0.05)
	if $Sprite.animation != "appear":
		appear = false
		
	if not in_special_attack and special_attack_summoned:
		special_attack_summoned = false

func normal_attack():
	damage_limit = 1
	damage_counter = 0
	$Sprite.play("attack_normal")
	if $Sprite.frame > 7:
		$NormalAttackArea/AttackSprite.visible = true
		$NormalAttackArea/AttackSprite.play("default")
		$NormalAttackArea/CollisionShape2D.disabled = false
	velocity = Vector2(0, 0)

func special_attack():
	pass

func _on_normal_attack_area_body_entered(body):
	if body is Player and damage_counter < damage_limit:
		damage_counter += 1
		body.receive_damage(global_position, 4, 10)

func _on_body_died():
	queue_free()

func _on_attack_sprite_animation_finished():
	if $NormalAttackArea/AttackSprite.animation == "default":
		$NormalAttackArea/AttackSprite.visible = false
