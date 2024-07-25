extends Node2D

enum Type {
	Area, Line, Self
}

var attack
var radius
var attack_type
var attack_radius

func start(name):
	attack = AttackAttribute.export(name)
	
	$CircleRangeDetector/CollisionShape2D.shape.radius = attack.SpellRange
	if attack.AttackType == Type.Line:
		PlayerStatus.in_attack_range = true
		var attack_indicator = load("res://object/AttackIndicator/LineIndicator.tscn").instantiate()
		attack_indicator.start(attack.SpellRange)
		add_child(attack_indicator)
		attack_indicator.name = "Indicator"
	if attack.AttackType == Type.Self:
		PlayerStatus.in_attack_range = true

func _process(delta):
	if attack.AttackType == Type.Area and get_node_or_null("Indicator"):
		global_rotation = 0.0
		$Indicator.global_position = get_global_mouse_position() if PlayerStatus.attack_position == null else PlayerStatus.attack_position

func _draw():
	draw_circle(Vector2(0,0), attack.SpellRange, Color(.5, .5, .5, .5))
	
func _on_circle_range_mouse_entered():
	if attack.AttackType == Type.Area and !get_node_or_null("Indicator") and PlayerStatus.attack_position == null:
		PlayerStatus.in_attack_range = true
		var attack_indicator = load("res://object/AttackIndicator/circleIndicator.tscn").instantiate()
		attack_indicator.start(attack.AttackRange)
		add_child(attack_indicator)
		attack_indicator.name = "Indicator"

func _on_circle_range_mouse_exited():
	if attack.AttackType == Type.Area and get_node_or_null("Indicator") and PlayerStatus.attack_position == null:
		PlayerStatus.in_attack_range = false
		$Indicator.queue_free()
