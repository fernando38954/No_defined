extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Function.reset_all()
	$GameUi/Pause.hide()
	$GameUi/Confirm.hide()
	$Portal.play("default")

func _process(delta):
		if Input.is_action_just_pressed("key_pause"):
			$GameUi/Pause.show()
			$GameUi/Pause.active = true
			$GameUi/Pause.delay_pause = $GameUi/Pause.PauseCD
			get_tree().paused = true


func _on_area_2d_body_entered(body):
	$GameUi/Confirm.show()
	get_tree().paused = true
