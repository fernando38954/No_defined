extends Attack

func _ready():
	extract("FireBlade")
	
	rotation = PlayerStatus.direction.angle()
	$AnimatedSprite2D.play("default")
	$AnimatedSprite2D.scale = attack.SpriteScale
	$AnimatedSprite2D.position.x = ($AnimatedSprite2D.sprite_frames.get_frame_texture("default", $AnimatedSprite2D.frame).get_width()/2 - 3) * $AnimatedSprite2D.scale.x
	$AnimatedSprite2D.position.y = -1
	print($AnimatedSprite2D.scale)
	print($AnimatedSprite2D.position)
	$CollisionShape2D.position = Vector2(attack.SpellRange/2, 0)
	$CollisionShape2D.shape.size.x = attack.SpellRange

func _on_animated_sprite_2d_animation_finished():
	PlayerStatus.need_reset = true
	queue_free()

func additional_process(delta):
	position = PlayerStatus.muzzle_position
	rotation = PlayerStatus.direction.angle()
	if timer_damage == 0:
		for enemy in enemy_inside:
				enemy.timer_burn = attack.BurnTime
				enemy.burn_damage = attack.BurnDamage
