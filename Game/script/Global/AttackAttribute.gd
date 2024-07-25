extends Node

enum Type {
	Area, Line, Self
}

enum Element {
	Null, Air, Fire, Earth, Water
}

var NULL = {
	ElementType = [Element.Null, Element.Null],
	SpriteScale = Vector2(1, 1),
	SpellRange = 0,
	AttackType = Type.Area,
	AttackRange = 0,
	DamageCD = 0,
	Damage = 0,
	ChantTime = 0,
	PullForce = 0,
	PushForce = 0,
	Regenerate = 0,
	Shield = 0,
	BlindTime = 0,
	StunTime = 0,
	SlowTime = 0,
	SlowRate = 0,
	PoisonTime = 0,
	PoisonDamage = 0,
	BurnTime = 0,
	BurnDamage = 0,
}

# ============================= Air =============================
var Tornado = {
	ElementType = [Element.Air, Element.Air],
	SpriteScale = Vector2(.5, .5),
	SpellRange = 100,
	AttackType = Type.Area,
	AttackRange = 25,
	DamageCD = .2,
	Damage = 3,
	ChantTime = 1,
	PullForce = 3,
}

var Lightning = {
	ElementType = [Element.Air, Element.Fire],
	SpriteScale = Vector2(1, 1),
	SpellRange = 0,
	AttackType = Type.Area,
	AttackRange = 0,
	DamageCD = 0,
	Damage = 0,
	ChantTime = 0,
	StunTime = 0,
	SlowTime = 0,
	SlowRate = 0,
	BurnTime = 0,
	BurnDamage = 0
}

var Typhoon = {
	ElementType = [Element.Air, Element.Earth],
	SpriteScale = Vector2(1, 1),
	SpellRange = 0,
	AttackType = Type.Line,
	AttackRange = 0,
	DamageCD = 0,
	Damage = 0,
	ChantTime = 0,
	PushForce = 0,
}

var AcidRain = {
	ElementType = [Element.Air, Element.Water],
	SpriteScale = Vector2(1, 1),
	SpellRange = 0,
	AttackType = Type.Area,
	AttackRange = 0,
	DamageCD = 0,
	Damage = 0,
	ChantTime = 0,
	PoisonTime = 0,
	PoisonDamage = 0
}

# ============================= Fire =============================
var FireWall = {
	ElementType = [Element.Fire, Element.Air],
	SpriteScale = Vector2(1, 1),
	SpellRange = 0,
	AttackType = Type.Self,
	AttackRange = 0,
	DamageCD = 0,
	Damage = 0,
	ChantTime = 0,
	PushForce = 0,
	BurnTime = 0,
	BurnDamage = 0,
}

var FireBlade = {
	ElementType = [Element.Fire, Element.Fire],
	SpriteScale = Vector2(.85, .85),
	SpellRange = 60,
	AttackType = Type.Line,
	AttackRange = null,
	DamageCD = .1,
	Damage = 3,
	ChantTime = 1,
	BurnTime = 4,
	BurnDamage = .1
}

var LavaBall = {
	ElementType = [Element.Fire, Element.Earth],
	SpriteScale = Vector2(1, 1),
	SpellRange = 0,
	AttackType = Type.Line,
	AttackRange = 0,
	DamageCD = 0,
	Damage = 0,
	ChantTime = 0,
	PushForce = 0,
	BurnTime = 0,
	BurnDamage = 0,
}

var OilZone = {
	ElementType = [Element.Fire, Element.Water],
	SpriteScale = Vector2(1, 1),
	SpellRange = 0,
	AttackType = Type.Area,
	AttackRange = 0,
	DamageCD = 0,
	Damage = 0,
	ChantTime = 0
}

# ============================= Earth =============================
var SandStorm  = {
	ElementType = [Element.Earth, Element.Air],
	SpriteScale = Vector2(1, 1),
	SpellRange = 0,
	AttackType = Type.Area,
	AttackRange = 0,
	DamageCD = 0,
	Damage = 0,
	ChantTime = 0,
	SlowTime = 0,
	SlowRate = 0,
	BlindTime = 0
}

var Meteor = {
	ElementType = [Element.Earth, Element.Fire],
	SpriteScale = Vector2(.85, .85),
	SpellRange = 100,
	AttackType = Type.Area,
	AttackRange = 30,
	DamageCD = null,
	Damage = 20,
	ChantTime = 1,
	StunTime = .4,
	BurnTime = 2,
	BurnDamage = .5
}

var Spike = {
	ElementType = [Element.Earth, Element.Earth],
	SpriteScale = Vector2(.5, .5),
	SpellRange = 70,
	AttackType = Type.Area,
	AttackRange = 15,
	DamageCD = .3,
	Damage = 25,
	ChantTime = 1,
	StunTime = .2
}

var TurtleShield = {
	ElementType = [Element.Earth, Element.Water],
	SpriteScale = Vector2(1, 1),
	SpellRange = 20,
	AttackType = Type.Self,
	AttackRange = 0,
	DamageCD = 0.01,
	Damage = 0,
	ChantTime = 2,
	Shield = 15
}

# ============================= Water =============================
var Poison = {
	ElementType = [Element.Water, Element.Air],
	SpriteScale = Vector2(1, 1),
	SpellRange = 0,
	AttackType = Type.Area,
	AttackRange = 0,
	DamageCD = 0,
	Damage = 0,
	ChantTime = 0,
	PoisonTime = 0,
	PoisonDamage = 0
}

var Fog = {
	ElementType = [Element.Water, Element.Fire],
	SpriteScale = Vector2(1, 1),
	SpellRange = 0,
	AttackType = Type.Self,
	AttackRange = 0,
	DamageCD = 0,
	Damage = 0,
	ChantTime = 0,
	BlindTime = 0
}

var Mud = {
	ElementType = [Element.Water, Element.Earth],
	SpriteScale = Vector2(1, 1),
	SpellRange = 0,
	AttackType = Type.Area,
	AttackRange = 0,
	DamageCD = 0,
	Damage = 0,
	ChantTime = 0,
	SlowTime = 0,
	SlowRate = 0
}

var Cure = {
	ElementType = [Element.Water, Element.Water],
	SpriteScale = Vector2(1, 1),
	SpellRange = 20,
	AttackType = Type.Self,
	AttackRange = 0,
	DamageCD = .01,
	Damage = 0,
	ChantTime = 1,
	Regenerate = 10
}

# ============================= Function =============================
func export(name):
	var attack = get(name).duplicate()
	update(attack)
	return attack

func update(attack):
	if attack.ElementType == [Element.Air, Element.Air]:
		# Tornado
		attack.SpriteScale *= (1 + PlayerStatus.ElementQty[Element.Air] * .15)
		attack.SpellRange += PlayerStatus.ElementQty[Element.Air] * 5
		attack.AttackRange += PlayerStatus.ElementQty[Element.Air] * 5
		attack.Damage += PlayerStatus.ElementQty[Element.Air] * 3
		attack.ChantTime -= PlayerStatus.ElementQty[Element.Air] * .1
		attack.PullForce += PlayerStatus.ElementQty[Element.Air]
	if attack.ElementType == [Element.Air, Element.Fire]:
		# Lightning
		pass
	elif attack.ElementType == [Element.Air, Element.Earth]:
		# Typhoon
		pass
	elif attack.ElementType == [Element.Air, Element.Water]:
		# Acid Rain
		pass
	elif attack.ElementType == [Element.Fire, Element.Air]:
		# Fire Wall
		pass
	elif attack.ElementType == [Element.Fire, Element.Fire]:
		# Fire Blade
		attack.SpriteScale *= (1 + PlayerStatus.ElementQty[Element.Fire] * .1)
		attack.SpellRange += PlayerStatus.ElementQty[Element.Fire] * 5
		attack.Damage += PlayerStatus.ElementQty[Element.Fire] * 5
		attack.ChantTime -= PlayerStatus.ElementQty[Element.Fire] * .1
		attack.BurnTime += PlayerStatus.ElementQty[Element.Fire] * .5
		attack.BurnDamage += PlayerStatus.ElementQty[Element.Fire]
	elif attack.ElementType == [Element.Fire, Element.Earth]:
		# Lava Ball
		pass
	elif attack.ElementType == [Element.Fire, Element.Water]:
		# Oil Ball
		pass
	elif attack.ElementType == [Element.Earth, Element.Air]:
		# Sand Storm
		pass
	elif attack.ElementType == [Element.Earth, Element.Fire]:
		# Meteor
		attack.SpriteScale *= (1 + PlayerStatus.ElementQty[Element.Earth] * .15)
		attack.SpellRange += PlayerStatus.ElementQty[Element.Earth] * 5
		attack.AttackRange += PlayerStatus.ElementQty[Element.Earth] * 5
		attack.Damage += PlayerStatus.ElementQty[Element.Earth] * 5 + PlayerStatus.ElementQty[Element.Fire] * 5
		attack.ChantTime -= PlayerStatus.ElementQty[Element.Earth] * .1
		attack.StunTime += PlayerStatus.ElementQty[Element.Earth] * .1
		attack.BurnTime += PlayerStatus.ElementQty[Element.Fire] * .5
		attack.BurnDamage += PlayerStatus.ElementQty[Element.Fire] * .5
	elif attack.ElementType == [Element.Earth, Element.Earth]:
		# Spike
		attack.SpriteScale *= (1 + PlayerStatus.ElementQty[Element.Earth] * .15)
		attack.SpellRange += PlayerStatus.ElementQty[Element.Earth] * 5
		attack.AttackRange += PlayerStatus.ElementQty[Element.Earth] * 5
		attack.Damage += PlayerStatus.ElementQty[Element.Earth] * 3
		attack.ChantTime -= PlayerStatus.ElementQty[Element.Earth] * .1
		attack.StunTime += PlayerStatus.ElementQty[Element.Earth] * .1
	elif attack.ElementType == [Element.Earth, Element.Water]:
		# Turtle Shield
		attack.ChantTime -= PlayerStatus.ElementQty[Element.Water] * .2
		attack.Shield += PlayerStatus.ElementQty[Element.Earth] * 2
	elif attack.ElementType == [Element.Water, Element.Air]:
		# Poison
		pass
	elif attack.ElementType == [Element.Water, Element.Fire]:
		# Fog
		pass
	elif attack.ElementType == [Element.Water, Element.Earth]:
		# Mud
		pass
	elif attack.ElementType == [Element.Water, Element.Water]:
		# Cure
		attack.ChantTime -= PlayerStatus.ElementQty[Element.Water] * .05
		attack.Regenerate += PlayerStatus.ElementQty[Element.Water] * 2
