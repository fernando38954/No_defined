extends Node

var global_position = Vector2(0, 0)

var can_move = true
var can_dash = true
var in_dash = false

var can_attack = true
var in_attack = false
var need_reset = false

var in_attack_range = false

var muzzle_position = Vector2(0, 0)
var direction = Vector2(0, 0)

var attack_position = null

# =================================== UI ===================================
enum Element {
	Null, Air, Fire, Earth, Water
}

var maxHP = 100
var HP = 100
var backHP = 100
var maxShield = 100
var Shield = 100
var backShield = 100

var Element1 = Element.Null
var Element2 = Element.Null
var Element3 = Element.Null
var Element4 = Element.Null
var Element5 = Element.Null

func getElement(type):
	Element5 = Element4
	Element4 = Element3
	Element3 = Element2
	Element2 = Element1
	Element1 = type
