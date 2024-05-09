extends StaticBody2D

signal destroy_self
@export var num_screenshake_bounces: int = 0
@export var screenshake_strength: float = 10
@export var play_death_effects: bool = false
var is_dead = false
var broken1 = preload("res://objects/gameplay/breakable_brick/broken_brick_1.tscn")
var broken2 = preload("res://objects/gameplay/breakable_brick/broken_brick_2.tscn")


func on_collide_player(player: Node2D):
	if(player.global_position.y > global_position.y and !is_dead):
		destroy_self.emit()
		is_dead = true
		if(play_death_effects):
			death_effects()
		queue_free()

func death_effects():
	GlobalEvents.shake_camera.emit(num_screenshake_bounces, screenshake_strength)
	var b1 = broken1.instantiate()
	var b2 = broken2.instantiate()
	get_tree().root.add_child(b1)
	get_tree().root.add_child(b2)
	b1.global_position = global_position
	b2.global_position = global_position
