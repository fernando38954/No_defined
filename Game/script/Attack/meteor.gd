extends Area2D

func _ready():
	var rand_vec = Function.rand_Vector2() * 20
	global_position += rand_vec
	$AnimatedSprite2D.play("default")
	PlayerStatus.need_reset = true
	
func start(_position):
	global_position = _position
	
func _process(delta):
	if $AnimatedSprite2D.frame <= 5:
		global_position += Vector2(1.5, 1.5)

func _on_animated_sprite_2d_animation_finished():
	queue_free()
