extends Node2D

enum Element {
	Null, Air, Fire, Earth, Water
}

const Attack_name = ["Tornado", "Fire Blade", "Meteor", "Spike", "Turtle Shield", "Cure"]
const Attack_element = [["Air", "Air"], ["Fire", "Fire"], ["Earth", "Fire"], ["Earth", "Earth"], ["Earth", "Water"], ["Water", "Water"]]
var id = 0

func _ready():
	id = 0

func _process(delta):
	$Attack.play(Attack_name[id])
	$Name.text = Attack_name[id]
	$Element1.play(Attack_element[id][0])
	$Element2.play(Attack_element[id][1])
	$Input.text = ""
	for i in 2:
		$Input.text += " + "
		if Attack_element[id][i] == "Air":
			$Input.text += "W"
		if Attack_element[id][i] == "Fire":
			$Input.text += "D"
		if Attack_element[id][i] == "Earth":
			$Input.text += "S"
		if Attack_element[id][i] == "Water":
			$Input.text += "A"

func _on_return_pressed():
	hide()

func _on_left_pressed():
	id -= 1
	if id < 0:
		id += 6

func _on_right_pressed():
	id = (id + 1) % 6
