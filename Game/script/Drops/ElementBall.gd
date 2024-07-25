extends CharacterBody2D

enum Element {
	Null, Air, Fire, Earth, Water
}

var gravity = 10

var type = Element.Null
var initial_position = Vector2(0, 0)
var initial_velocity_y = -300.0
var bounce_time = 0
var timer_disappear = 10
var timer_ondulate = 1
var mode_ondulate = 1
var collectable = false

func start(_type):
	type = _type
	if type == Element.Air:
		$Sprite.play("Air")
	elif type == Element.Fire:
		$Sprite.play("Fire")
	elif type == Element.Earth:
		$Sprite.play("Earth")
	elif type == Element.Water:
		$Sprite.play("Water")

func _ready():
	initial_position = global_position
	velocity.x = randi_range(-30, 30)
	velocity.y = initial_velocity_y

func _physics_process(delta):
	if not collectable:
		if bounce_time <= 3:
			velocity.y += gravity
		else:
			collectable = true
		if global_position.y >= initial_position.y:
			bounce_time += 1
			velocity.y = initial_velocity_y / 2 ** bounce_time
	
	if collectable:
		if timer_disappear <= 3:
			$Sprite.set_modulate(lerp($Sprite.get_modulate(), Color(1,1,1,0), 0.01))
		if timer_disappear == 0:
			queue_free()
		if global_position.distance_to(PlayerStatus.global_position) < 100 and collectable:
			velocity = position.direction_to(PlayerStatus.global_position) * 150
		else:
			if timer_ondulate == 0:
				mode_ondulate *= -1
				timer_ondulate = 1
			velocity = Vector2(0, mode_ondulate * 3)
			timer_ondulate = move_toward(timer_ondulate, 0, delta)

		timer_disappear = move_toward(timer_disappear, 0, delta)
		
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body is Player:
		PlayerStatus.getElement(type)
		queue_free()
