extends Node2D

onready var select_arrow = $Arrow
var selected_option := 0


func _ready():

	$Menu/VBoxContainer/Play.grab_focus()

	match Global.dontShowIntro:
		true:
			$start.visible = false
			$Title.rect_position = Vector2(0, 0)
			$Menu.visible = true
			$Arrow.visible = true
		false:
			$AnimationPlayer.play("intro")
			if Input.is_joy_known(0):
				$start.text = "Press on Start"
			Input.connect("joy_connection_changed",self,"joy_con_changed")
			$Arrow.visible = false
			$Menu.visible = false

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


func joy_con_changed(deviceid,isConnected):

	if isConnected:
		print("Joystick " + str(deviceid) + " connected")
		$start.text = "Press on Start"
	if Input.is_joy_known(0):
		print("Recognized and compatible joystick")
		print(Input.get_joy_name(0) + " device connected")
	else:
		print("Joystick " + str(deviceid) + " disconnected")


func _input(_event):

	if Input.is_action_just_pressed("start") and $start.visible == true:
		Sfx.click.play()
		$start.visible = false
		var tween = $Tween
		tween.interpolate_property($Title, "rect_position", Vector2(0, 33), Vector2(0, 0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		yield(get_tree().create_timer(0.9), "timeout")
		$Menu.visible = true
		$Arrow.visible = true

	if $Arrow.visible:
		if Input.is_action_pressed("ui_down"):
			Sfx.focus.play()
			selected_option += 1
			select_arrow.rect_position.y = 80 + (selected_option % 4) * 18
		elif Input.is_action_pressed("ui_up"):
			Sfx.focus.play()
			if selected_option == 0:
				selected_option = 3
			else:
				selected_option -= 1
			select_arrow.rect_position.y = 80 + (selected_option % 4) * 18

#	elif Input.is_action_pressed("ui_accept"):
#		if select_arrow.rect_position.y == 80:
#			_on_Play_pressed()
#		elif select_arrow.rect_position.y == 98:
#			_on_Controls_pressed()
#		elif select_arrow.rect_position.y == 116:
#			_on_Options_pressed()
#		elif select_arrow.rect_position.y == 134:
#			_on_Exit_pressed()


func _process(_delta):
	if $Arrow.rect_position.y == 80:
		$Menu/VBoxContainer/Play.grab_focus()


func _on_Play_pressed():
	Sfx.click.play()
	Global.dontShowIntro = true
	SceneChanger.change_scene("res://Scenes/level.tscn", "fade")


func _on_Controls_pressed():
	Sfx.click.play()
	Global.dontShowIntro = true
	get_tree().change_scene("res://Scenes/controls.tscn")


func _on_Options_pressed():
	Global.dontShowIntro = true
	Sfx.click.play()
	get_tree().change_scene("res://Scenes/options.tscn")


func _on_Exit_pressed():
	Sfx.click.play()
	get_tree().quit()
