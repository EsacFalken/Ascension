extends Node2D

onready var select_arrow = $Arrow
var selected_option := 0


func _ready():

	match Global.lang:
		'fr':
			$Menu/VBoxContainer/Play/Label.text = "Jouer"
			$Menu/VBoxContainer/Controls/Label.text = "Controles"
			$Menu/VBoxContainer/Exit/Label.text = "Quitter"
		'en':
			$Menu/VBoxContainer/Play/Label.text = "Play"
			$Menu/VBoxContainer/Controls/Label.text = "Controls"
			$Menu/VBoxContainer/Exit/Label.text = "Exit"

	select_arrow.rect_position.y = 80 + (selected_option % 4) * 18


func _input(event):

	if Input.is_action_pressed("reset"):
		print('start_joy_vibration')
		Input.start_joy_vibration(0, 0.3, 0.7, 0.2)

	if Input.is_action_pressed("ui_down"):
		selected_option += 1
		select_arrow.rect_position.y = 80 + (selected_option % 4) * 18
	elif Input.is_action_pressed("ui_up"):
		if selected_option == 0:
			selected_option = 3
		else:
			selected_option -= 1
		select_arrow.rect_position.y = 80 + (selected_option % 4) * 18

	elif Input.is_action_pressed("ui_accept"):
		if select_arrow.rect_position.y == 80:
			_on_Play_pressed()
		elif select_arrow.rect_position.y == 98:
			_on_Controls_pressed()
		elif select_arrow.rect_position.y == 116:
			_on_Options_pressed()
		elif select_arrow.rect_position.y == 134:
			_on_Exit_pressed()


func _on_Play_pressed():
	get_tree().change_scene("res://Scenes/level.tscn")


func _on_Controls_pressed():
	get_tree().change_scene("res://Scenes/controls.tscn")


func _on_Options_pressed():
	get_tree().change_scene("res://Scenes/options.tscn")


func _on_Exit_pressed():
	get_tree().quit()
