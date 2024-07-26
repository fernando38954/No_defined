extends Control

func _process(delta):
	$Marker2D.rotate(PI/180)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scene/TrainScene.tscn")

func _on_credits_pressed():
	pass
	
func _on_exit_pressed():
	get_tree().quit()
