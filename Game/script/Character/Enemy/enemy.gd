class_name Enemy
extends CharacterBody2D

# Status - Setting on ready
var HP
var WEIGHT
var SPEED
var NORMAL_ATTACK_CD
var NORMAL_ATTACK_RANGE
var SPECIAL_ATTACK_CD
var SPECIAL_ATTACK_RANGE
var COLLISION_CD

# Debuff
var timer_blind = 0
var destination_blind = Vector2(0, 0)
var timer_stun = 0
var timer_slow = 0
var velocity_rate = 1
var timer_poison = 0
var poison_damage = 0
var timer_burn = 0
var burn_damage = 0
var velocity_modifier = Vector2(0, 0)

# Attack Control - Setting on ready
var timer_collision_damage = 0
var collision_damage
var timer_attack_normal
var timer_attack_special

# System Control
const BAR_HIDE_DELAY = 2
var can_move = false
var in_attack = false
var player = []
var timer_bar = 0

func _ready():
	# Override
	HP = 1
	WEIGHT = 1
	SPEED = 1
	NORMAL_ATTACK_CD = 10
	NORMAL_ATTACK_RANGE = 0
	SPECIAL_ATTACK_CD = 10
	SPECIAL_ATTACK_RANGE = 0
	COLLISION_CD = 1
	collision_damage = 1
	timer_attack_normal = NORMAL_ATTACK_CD
	timer_attack_special = SPECIAL_ATTACK_CD
	
	$Sprite.play("appear")

func _physics_process(delta):
	# Debuff
	if timer_blind > 0:
		destination_blind = Vector2(randf_range(-384, 384), randf_range(-384, 384)) if destination_blind == Vector2(0, 0) else destination_blind
		velocity = position.direction_to(destination_blind) * SPEED * velocity_rate
		can_move = false
		timer_blind = move_toward(timer_blind, 0, delta)
		if timer_blind == 0 and HP > 0:
			can_move = true
			destination_blind = Vector2(0, 0)
	if timer_stun > 0:
		can_move = false
		$Sprite.play("stun")
		timer_stun = move_toward(timer_stun, 0, delta)
		if timer_stun == 0 and HP > 0:
			can_move = true
	if timer_slow > 0:
		timer_slow = move_toward(timer_slow, 0, delta)
		if timer_slow == 0:
			velocity_rate = 1
	if timer_poison > 0:
		take_damage(poison_damage)
		timer_poison = move_toward(timer_poison, 0, delta)
	if timer_burn > 0:
		take_damage(burn_damage)
		timer_burn = move_toward(timer_burn, 0, delta)
	
	# Movement
	if not can_move:
		if not timer_blind > 0:
			velocity = Vector2(0, 0)
		in_attack = false
		timer_attack_special = SPECIAL_ATTACK_CD
		timer_attack_normal = NORMAL_ATTACK_CD
	elif not in_attack:
		velocity = position.direction_to(PlayerStatus.global_position) * SPEED * velocity_rate
		$NormalAttackArea/CollisionShape2D.disabled = true
		$SpecialAttackArea/CollisionShape2D.disabled = true
		if velocity.x < 0 and $Sprite.flip_h == false:
			$Sprite.flip_h = true
			$DamageArea/CollisionShape2D.position.x *= -1
			$NormalAttackArea/CollisionShape2D.position.x *= -1
			$SpecialAttackArea/CollisionShape2D.position.x *= -1
		elif velocity.x > 0 and $Sprite.flip_h == true:
			$Sprite.flip_h = false
			$DamageArea/CollisionShape2D.position.x *= -1
			$NormalAttackArea/CollisionShape2D.position.x *= -1
			$SpecialAttackArea/CollisionShape2D.position.x *= -1
		
		if global_position.distance_to(PlayerStatus.global_position) < NORMAL_ATTACK_RANGE and abs(global_position.y - PlayerStatus.global_position.y) < NORMAL_ATTACK_RANGE/2:
			$Sprite.play("idle")
			velocity = Vector2(0, 0)
		else:
			$Sprite.play("walk")
			
		timer_attack_special = move_toward(timer_attack_special, 0, delta) if global_position.distance_to(PlayerStatus.global_position) < SPECIAL_ATTACK_RANGE else SPECIAL_ATTACK_CD
		timer_attack_normal = move_toward(timer_attack_normal, 0, delta) if global_position.distance_to(PlayerStatus.global_position) < NORMAL_ATTACK_RANGE else NORMAL_ATTACK_CD
		
		if timer_attack_special == 0:
			timer_attack_special = SPECIAL_ATTACK_CD
			in_attack = true
			special_attack()
		elif timer_attack_normal == 0:
			timer_attack_normal = NORMAL_ATTACK_CD
			in_attack = true
			normal_attack()
	
	# Velocity Adjust
	velocity += velocity_modifier * velocity_rate
	velocity_modifier = Vector2(0, 0)
	
	# Collision Damage
	if timer_collision_damage == 0 and not in_attack:
		for body in player:
			body.receive_damage(global_position, 3, 5)
			timer_collision_damage = COLLISION_CD
	timer_collision_damage = move_toward(timer_collision_damage, 0, delta)
	
	# HPBar Control
	update_HP()
	timer_bar = move_toward(timer_bar, 0, delta)
	
	# Move
	move_and_slide()

func take_damage(damage):
	HP -= damage
	if HP > 0:
		update_HP()
	if HP <= 0:
		velocity = Vector2(0, 0)
		can_move = false
		$Sprite.play("die")
		$CollisionShape2D.disabled = true
		$DamageArea/CollisionShape2D.disabled = true

func update_HP():
	if HP != $HPbar.value:
		$HPbar.value = HP
		timer_bar = BAR_HIDE_DELAY
		$HPbar.set_modulate(Color(1,1,1,1))
	if timer_bar == 0:
		$HPbar.set_modulate(lerp($HPbar.get_modulate(), Color(1,1,1,0), 0.2))

func normal_attack():
	# Override
	pass

func special_attack():
	# Override
	pass

func _on_damage_area_body_entered(body):
	if body is Player:
		player.append(body)

func _on_damage_area_body_exited(body):
	if player.has(body):
		player.erase(body)

func _on_sprite_animation_finished():
	if $Sprite.animation == "appear":
		can_move = true
	if $Sprite.animation == "attack_normal":
		in_attack = false
	if $Sprite.animation == "attack_special":
		in_attack = false
	if $Sprite.animation == "die":
		queue_free()
