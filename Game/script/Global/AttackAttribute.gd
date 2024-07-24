extends Node

enum Type {
	Area, Line
}

var NULL = {
	SpellRange = 100,
	AttackType = Type.Area,
   	AttackRange = 20,
	DamageCD = 1,
	Damage = 1,
	ChantTime = 1
}

var Tornado = {
	SpellRange = 100,
	AttackType = Type.Area,
   	AttackRange = 25,
	DamageCD = .2,
	Damage = 3,
	ChantTime = 1
}

var Spike = {
	SpellRange = 70,
	AttackType = Type.Area,
   	AttackRange = 15,
	DamageCD = .3,
	Damage = 25,
	StunTime = .2,
	ChantTime = 1
}

var FireBlade = {
	SpellRange = 70,
	AttackType = Type.Line,
   	AttackRange = null,
	DamageCD = .1,
	Damage = 3,
	BurnTime = 4,
	ChantTime = 1
}

var Meteor = {
	SpellRange = 100,
	AttackType = Type.Area,
   	AttackRange = 30,
	DamageCD = null,
	Damage = 20,
	StunTime = .4,
	BurnTime = 2,
	ChantTime = 1
}
