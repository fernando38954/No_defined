extends Node2D

enum Type {
	Area, Line
}

var radius
var attack_type
var attack_radius

func start(_radius, _attack_type, _attack_radius):
	radius = _radius
	$CircleRangeDetector/CollisionShape2D.shape.radius = _radius
	attack_type = _attack_type
	attack_radius = _attack_radius
	if attack_type == Type.Line:
		PlayerStatus.in_attack_range = true
		var attack_indicator = load("res://object/AttackIndicator/LineIndicator.tscn").instantiate()
		attack_indicator.start(_radius)
		add_child(attack_indicator)
		attack_indicator.name = "Indicator"

func _process(delta):
	if attack_type == Type.Area && get_node_or_null("Indicator"):
		global_rotation = 0.0
		$Indicator.global_position = get_global_mouse_position()

func _draw():
	draw_circle(Vector2(0,0), radius, Color(.5, .5, .5, .5))
	
func _on_circle_range_mouse_entered():
	if attack_type == Type.Area && !get_node_or_null("Indicator"):
		PlayerStatus.in_attack_range = true
		var attack_indicator = load("res://object/AttackIndicator/circleIndicator.tscn").instantiate()
		attack_indicator.start(attack_radius)
		add_child(attack_indicator)
		attack_indicator.name = "Indicator"

func _on_circle_range_mouse_exited():
	if attack_type == Type.Area && get_node_or_null("Indicator"):
		PlayerStatus.in_attack_range = false
		$Indicator.queue_free()
