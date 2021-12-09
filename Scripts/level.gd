extends Node2D

var active = false
onready var pauseMenu = $CanvasLayer/PauseMenu
onready var options = $CanvasLayer/Options
const posA = Vector2(370, 41)
const posB = Vector2(1552, -375)
const posC = Vector2(825, -487)
const posD = Vector2(886, -1271)

func _ready():
	$CanvasLayer/Options.connect('close_options', self, 'options_closed')
	$CanvasLayer/PauseMenu.connect('open_options', self, 'options_opened')
	$CanvasLayer/Options.connect('trnsltn', self, 'get_trnsltn')

	$Guy.position = posA
	pauseMenu.visible = false
	options.visible = false
	$CanvasLayer/Loading.visible = false
	
	$Music.play()

	match Global.chrono:
		true:
			$CanvasLayer/UI/Timer.visible = true
		false:
			$CanvasLayer/UI/Timer.visible = false
	match Global.pv:
		true:
			$CanvasLayer/UI/MarginContainer/Sprite.visible = true
		false:
			$CanvasLayer/UI/MarginContainer/Sprite.visible = false


func _input(event):
	if Input.is_action_pressed("pause"):
		get_tree().paused = true
		pauseMenu.visible = true
	elif get_node_or_null('DialogNode') == null:
		if event.is_action_pressed("ui_accept") and active:
			get_tree().paused = true
			if Global.lang == 'fr':
				match $Guy.position:
					posA:
						var dialog = Dialogic.start('welcome_fr')
						dialog.pause_mode = Node.PAUSE_MODE_PROCESS
						dialog.connect('timeline_end', self, 'unpause')
						add_child(dialog)
					posB:
						var dialog = Dialogic.start('rewelcome_fr')
						dialog.pause_mode = Node.PAUSE_MODE_PROCESS
						dialog.connect('timeline_end', self, 'unpause')
						add_child(dialog)
					posC:
						var dialog = Dialogic.start('prev_fr')
						dialog.pause_mode = Node.PAUSE_MODE_PROCESS
						dialog.connect('timeline_end', self, 'unpause')
						add_child(dialog)
					posD:
						var dialog = Dialogic.start('finally_fr')
						dialog.pause_mode = Node.PAUSE_MODE_PROCESS
						dialog.connect('timeline_end', self, 'unpause')
						add_child(dialog)
			elif Global.lang == 'en':

				match $Guy.position:
					posA:
						var dialog = Dialogic.start('welcome_en')
						dialog.pause_mode = Node.PAUSE_MODE_PROCESS
						dialog.connect('timeline_end', self, 'unpause')
						add_child(dialog)
					posB:
						var dialog = Dialogic.start('rewelcome_en')
						dialog.pause_mode = Node.PAUSE_MODE_PROCESS
						dialog.connect('timeline_end', self, 'unpause')
						add_child(dialog)
					posC:
						var dialog = Dialogic.start('prev_en')
						dialog.pause_mode = Node.PAUSE_MODE_PROCESS
						dialog.connect('timeline_end', self, 'unpause')
						add_child(dialog)
					posD:
						var dialog = Dialogic.start('finally_en')
						dialog.pause_mode = Node.PAUSE_MODE_PROCESS
						dialog.connect('timeline_end', self, 'unpause')
						add_child(dialog)

	if $Player.position.x < $Guy.position.x :
		$Guy/Sprite.flip_h = true
	else:
		$Guy/Sprite.flip_h = false



func unpause(timeline_name):
	active = false
	get_tree().paused = false

func ouch():
	$Player/AnimationPlayer.play("hit")
	Global.camera.shake(30)
	Input.start_joy_vibration(0, 0.3, 0.7, 0.2)
	match Global.health:
		4:
			$CanvasLayer/UI/MarginContainer/Sprite/AnimationPlayer.play("four")
		3:
			$CanvasLayer/UI/MarginContainer/Sprite/AnimationPlayer.play("three")
		2:
			$CanvasLayer/UI/MarginContainer/Sprite/AnimationPlayer.play("two")
		1:
			$CanvasLayer/UI/MarginContainer/Sprite/AnimationPlayer.play("one")

func anim_health():
	match Global.health:
		4:
			$CanvasLayer/UI/MarginContainer/Sprite/AnimationPlayer.play("four")
		3:
			$CanvasLayer/UI/MarginContainer/Sprite/AnimationPlayer.play("three")
		2:
			$CanvasLayer/UI/MarginContainer/Sprite/AnimationPlayer.play("two")
		1:
			$CanvasLayer/UI/MarginContainer/Sprite/AnimationPlayer.play("one")

func anim_save():
	$CanvasLayer/Loading.visible = true
	$CanvasLayer/Loading/AnimationPlayer.play("save")
	yield(get_tree().create_timer(3.0), "timeout")
	$CanvasLayer/Loading/AnimationPlayer.stop()
	$CanvasLayer/Loading.visible = false



func options_closed():
	print("CLOSE ?")
	pauseMenu.visible = true

func options_opened():
	print("OPEN ?")
	pauseMenu.visible = false
	options.visible = true


func get_trnsltn():

	print("TRANSLATION")

	match Global.lang:
		'fr':
			$CanvasLayer/PauseMenu/Menu/VBoxContainer/Play/Label.text = "Reprendre"
			$CanvasLayer/PauseMenu/Menu/VBoxContainer/Exit/Label.text = "Quitter"
		'en':
			$CanvasLayer/PauseMenu/Menu/VBoxContainer/Play/Label.text = "Resume"
			$CanvasLayer/PauseMenu/Menu/VBoxContainer/Exit/Label.text = "Exit"

	match Global.chrono:
		true:
			$CanvasLayer/UI/Timer.visible = true
		false:
			$CanvasLayer/UI/Timer.visible = false
	match Global.pv:
		true:
			$CanvasLayer/UI/MarginContainer/Sprite.visible = true
		false:
			$CanvasLayer/UI/MarginContainer/Sprite.visible = false


func _on_Cp1_body_entered(Player):
	$Player.initialPosition = $Checkpoint/Cp1.position
	anim_save()

func _on_Cp2_body_entered(body):
	$Player.initialPosition = $Checkpoint/Cp2.position
	anim_save()

func _on_Cp3_body_entered(body):
	$Player.initialPosition = $Checkpoint/Cp3.position
	anim_save()

func _on_Cp4_body_entered(body):
	$Player.initialPosition = $Checkpoint/Cp4.position
	anim_save()


#func _on_Check3_body_entered(body):
#	$Message/Mess3.visible = true


#func _on_Check3_body_exited(body):
#	$Message/Mess3.visible = false


#func _on_Check2_body_entered(body):
#	$Message/Mess2.visible = true


#func _on_Check2_body_exited(body):
#	$Message/Mess2.visible = false


#func _on_Final_body_entered(body):
#	$Message/Mess4.visible = true


func _on_AnimationPlayer_animation_finished(hit):
	$Player/AnimationPlayer.play("RESET")


func _on_Guy_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	Global.canShoot = true
	active = true


func _on_Guy_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	Global.canShoot = false
	active = false


func _on_Mess1_body_entered(body):
	if $Guy.position == posA :
		$Guy.position = posB

func _on_Mess2_body_entered(body):
	if $Guy.position == posB :
		$Guy.position = posC

func _on_Mess3_body_entered(body):
	if $Guy.position == posC :
		$Guy.position = posD
