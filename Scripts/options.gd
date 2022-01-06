extends Node2D

signal trnsltn()
signal close_options()
onready var timer = $Menu/VBoxContainer/Timer
onready var pv = $Menu/VBoxContainer/PV
onready var arrow = $Arrow
var selected_option := 0


func _ready():
	arrow.rect_position.y = 77 + (selected_option % 4) * 21
	if get_tree().current_scene.name == 'Level':
		$Bg0.visible = false
		$Bg.visible = true
	elif get_tree().current_scene.name == 'Options':
		$Bg0.visible = true
		$Bg.visible = false
	if OS.window_fullscreen == true:
		$Menu/VBoxContainer/FullScreen.pressed = true
	elif OS.window_fullscreen == false:
		$Menu/VBoxContainer/FullScreen.pressed = false
		
	trnslt()
#	match Global.lang:
#		'en':
#			$Menu/VBoxContainer/Language/En.pressed = true
#			$Menu/VBoxContainer/Language/Fr.pressed = false
#		'fr':
#			$Menu/VBoxContainer/Language/En.pressed = false
#			$Menu/VBoxContainer/Language/Fr.pressed = true

	match Global.chrono:
		true:
			$Menu/VBoxContainer/Timer.pressed = true
		false:
			$Menu/VBoxContainer/Timer.pressed = false
		
	match Global.pv:
		true:
			$Menu/VBoxContainer/PV.pressed = true
		false:
			$Menu/VBoxContainer/PV.pressed = false


func _process(_delta):
	if arrow.rect_position.y == 77:
		$Menu/VBoxContainer/FullScreen.grab_focus()
	elif arrow.rect_position.y == 140:
		$Menu/VBoxContainer/Return.grab_focus()
#		119:
#			print('PV')
#			$Menu/VBoxContainer/PV.grab_focus()
#		140:
#			print('RETURN')
#			$Menu/VBoxContainer/Return.grab_focus()


func _input(event):

	if visible:

		if Input.is_action_pressed("ui_down"):
			Sfx.focus.play()
			selected_option += 1
			arrow.rect_position.y = 77 + (selected_option % 4) * 21
		elif Input.is_action_pressed("ui_up"):
			Sfx.focus.play()
			if selected_option == 0:
				selected_option = 3
			else:
				selected_option -= 1
			arrow.rect_position.y = 77 + (selected_option % 4) * 21

#		elif Input.is_action_pressed("ui_accept"):
#			if arrow.rect_position == 77:
#				if $Menu/VBoxContainer/FullScreen.pressed == true:
#					OS.window_fullscreen = true
#				else:
#					OS.window_fullscreen = false
#			elif arrow.rect_position.y == 98:
#				if $Menu/VBoxContainer/Timer.pressed == true:
#					Global.chrono = true
#					emit_signal("trnsltn")
#				else:
#					Global.chrono = false
#					emit_signal("trnsltn")
#			elif arrow.rect_position.y == 119:
#				if $Menu/VBoxContainer/PV.pressed == true:
#					Global.pv = true
#					emit_signal("trnsltn")
#				else:
#					Global.pv = false
#					emit_signal("trnsltn")
#			elif arrow.rect_position.y == 140:
#				_on_Return_pressed()


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




#func _on_En_pressed():
#	$Menu/VBoxContainer/Language/Fr.pressed = false
#	Global.lang = 'en'
#	trnslt()
#	emit_signal("trnsltn")

#func _on_Fr_pressed():
#	$Menu/VBoxContainer/Language/En.pressed = false
#	Global.lang = 'fr'
#	trnslt()
#	emit_signal("trnsltn")


func _on_FullScreen_toggled(button_pressed):
	Sfx.click.play()
	if button_pressed:
		OS.window_fullscreen = true
	else:
		OS.window_fullscreen = false
	
	
func _on_Timer_toggled(button_pressed):
	Sfx.click.play()
	if button_pressed:
		Global.chrono = true
		emit_signal("trnsltn")
	else:
		Global.chrono = false
		emit_signal("trnsltn")


func _on_PV_toggled(button_pressed):
	Sfx.click.play()
	if button_pressed:
		Global.pv = true
		emit_signal("trnsltn")
	else:
		Global.pv = false
		emit_signal("trnsltn")


func _on_Return_pressed():
	Sfx.click.play()
	if get_tree().current_scene.name == 'Level':
		self.visible = false
#		yield(get_tree().create_timer(0.1), "timeout")
		emit_signal("close_options")
	else:
		get_tree().change_scene("res://Scenes/menu.tscn")




