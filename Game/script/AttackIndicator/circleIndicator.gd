extends Node2D

var radius

func start(_radius):
	radius = _radius

func _draw():
	draw_circle(Vector2(0,0), radius, Color(.8, .8, .8, .5))
