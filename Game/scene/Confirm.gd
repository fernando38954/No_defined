extends Control

func _on_yes_pressed():
	get_tree().paused = false
	$"../TransitionScreen".transition("portal")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scene/Main.tscn")

func _on_no_pressed():
	hide()
	get_tree().paused = false
