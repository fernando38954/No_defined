extends Attack

var finalShield
var diffShield : float

func _ready():
	extract("TurtleShield")
	
	$AnimatedSprite2D.play("default")
	finalShield = min(PlayerStatus.Shield + attack.Shield, PlayerStatus.maxShield)
	diffShield = finalShield - PlayerStatus.Shield
	
	PlayerStatus.need_reset = true

func additional_process(delta):
	global_position = PlayerStatus.global_position
	if timer_damage == 0:
		PlayerStatus.Shield = move_toward(PlayerStatus.Shield, finalShield, diffShield/50)
