extends Attack

func _ready():
	extract("FireBlade")
	position = PlayerStatus.muzzle_position
	rotation = PlayerStatus.direction.angle()
	$AnimatedSprite2D.play("default")

func _on_animated_sprite_2d_animation_finished():
	PlayerStatus.need_reset = true
	queue_free()

func additional_process(delta):
	position = PlayerStatus.muzzle_position
	rotation = PlayerStatus.direction.angle()
	if timer_damage == 0:
		for enemy in enemy_inside:
				enemy.timer_burn = attack.BurnTime
