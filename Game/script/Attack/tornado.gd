extends Area2D

var enemy_inside = []
var timer_damage

func _ready():
	position = get_global_mouse_position()
	$AnimatedSprite2D.play("default")
	$CollisionShape2D.shape.radius = AttackAttribute.Tornado.AttackRange
	timer_damage = AttackAttribute.Tornado.DamageCD
	PlayerStatus.need_reset = true

func _process(delta):
	if timer_damage == 0:
		for enemy in enemy_inside:
			enemy.take_damage(AttackAttribute.Tornado.Damage)
		timer_damage = AttackAttribute.Tornado.DamageCD
	for enemy in enemy_inside:
			enemy.velocity_modifier += enemy.position.direction_to(global_position) * 5
	timer_damage = move_toward(timer_damage, 0, delta)

func _on_animated_sprite_2d_animation_finished():
	queue_free()

func _on_body_entered(body):
	if body is Enemy:
		enemy_inside.append(body)

func _on_body_exited(body):
	if enemy_inside.has(body):
		enemy_inside.erase(body)
