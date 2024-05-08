extends StaticBody2D

@onready var init_pos = position

func _process(delta):
	position.y = sin(Time.get_ticks_msec() / 250.0) + init_pos.y
