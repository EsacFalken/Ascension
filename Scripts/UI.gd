extends Control

onready var timer = $Timer/Label
var hour : int = 0
var minute : int = 0
var second : int = 0
var x := 0

func _ready():
	x = 0
	minute = 0
	second = 0
	hour = 0

func _process(delta):

	match x:
		0:
			timer.text =str(second)
		1:
			timer.text = str(minute) + ':' + str(second)
		2:
			timer.text = str(hour) + ':' + str(minute) + ':' + str(second)
	if second >= 60:
		second = 0
		minute += 1 
		if x == 0:
			x = 1
	elif minute >= 60:
		minute = 0
		if x == 1:
			x = 2
		hour += 1 



func _on_Timer_timeout():
	second += 1
