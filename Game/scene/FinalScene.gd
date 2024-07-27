extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	if Function.win:
		DialogueManager.show_example_dialogue_balloon(load("res://dialog/Intro.dialogue"), "win")
		Function.winner = true
	else:
		DialogueManager.show_example_dialogue_balloon(load("res://dialog/Intro.dialogue"), "loose")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Function.finished:
		get_tree().change_scene_to_file("res://scene/Title.tscn")
