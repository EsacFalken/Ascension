extends Node2D

signal trnsltn()
signal close_options()
onready var timer = $Menu/VBoxContainer/Timer
onready var pv = $Menu/VBoxContainer/PV



func _ready():
	if get_tree().current_scene.name == 'Level':
		$Bg0.visible = false
		$Bg.visible = true
	else:
		$Bg0.visible = true
		$Bg.visible = false
	trnslt()
	match Global.lang:
		'en':
			$Menu/VBoxContainer/Language/En.pressed = true
			$Menu/VBoxContainer/Language/Fr.pressed = false
		'fr':
			$Menu/VBoxContainer/Language/En.pressed = false
			$Menu/VBoxContainer/Language/Fr.pressed = true



func trnslt():
	match Global.lang:
		'fr':
#			$Menu/VBoxContainer/Language/Label.text = "Langue"
			$Menu/VBoxContainer/PV/Label.text = "Afficher les PV"
			$Menu/VBoxContainer/Timer/Label.text = "Afficher le Timer"
			$Menu/VBoxContainer/Return/Label.text = "Retour"
		'en':
#			$Menu/VBoxContainer/Language/Label.text = "Language"
			$Menu/VBoxContainer/PV/Label.text = "Show PV"
			$Menu/VBoxContainer/Timer/Label.text = "Show Timer"
			$Menu/VBoxContainer/Return/Label.text = "Return"


func _on_Return_pressed():
	if get_tree().current_scene.name == 'Level':
		self.visible = false
		emit_signal("close_options")
	else:
		get_tree().change_scene("res://Scenes/menu.tscn")


func _on_En_pressed():
	$Menu/VBoxContainer/Language/Fr.pressed = false
	Global.lang = 'en'
	trnslt()
	emit_signal("trnsltn")

func _on_Fr_pressed():
	$Menu/VBoxContainer/Language/En.pressed = false
	Global.lang = 'fr'
	trnslt()
	emit_signal("trnsltn")


func _on_Timer_pressed():
	Global.chrono = true
	emit_signal("trnsltn")


func _on_PV_pressed():
	Global.pv = true
	emit_signal("trnsltn")


func _on_Timer_button_up():
	Global.chrono = false
	emit_signal("trnsltn")


func _on_PV_button_up():
	Global.pv = false
	emit_signal("trnsltn")
