extends Control


func _ready():
	get_tree().paused = false


func _process(delta):
	$Camera2D.position.y += 1
	if $Camera2D.position.y == 780:
		SceneChanger.change_scene("res://Scenes/menu.tscn", "fade")
