extends Attack

func _ready():
	extract("Tornado")
	
	position = get_global_mouse_position() if PlayerStatus.attack_position == null else PlayerStatus.attack_position
	$AnimatedSprite2D.play("default")
	$AnimatedSprite2D.scale = attack.SpriteScale
	$CollisionShape2D.shape.radius = attack.AttackRange
	
	PlayerStatus.need_reset = true

func additional_process(delta):
	for enemy in enemy_inside:
			enemy.velocity_modifier += enemy.position.direction_to(global_position) * attack.PullForce / enemy.WEIGHT
