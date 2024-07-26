extends CharacterBody2D

enum Element {
	Null, Air, Fire, Earth, Water
}

var Element_QTY
var SpriteID = ["0", "1", "2", "3", "4", "5"]
var has_player
var can_invoke
var timer_invoke

func _ready():
	Element_QTY = 0
	has_player = false
	can_invoke = false
	timer_invoke = 3

func _physics_process(delta):
	$Sprite.play(SpriteID[Element_QTY])
	if has_player and Input.is_action_just_pressed("key_put") and Element_QTY <= 4:
		if PlayerStatus.checkElement() == Element.Earth:
			PlayerStatus.removeElement()
			Element_QTY += 1
			if Element_QTY == 5:
				can_invoke = true
	if can_invoke:
		timer_invoke = move_toward(timer_invoke, 0, delta)
		if timer_invoke == 0:
			var enemy = load("res://object/Character/Enemy/earthgolem.tscn").instantiate()
			enemy.global_position = Vector2(0, 0)
			get_tree().root.add_child(enemy)
			can_invoke = false

func _on_detection_area_body_entered(body):
	if body is Player:
		has_player = true
		
func _on_detection_area_body_exited(body):
	if body is Player:
		has_player = false
