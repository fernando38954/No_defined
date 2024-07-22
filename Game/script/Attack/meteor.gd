extends Area2D

func _ready():
	var rand_vec = Function.rand_Vector2() * 20
	global_position += rand_vec
	$AnimatedSprite2D.play("default")
	PlayerStatus.can_attack = true
	
func start(_position):
	global_position = _position
	
func _process(delta):
	if $AnimatedSprite2D.frame <= 5:
		global_position += Vector2(.3, .3)

func _on_animated_sprite_2d_animation_finished():
	queue_free()
