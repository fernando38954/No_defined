extends Area2D

func _ready():
	position = get_global_mouse_position()
	$AnimatedSprite2D.play("default")
	PlayerStatus.need_reset = true

func _on_animated_sprite_2d_animation_finished():
	queue_free()
