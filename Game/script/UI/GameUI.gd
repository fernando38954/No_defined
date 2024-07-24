extends CanvasLayer

enum Element {
	Null, Air, Fire, Earth, Water
}

func _process(delta):
	$HPBar.value = PlayerStatus.HP
	$BackHPBar.value = PlayerStatus.backHP
	$ShieldBar.value = PlayerStatus.Shield
	$BackShieldBar.value = PlayerStatus.backShield
	$HPLabel.text = "[center]"
	$HPLabel.text += "[color=white]{0}/{1} ({2}%)[/color]".format([$HPBar.value, PlayerStatus.maxHP, int($HPBar.value/PlayerStatus.maxHP*100)])
	if $ShieldBar.value > 0:
		$HPLabel.text += " + [color=aqua]{0}[/color]".format([$ShieldBar.value])
	$HPLabel.text += "[/center]"
	
	# Element 1
	if PlayerStatus.Element1 == Element.Air:
		$ElementSlote1.play("Air")
	elif PlayerStatus.Element1 == Element.Earth:
		$ElementSlote1.play("Earth")
	elif PlayerStatus.Element1 == Element.Fire:
		$ElementSlote1.play("Fire")
	elif PlayerStatus.Element1 == Element.Water:
		$ElementSlote1.play("Water")
	else:
		$ElementSlote1.play("Null")

	# Element 2
	if PlayerStatus.Element2 == Element.Air:
		$ElementSlote2.play("Air")
	elif PlayerStatus.Element2 == Element.Earth:
		$ElementSlote2.play("Earth")
	elif PlayerStatus.Element2 == Element.Fire:
		$ElementSlote2.play("Fire")
	elif PlayerStatus.Element2 == Element.Water:
		$ElementSlote2.play("Water")
	else:
		$ElementSlote2.play("Null")

	# Element 3
	if PlayerStatus.Element3 == Element.Air:
		$ElementSlote3.play("Air")
	elif PlayerStatus.Element3 == Element.Earth:
		$ElementSlote3.play("Earth")
	elif PlayerStatus.Element3 == Element.Fire:
		$ElementSlote3.play("Fire")
	elif PlayerStatus.Element3 == Element.Water:
		$ElementSlote3.play("Water")
	else:
		$ElementSlote3.play("Null")

	# Element 4
	if PlayerStatus.Element4 == Element.Air:
		$ElementSlote4.play("Air")
	elif PlayerStatus.Element4 == Element.Earth:
		$ElementSlote4.play("Earth")
	elif PlayerStatus.Element4 == Element.Fire:
		$ElementSlote4.play("Fire")
	elif PlayerStatus.Element4 == Element.Water:
		$ElementSlote4.play("Water")
	else:
		$ElementSlote4.play("Null")

	# Element 5
	if PlayerStatus.Element5 == Element.Air:
		$ElementSlote5.play("Air")
	elif PlayerStatus.Element5 == Element.Earth:
		$ElementSlote5.play("Earth")
	elif PlayerStatus.Element5 == Element.Fire:
		$ElementSlote5.play("Fire")
	elif PlayerStatus.Element5 == Element.Water:
		$ElementSlote5.play("Water")
	else:
		$ElementSlote5.play("Null")
