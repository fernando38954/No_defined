extends Area2D

var AttackRange = 0
var Damage = 0

var position_marker = Vector2(0, 0)
var dist_diff = 0

var timer_start_attack = 2
var attack_started = false
var setup = false

func start(_AttackRange, _Damage):
	AttackRange = _AttackRange
	Damage = _Damage
	
func _ready():	
	global_position = PlayerStatus.global_position
	scale = Vector2(AttackRange/10, AttackRange/10)
	position_marker = $AttackSprite.global_position
	$AttackSprite.global_position = $AttackMarker.global_position
	dist_diff = $AttackMarker.global_position.distance_to(position_marker)
	$AttackSprite.visible = false
	$CollisionShape2D.disabled = true

func _process(delta):
	if setup:
		$AttackSprite.visible = true
		$AttackSprite.play("default")
		setup = false
	if not attack_started:
		if timer_start_attack == 0:
			attack_started = true
			setup = true
		timer_start_attack = move_toward(timer_start_attack, 0, delta)
	if attack_started and not setup:
		if $AttackSprite.frame <= 5:
			$AttackSprite.global_position.x = move_toward($AttackSprite.global_position.x, position_marker.x, dist_diff/120)
			$AttackSprite.global_position.y = move_toward($AttackSprite.global_position.y, position_marker.y, dist_diff/120)
		else:
			$CollisionShape2D.disabled = false

func _on_body_entered(body):
	if body is Player:
		body.receive_damage(global_position, 10, Damage)

func _on_attack_sprite_animation_finished():
	queue_free()
