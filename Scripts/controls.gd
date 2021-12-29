extends Node2D


func _ready():
	match Global.lang:
		'en':
			$Title.text = 'CONTROLS'
			$Movement.text = 'Movement'
			$Jump.text = 'Jump'
			$DoubleJump.text = 'Double Jump'
			$Shoot.text = 'Shoot'
			$Restart.text = 'Restart'
			$Label.text = 'Press on   or   for return to the title screen'
		'fr':
			$Title.text = 'CONTROLES'
			$Movement.text = 'Se Deplacer'
			$Jump.text = 'Sauter'
			$DoubleJump.text = 'Double Sauter'
			$Shoot.text = 'Tirer'
			$Restart.text = 'Rejouer'
			$Label.text = "Appyuer sur   ou   pour retourner a l'ecran titre    "


func _input(event):
	if Input.is_action_pressed("esc"):
		get_tree().change_scene("res://Scenes/menu.tscn")
