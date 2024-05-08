extends StaticBody2D

@onready var init_pos = position
var collected: bool = false

func _process(delta):
	position.y = sin(Time.get_ticks_msec() / 250.0) + init_pos.y

func collect():
	if collected: return
	collected = true
	
	$AudioStreamPlayer2D.play()
	var tween = create_tween()
	
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property($AnimatedSprite2D, "scale", Vector2(1.5, 1.5), 0.1)
	
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property($AnimatedSprite2D, "scale", Vector2.ZERO, 0.5)
	
	tween.tween_callback(queue_free)
