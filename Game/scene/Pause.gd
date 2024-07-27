extends Control

const PauseCD = .1
var delay_pause = .1
var active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu.visible = true
	$AttackBook.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not active:
		return
	
	$Menu.visible = not $AttackBook.visible
	
	if Input.is_action_just_pressed("key_pause") and delay_pause == 0:
		hide()
		active = false
		$AttackBook.visible = false
		get_tree().paused = false
	delay_pause = move_toward(delay_pause, 0, delta)


func _on_attack_book_pressed():
	$AttackBook.visible = true

func _on_return_pressed():
	hide()
	active = false
	get_tree().paused = false

func _on_exit_pressed():
	get_tree().paused = false
	$"../TransitionScreen".transition("fade_out")
	await get_tree().create_timer(1).timeout
	Function.erase = true
	get_tree().change_scene_to_file("res://scene/Title.tscn")
