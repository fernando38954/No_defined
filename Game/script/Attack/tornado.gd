extends Attack

func _ready():
	position = get_global_mouse_position()
	$AnimatedSprite2D.play("default")
	
	extract("Tornado")
	$CollisionShape2D.shape.radius = attack.AttackRange
	
	PlayerStatus.need_reset = true

func additional_process(delta):
	for enemy in enemy_inside:
			enemy.velocity_modifier += enemy.position.direction_to(global_position) * 5
