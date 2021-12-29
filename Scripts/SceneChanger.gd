extends CanvasLayer

onready var animation = $Control/AnimationPlayer
var scene :  String


func change_scene(newScene, anim):
	scene = newScene
	animation.play(anim)



func _new_scene():
	get_tree().change_scene(scene)

func _on():
	$Control.visible = true

func _off():
	$Control.visible = false
