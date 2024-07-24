extends Node2D

enum Type {
	Area, Line
}

var radius
var attack_type
var attack_radius

func extract(name):
	var attack = AttackAttribute.get(name)
	radius = attack.SpellRange
	attack_type = attack.AttackType
	attack_radius = attack.AttackRange

func start(name):
	extract(name)
	$CircleRangeDetector/CollisionShape2D.shape.radius = radius
	if attack_type == Type.Line:
		PlayerStatus.in_attack_range = true
		var attack_indicator = load("res://object/AttackIndicator/LineIndicator.tscn").instantiate()
		attack_indicator.start(radius)
		add_child(attack_indicator)
		attack_indicator.name = "Indicator"

func _process(delta):
	if attack_type == Type.Area and get_node_or_null("Indicator"):
		global_rotation = 0.0
		$Indicator.global_position = get_global_mouse_position() if PlayerStatus.attack_position == null else PlayerStatus.attack_position

func _draw():
	draw_circle(Vector2(0,0), radius, Color(.5, .5, .5, .5))
	
func _on_circle_range_mouse_entered():
	if attack_type == Type.Area and !get_node_or_null("Indicator") and PlayerStatus.attack_position == null:
		PlayerStatus.in_attack_range = true
		var attack_indicator = load("res://object/AttackIndicator/circleIndicator.tscn").instantiate()
		attack_indicator.start(attack_radius)
		add_child(attack_indicator)
		attack_indicator.name = "Indicator"

func _on_circle_range_mouse_exited():
	if attack_type == Type.Area and get_node_or_null("Indicator") and PlayerStatus.attack_position == null:
		PlayerStatus.in_attack_range = false
		$Indicator.queue_free()
