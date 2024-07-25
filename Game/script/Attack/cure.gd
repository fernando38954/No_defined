extends Attack

var finalHP
var diffHP : float

func _ready():
	extract("Cure")
	
	$AnimatedSprite2D.play("default")
	finalHP = min(PlayerStatus.HP + attack.Regenerate, PlayerStatus.maxHP)
	diffHP = finalHP - PlayerStatus.HP
	
	PlayerStatus.need_reset = true

func additional_process(delta):
	global_position = PlayerStatus.global_position
	if timer_damage == 0:
		PlayerStatus.HP = move_toward(PlayerStatus.HP, finalHP, diffHP/50)
