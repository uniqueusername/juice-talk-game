extends CharacterBody2D

@onready var init_pos: Vector2 = position

# called once, when this scene is initialized
func _ready():
	pass
	
# called every render frame
func _process(delta):
	pass

# called every physics frame (60 times per second)
func _physics_process(delta):
	pass

# called every time an input occurs
func _input(event):
	pass

func cancel_movement():
	$movement.cancel_movement()

func kill():
	cancel_movement()
	position = init_pos
	$death_audio.play()
