extends Node2D

var radius

func start(_radius):
	radius = _radius

func _process(delta):
	rotation = PlayerStatus.direction.angle()
	
func _draw():
	draw_rect(Rect2(0, -5, radius, 10), Color(.8, .8, .8, .5))
