extends Area2D

var player = []

var AttackRange = 0
var DamageCD = 0
var Damage = 0

var timer_damage = 0

var timer_start_attack = 1
var attack_started = false
var setup = false

func start(_AttackRange, _DamageCD, _Damage):
	AttackRange = _AttackRange
	DamageCD = _DamageCD
	Damage = _Damage
	
	timer_damage = DamageCD
	
func _ready():	
	global_position = PlayerStatus.global_position
	scale = Vector2(AttackRange/10, AttackRange/10)
	$AttackSprite.visible = false
	$CollisionShape2D.disabled = true

func _process(delta):
	if setup:
		$AttackSprite.visible = true
		$CollisionShape2D.disabled = false
		$AttackSprite.play("default")
		setup = false
	if not attack_started:
		if timer_start_attack == 0:
			attack_started = true
			setup = true
		timer_start_attack = move_toward(timer_start_attack, 0, delta)
	if attack_started and not setup:
		if timer_damage == 0:
			for body in player:
				body.receive_damage(global_position, 1, Damage)
			timer_damage = DamageCD
		timer_damage = move_toward(timer_damage, 0, delta)

func _on_body_entered(body):
	if body is Player:
		player.append(body)

func _on_body_exited(body):
	if player.has(body):
		player.erase(body)

func _on_attack_sprite_animation_finished():
	queue_free()
