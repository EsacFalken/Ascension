extends Node2D


func _ready():
	match Global.lang:
		'en':
			$Label.text = 'CONTROLS'
			$Movement.label = 'Movement'
			$Jump.label = 'Jump'
			$DoubleJump.text = 'Double Jump'
			$Shoot.label = 'Shoot'
			$Restart.label = 'Restart'
		'fr':
			$Label.text = 'CONTROLES'
			$Movement.label = 'Se Deplacer'
			$Jump.label = 'Sauter'
			$DoubleJump.text = 'Double Sauter'
			$Shoot.label = 'Tirer'
			$Restart.label = 'Rejouer'


func _input(event):
	if Input.is_action_pressed("esc"):
		get_tree().change_scene("res://Scenes/menu.tscn")
