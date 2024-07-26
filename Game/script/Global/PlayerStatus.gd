extends Node

var global_position = Vector2(0, 0)

const DASH_CD = 2
var can_move = true
var can_dash = true
var in_dash = false
var timer_dash = 0

var can_attack = true
var in_attack = false
var need_reset = false

var in_attack_range = false

var muzzle_position = Vector2(0, 0)
var direction = Vector2(0, 0)

var attack_position = null

var golem_defeat = 0

# ================================= Debuff =================================
var in_burnArea = 0
var in_frozenArea = 0

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

var ElementSet = [Element.Null, Element.Null, Element.Null, Element.Null, Element.Null]

var ElementQty = [5, 0, 0, 0, 0]

func getElement(type):
	ElementQty[ElementSet[4]] -= 1
	ElementQty[type] += 1
	for i in range(4, 0, -1):
		ElementSet[i] = ElementSet[i-1]
	ElementSet[0] = type

func checkElement():
	return ElementSet[0]

func removeElement():
	ElementQty[ElementSet[0]] -= 1
	ElementQty[Element.Null] += 1
	for i in 4:
		ElementSet[i] = ElementSet[i+1]
	ElementSet[4] = Element.Null
