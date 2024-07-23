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

# =================================== UI ===================================
var maxHP = 100
var HP = 100
var backHP = 100
