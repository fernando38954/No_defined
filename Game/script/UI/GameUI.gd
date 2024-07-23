extends CanvasLayer
	
func _process(delta):
	$HPBar.value = PlayerStatus.HP
	$BackHPBar.value = PlayerStatus.backHP
	$HPLabel.text = "{0}/{1} ({2}%)".format([$HPBar.value, PlayerStatus.maxHP, int($HPBar.value/PlayerStatus.maxHP*100)])
