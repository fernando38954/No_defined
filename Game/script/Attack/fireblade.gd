extends Area2D

func _ready():
	position = PlayerStatus.muzzle_position
	rotation = PlayerStatus.direction.angle()
	$AnimatedSprite2D.play("default")

func _process(delta):
	position = PlayerStatus.muzzle_position
	rotation = PlayerStatus.direction.angle()

func _on_animated_sprite_2d_animation_finished():
	PlayerStatus.need_reset = true
	queue_free()
