extends Attack

var destination
var identity

func start(_position, _identity):
	var rand_vec = Function.rand_Vector2() * 20
	destination = _position + rand_vec
	identity = _identity

func _ready():
	extract("Meteor")
	global_position = destination + Vector2(-200, -200)
	$AnimatedSprite2D.play("default")
	$CollisionShape2D.disabled = true
	if identity == 0:
		PlayerStatus.need_reset = true

func _process(delta):
	if $AnimatedSprite2D.frame <= 5:
		global_position.x = move_toward(global_position.x, destination.x, 1.5)
		global_position.y = move_toward(global_position.y, destination.y, 1.5)
	else:
		$CollisionShape2D.disabled = false

func _on_body_entered(body):
	if body is Enemy:
		body.take_damage(attack.Damage)
		body.timer_stun = attack.StunTime
		body.timer_burn = attack.BurnTime
