class_name Enemy
extends CharacterBody2D

const BAR_HIDE_DELAY = 2
var NORMAL_ATTACK_CD = 1
var NORMAL_ATTACK_RANGE = 30
var SPECIAL_ATTACK_CD = 5
var SPECIAL_ATTACK_RANGE = 70

var can_move = false

var timer_bar = 0
var timer_stun = 0
var timer_burn = 0
var timer_damage = 0

var timer_attack_normal = NORMAL_ATTACK_CD
var timer_attack_special = SPECIAL_ATTACK_CD
var in_attack = false

var velocity_modifier = Vector2(0, 0)

var HP = 100

var player = []

func _ready():
	HP = 100
	NORMAL_ATTACK_CD = 1
	NORMAL_ATTACK_RANGE = 30
	SPECIAL_ATTACK_CD = 5
	SPECIAL_ATTACK_RANGE = 70
	timer_attack_normal = NORMAL_ATTACK_CD
	timer_attack_special = SPECIAL_ATTACK_CD
	$Sprite.play("appear")

func _physics_process(delta):
	if can_move and not in_attack:
		velocity = position.direction_to(PlayerStatus.global_position) * 20
		if velocity.x < 0:
			$Sprite.flip_h = true
		else:
			$Sprite.flip_h = false
		
		if global_position.distance_to(PlayerStatus.global_position) < NORMAL_ATTACK_RANGE:
			$Sprite.play("idle")
			velocity = Vector2(0, 0)
		else:
			$Sprite.play("walk")
			
		timer_attack_special = move_toward(timer_attack_special, 0, delta) if global_position.distance_to(PlayerStatus.global_position) < SPECIAL_ATTACK_RANGE else SPECIAL_ATTACK_CD
		timer_attack_normal = move_toward(timer_attack_normal, 0, delta) if global_position.distance_to(PlayerStatus.global_position) < NORMAL_ATTACK_RANGE else NORMAL_ATTACK_CD
		
		if timer_attack_special == 0 and not in_attack:
			timer_attack_special = SPECIAL_ATTACK_CD
			in_attack = true
			special_attack()
		elif timer_attack_normal == 0 and not in_attack:
			timer_attack_normal = NORMAL_ATTACK_CD
			in_attack = true
			normal_attack()
	if not can_move and not in_attack:
		velocity = Vector2(0, 0)
	if can_move and timer_stun > 0:
		velocity = Vector2(0, 0)
		in_attack = false
		timer_attack_special = SPECIAL_ATTACK_CD
		timer_attack_normal = NORMAL_ATTACK_CD
		$Sprite.play("stun")
		timer_stun = move_toward(timer_stun, 0, delta)
	if timer_burn > 0:
		take_damage(.1)
		timer_burn = move_toward(timer_burn, 0, delta)
	
	velocity += velocity_modifier
	
	if timer_damage == 0 and not in_attack:
		for body in player:
			body.receive_damage(global_position, 3, 5)
			timer_damage = .5
	
	update_HP()
	move_and_slide()
	
	velocity_modifier = Vector2(0, 0)
	timer_bar = move_toward(timer_bar, 0, delta)
	timer_damage = move_toward(timer_damage, 0, delta)

func take_damage(damage):
	HP -= damage
	if HP > 0:
		update_HP()
	if HP <= 0:
		can_move = false
		$Sprite.play("die")

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
