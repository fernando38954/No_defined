extends CharacterBody2D

const SPEED = 150.0
const DASH_CD = 2
const ATTACK_DELAY = 0.1
var input = Vector2(0, 0)

var timer_dash = 0

var attack = Vector2(0, 0)
var detect_attack_delay = 0
var attack_range
var range_showed = false

enum Element {
	Null, Air, Fire, Earth, Water
}

func dash_event(delta):
	if is_zero_approx(velocity.x) and is_zero_approx(velocity.y):
		PlayerStatus.in_dash = false
	if timer_dash == 0 and not PlayerStatus.can_dash:
		if not PlayerStatus.in_attack:
			$Sprite.play("default")
		PlayerStatus.can_dash = true
		$Sound.stream = load("res://assets/SFX/dash_reload.wav")
		$Sound.play()
		
	if Input.is_action_just_pressed("key_dash") and PlayerStatus.can_dash:
		$Sprite.play("exausted")
		PlayerStatus.can_dash = false
		PlayerStatus.in_dash = true
		timer_dash = DASH_CD
		
		reset_attack()
			
		velocity.x = PlayerStatus.direction.normalized().x * SPEED * 6
		velocity.y = PlayerStatus.direction.normalized().y * SPEED * 6
	
	timer_dash = move_toward(timer_dash, 0, delta)


func attack_event(delta):
	if Input.is_action_just_pressed("key_attack") and PlayerStatus.can_attack:
		$Sprite.play("attacking")
		PlayerStatus.in_attack = true
		PlayerStatus.can_attack = false
		PlayerStatus.can_move = false
		detect_attack_delay = ATTACK_DELAY
	if PlayerStatus.in_attack:
		if Input.is_action_just_pressed("key_attack") and detect_attack_delay == 0:
			$Range.queue_free()
			call_attack()
			PlayerStatus.in_attack = false
			PlayerStatus.can_move = true
		if attack[0] == Element.Null:
			if Input.is_action_just_pressed("key_up"):
				attack[0] = Element.Air
				$MainElement.play("Air")
			if Input.is_action_just_pressed("key_right"):
				attack[0] = Element.Fire
				$MainElement.play("Fire")
			if Input.is_action_just_pressed("key_down"):
				attack[0] = Element.Earth
				$MainElement.play("Earth")
			if Input.is_action_just_pressed("key_left"):
				attack[0] = Element.Water
				$MainElement.play("Water")
		elif attack[1] == Element.Null:
			if Input.is_action_just_pressed("key_up"):
				attack[1] = Element.Air
				$SecondElement.play("Air")
			if Input.is_action_just_pressed("key_right"):
				attack[1] = Element.Fire
				$SecondElement.play("Fire")
			if Input.is_action_just_pressed("key_down"):
				attack[1] = Element.Earth
				$SecondElement.play("Earth")
			if Input.is_action_just_pressed("key_left"):
				attack[1] = Element.Water
				$SecondElement.play("Water")
		if attack[1] != Element.Null and not range_showed:
			show_range()
			range_showed = true

	detect_attack_delay = move_toward(detect_attack_delay, 0, delta)

func reset_attack():
	PlayerStatus.can_attack = true
	PlayerStatus.in_attack = false
	PlayerStatus.can_move = true
	range_showed = false
	if PlayerStatus.can_dash:
		$Sprite.play("default")
	else:
		$Sprite.play("exausted")
	attack = Vector2(Element.Null, Element.Null)
	$MainElement.play("Null")
	$SecondElement.play("Null")

func walk_event():
	if not PlayerStatus.in_dash and PlayerStatus.can_move and input:
		velocity.x = input.x * SPEED
		velocity.y = input.y * SPEED


func move():
	move_and_slide()
			
	velocity.x = move_toward(velocity.x, 0, SPEED)
	velocity.y = move_toward(velocity.y, 0, SPEED)


func _physics_process(delta):
	input = Input.get_vector("key_left", "key_right", "key_up", "key_down")
	PlayerStatus.direction = get_global_mouse_position() - global_position
	PlayerStatus.muzzle_position = $Muzzle.global_position
	rotation = PlayerStatus.direction.angle()
	
	if PlayerStatus.can_attack == true:
		reset_attack()
	
	dash_event(delta)
	attack_event(delta)
	walk_event()
	move()

#==================================== Attack Type =================================
func call_attack():
	var attack_type
	
	if attack == Vector2(Element.Air, Element.Air):
		attack_type = load("res://object/Attack/tornado.tscn").instantiate()
	elif attack == Vector2(Element.Air, Element.Fire):
		attack_type = load("res://object/Attack/fireblade.tscn").instantiate()
	elif attack == Vector2(Element.Earth, Element.Earth):
		attack_type = load("res://object/Attack/spike.tscn").instantiate()
	elif attack == Vector2(Element.Earth, Element.Fire):
		var mouse_position = get_global_mouse_position()
		for i in 4:
			attack_type = load("res://object/Attack/meteor.tscn").instantiate()
			attack_type.start(mouse_position)
			get_tree().root.add_child(attack_type)
			await get_tree().create_timer(0.3).timeout
	else:
		reset_attack()
		
	if attack_type != null:
		get_tree().root.add_child(attack_type)
	
func show_range():
	attack_range = load("res://object/rangeCircle.tscn").instantiate()
	attack_range.start(100)
	add_child(attack_range)
	attack_range.name = "Range"
