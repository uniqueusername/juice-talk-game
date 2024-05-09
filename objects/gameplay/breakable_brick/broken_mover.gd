extends Sprite2D

@export var gravity: float = 10
@export var lifetime: float = 5
@export var randx: float = 20
@export var randy: float = 10

var curr_lifetime: float = 0
var curr_velocity: Vector2 = Vector2.ZERO

func _enter_tree():
	curr_velocity = Vector2(randf_range(-randx, randx), randy)

func _process(delta):
	curr_velocity.y += gravity * delta
	position += curr_velocity * delta
	curr_lifetime += delta
	if(curr_lifetime > lifetime):
		queue_free()
