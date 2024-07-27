extends Control

func _ready():
	$TransitionScreen.transition("fade_in")
	if Function.winner:
		$P.hide()
		$Marker2D.hide()
	
func _process(delta):
	$Marker2D.rotate(PI/180)

func _on_button_pressed():
	$TransitionScreen.transition("fade_out")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scene/TrainScene.tscn")

func _on_credits_pressed():
	$Credits.text = "!@$#^%@"
	
func _on_exit_pressed():
	get_tree().quit()
