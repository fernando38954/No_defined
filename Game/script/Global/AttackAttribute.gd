extends Node

enum Type {
	Area, Line
}

var Tornado = {
	SpellRange = 100,
	AttackType = Type.Area,
   	AttackRange = 25,
	DamageCD = .2,
	Damage = 3
}

var Spike = {
	SpellRange = 70,
	AttackType = Type.Area,
   	AttackRange = 15,
	DamageCD = -1,
	Damage = 25
}
