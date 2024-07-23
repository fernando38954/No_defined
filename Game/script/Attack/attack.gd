class_name Attack
extends Area2D

var attack
var enemy_inside = []
var timer_damage = 0

func extract(name):
	attack = AttackAttribute.get(name)
	timer_damage = attack.DamageCD

func _process(delta):
	additional_process(delta)
	
	if timer_damage == 0:
		for enemy in enemy_inside:
			enemy.take_damage(attack.Damage)
		timer_damage = attack.DamageCD
	timer_damage = move_toward(timer_damage, 0, delta)

func _on_animated_sprite_2d_animation_finished():
	queue_free()

func _on_body_entered(body):
	if body is Enemy:
		enemy_inside.append(body)

func _on_body_exited(body):
	if enemy_inside.has(body):
		enemy_inside.erase(body)

func additional_process(delta):
	pass
