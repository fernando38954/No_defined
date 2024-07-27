extends CanvasLayer

func transition(type):
	visible = true
	$AnimationPlayer.play(type)

func _on_animation_player_animation_finished(anim_name):
	visible = false
