class_name Player
extends CharacterBody2D

const SPEED = 150.0
const DASH_CD = 2
const ATTACK_DELAY = 0.1
const DASH_TIME = .2
var input = Vector2(0, 0)

var timer_dash = 0
var timer_immune = 0
var timer_chant = 0
var chant_time = -1

var attack = Vector2(0, 0)
var detect_attack_delay = 0
var attack_range
var range_showed = false

enum Element {
	Null, Air, Fire, Earth, Water
}

enum Type {
	Area, Line
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
		timer_immune = DASH_TIME
		
		if (not PlayerStatus.in_attack and input) or (chant_time > 0 and input):
			velocity = input.normalized() * SPEED * 8
		else:
			velocity = PlayerStatus.direction.normalized() * SPEED * 8
		
		reset_attack()
	
	timer_dash = move_toward(timer_dash, 0, delta)
	timer_immune = move_toward(timer_immune, 0, delta)


func attack_event(delta):
	if Input.is_action_just_pressed("key_attack") and PlayerStatus.can_attack:
		$Sprite.play("attacking")
		PlayerStatus.in_attack = true
		PlayerStatus.can_attack = false
		PlayerStatus.can_move = false
		detect_attack_delay = ATTACK_DELAY
	if PlayerStatus.in_attack:
		if Input.is_action_just_pressed("key_attack") and detect_attack_delay == 0 and PlayerStatus.in_attack_range and not chant_time > 0:
			chant()
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
	if chant_time > 0:
		timer_chant = move_toward(timer_chant, 0, delta)
		$ChantBar.value = chant_time - timer_chant
		if timer_chant == 0:
			$ChantBar.set_modulate(Color(1,1,1,0))
			$Range.queue_free()
			call_attack()
			chant_time = -1

	detect_attack_delay = move_toward(detect_attack_delay, 0, delta)

func reset_attack():
	PlayerStatus.can_attack = true
	PlayerStatus.in_attack = false
	PlayerStatus.can_move = true
	PlayerStatus.need_reset = false
	PlayerStatus.in_attack_range = false
	PlayerStatus.attack_position = null
	range_showed = false
	chant_time = -1
	if get_node_or_null("Range"):
		$Range.queue_free()
	if PlayerStatus.can_dash:
		$Sprite.play("default")
	else:
		$Sprite.play("exausted")
	attack = Vector2(Element.Null, Element.Null)
	$MainElement.play("Null")
	$SecondElement.play("Null")
	$ChantBar.set_modulate(Color(1,1,1,0))

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
	PlayerStatus.global_position = global_position
	rotation = PlayerStatus.direction.angle()
	
	if PlayerStatus.need_reset == true:
		reset_attack()
	
	dash_event(delta)
	attack_event(delta)
	statusBar_smoothing()
	walk_event()
	move()

#==================================== Attack =================================
func show_range():
	attack_range = load("res://object/AttackIndicator/circleRange.tscn").instantiate()
	
	if attack == Vector2(Element.Air, Element.Air):
		attack_range.start("Tornado")
	elif attack == Vector2(Element.Fire, Element.Fire):
		attack_range.start("FireBlade")
	elif attack == Vector2(Element.Earth, Element.Earth):
		attack_range.start("Spike")
	elif attack == Vector2(Element.Earth, Element.Fire):
		attack_range.start("Meteor")
	else:
		attack_range.start("NULL")
		
	add_child(attack_range)
	attack_range.name = "Range"

func chant():
	if attack == Vector2(Element.Air, Element.Air):
		chant_time = AttackAttribute.Tornado.ChantTime
	elif attack == Vector2(Element.Fire, Element.Fire):
		chant_time = AttackAttribute.FireBlade.ChantTime
	elif attack == Vector2(Element.Earth, Element.Earth):
		chant_time = AttackAttribute.Spike.ChantTime
	elif attack == Vector2(Element.Earth, Element.Fire):
		chant_time = AttackAttribute.Meteor.ChantTime
	else:
		chant_time = AttackAttribute.NULL.ChantTime
	
	PlayerStatus.attack_position = get_global_mouse_position()
	$ChantBar.max_value = chant_time
	$ChantBar.value = 0
	$ChantBar.set_modulate(Color(1,1,1,1))
	timer_chant = chant_time

func call_attack():
	var attack_type
	
	PlayerStatus.in_attack = false
	PlayerStatus.can_move = true
	
	if attack == Vector2(Element.Air, Element.Air):
		attack_type = load("res://object/Attack/tornado.tscn").instantiate()
		get_tree().root.add_child(attack_type)
	elif attack == Vector2(Element.Fire, Element.Fire):
		attack_type = load("res://object/Attack/fireblade.tscn").instantiate()
		get_tree().root.add_child(attack_type)
	elif attack == Vector2(Element.Earth, Element.Earth):
		attack_type = load("res://object/Attack/spike.tscn").instantiate()
		get_tree().root.add_child(attack_type)
	elif attack == Vector2(Element.Earth, Element.Fire):
		var attack_position = PlayerStatus.attack_position
		for i in 4:
			attack_type = load("res://object/Attack/meteor.tscn").instantiate()
			attack_type.start(attack_position, i)
			get_tree().root.add_child(attack_type)
			await get_tree().create_timer(0.3).timeout
	else:
		reset_attack()

#==================================== Attack =================================
func receive_damage(damage_position, knockback, value):
	if timer_immune > 0:
		return
		
	var direction = global_position - damage_position
	velocity += direction.normalized() * SPEED * knockback
	if velocity.distance_to(Vector2(0, 0)) > SPEED * 5:
		velocity = velocity.normalized() * SPEED * 5
	move()
	
	PlayerStatus.Shield -= value
	if PlayerStatus.Shield < 0:
		PlayerStatus.HP -= abs(PlayerStatus.Shield)
		PlayerStatus.Shield = 0

func statusBar_smoothing():
	if PlayerStatus.HP > PlayerStatus.backHP:
		PlayerStatus.backHP = PlayerStatus.HP
	if PlayerStatus.Shield > PlayerStatus.backShield:
		PlayerStatus.backShield = PlayerStatus.Shield
	PlayerStatus.backHP = move_toward(PlayerStatus.backHP, PlayerStatus.HP, .5)
	PlayerStatus.backShield = move_toward(PlayerStatus.backShield, PlayerStatus.Shield, .5)
