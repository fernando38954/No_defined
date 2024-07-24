extends CharacterBody2D

enum Element {
	Null, Air, Fire, Earth, Water
}

var timer_disappear = 5
var type = Element.Null

func start(_type):
	timer_disappear = 5
	type = _type
	if type == Element.Air:
		$Sprite.play("Air")
	elif type == Element.Fire:
		$Sprite.play("Fire")
	elif type == Element.Earth:
		$Sprite.play("Earth")
	elif type == Element.Water:
		$Sprite.play("Water")

func _physics_process(delta):
	if timer_disappear == 0:
		$Sprite.set_modulate(lerp($Sprite.get_modulate(), Color(1,1,1,0), 0.2))
	if $Sprite.get_modulate() == Color(1,1,1,0):
		queue_free()
	if global_position.distance_to(PlayerStatus.global_position) < 100:
		velocity = position.direction_to(PlayerStatus.global_position) * 150
	else:
		velocity = Vector2(0, 0)

	move_and_slide()

func _on_area_2d_body_entered(body):
	if body is Player:
		PlayerStatus.getElement(type)
		queue_free()
