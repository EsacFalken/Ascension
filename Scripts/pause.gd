extends Control

signal open_options()
onready var select_arrow = $Arrow
var selected_option := 0


func _ready():

	select_arrow.rect_position.y = 78 + (selected_option % 3) * 18

	match Global.lang:
		'fr':
			$Menu/VBoxContainer/Play/Label.text = "Reprendre"
			$Menu/VBoxContainer/Exit/Label.text = "Quitter"
		'en':
			$Menu/VBoxContainer/Play/Label.text = "Resume"
			$Menu/VBoxContainer/Exit/Label.text = "Exit"



func _input(event):
	if visible:
		if Input.is_action_pressed("ui_down"):
			selected_option += 1
			select_arrow.rect_position.y = 78 + (selected_option % 3) * 18
		elif Input.is_action_pressed("ui_up"):
			if selected_option == 0:
				selected_option = 2
			else:
				selected_option -= 1
			select_arrow.rect_position.y = 78 + (selected_option % 3) * 18

		elif Input.is_action_pressed("ui_accept"):
			if select_arrow.rect_position.y == 78:
				_on_Play_pressed()
			elif select_arrow.rect_position.y == 96:
				_on_Options_pressed()
			elif select_arrow.rect_position.y == 114:
				_on_Exit_pressed()


func _on_Play_pressed():
	get_tree().paused = false
	self.visible = false


func _on_Options_pressed():
	emit_signal("open_options")


func _on_Exit_pressed():
	SceneChanger.change_scene("res://Scenes/menu.tscn", "fade")
	get_tree().paused = false
