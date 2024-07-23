class_name Enemy
extends CharacterBody2D

const BAR_HIDE_DELAY = 2

var HP = 100
var timer_bar = 0
var velocity_modifier = Vector2(0, 0)
var timer_stun = 0
var timer_burn = 0

func _physics_process(delta):
	velocity = position.direction_to(PlayerStatus.global_position) * 20
	if timer_stun > 0:
		velocity = Vector2(0, 0)
		timer_stun = move_toward(timer_stun, 0, delta)
	if timer_burn > 0:
		take_damage(.1)
		timer_burn = move_toward(timer_burn, 0, delta)
	
	velocity += velocity_modifier
	
	update_HP()
	move_and_slide()
	
	velocity_modifier = Vector2(0, 0)
	timer_bar = move_toward(timer_bar, 0, delta)

func take_damage(damage):
	HP -= damage
	update_HP()
	if HP <= 0:
		queue_free()

func update_HP():
	if HP != $HPbar.value:
		$HPbar.value = HP
		timer_bar = BAR_HIDE_DELAY
		$HPbar.set_modulate(Color(1,1,1,1))
	if timer_bar == 0:
		$HPbar.set_modulate(lerp($HPbar.get_modulate(), Color(1,1,1,0), 0.2))
