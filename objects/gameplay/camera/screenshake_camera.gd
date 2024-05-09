extends Camera2D

#@export var strength_curve: Curve
@export var shake_freq: float
@export var prev_dir_influence: float

var time_to_shake_point: float = 0
var curr_bounces: int
var curr_shake_dist: float
var curr_shake_dir: Vector2
var prev_waypoint: Vector2
var curr_waypoint: Vector2
var curr_shake_strength: float

var max_bounces: int
var max_shake_strength: float

var is_shaking: bool = false

func _ready():
	randomize()
	GlobalEvents.shake_camera.connect(shake_cam)

func shake_cam(num_bounces: int, shake_strength: float):
	is_shaking = true
	max_bounces = num_bounces
	max_shake_strength = shake_strength
	time_to_shake_point = 0
	curr_bounces = 0
	curr_shake_dir = random_on_unit_circle()
	prev_waypoint = Vector2.ZERO
	curr_shake_strength = shake_strength
	curr_waypoint = curr_shake_strength * curr_shake_dir

func _process(delta):
	if(!is_shaking and Input.is_key_pressed(KEY_U)):
		shake_cam(10, 20)
	if(is_shaking):
		time_to_shake_point += delta * shake_freq
		position = prev_waypoint.lerp(curr_waypoint, clampf(time_to_shake_point, 0, 1))
		if(time_to_shake_point >= 1):
			advance_waypoint()

func advance_waypoint():
	time_to_shake_point = 0
	curr_bounces += 1
	prev_waypoint = curr_waypoint
	if(curr_bounces == max_bounces):
		prev_waypoint = curr_waypoint
		curr_waypoint = Vector2.ZERO
	elif(curr_bounces > max_bounces):
		is_shaking = false
	else:
		curr_shake_dir = (random_on_unit_circle() + curr_shake_dir * prev_dir_influence).normalized()
		var decay = 1.0 - (float(curr_bounces) / max_bounces)
		curr_shake_strength = decay * decay * max_shake_strength
		curr_waypoint = curr_shake_strength * curr_shake_dir

func random_on_unit_circle () -> Vector2:
	return Vector2(randfn(0, 1), randfn(0, 1)).normalized()
