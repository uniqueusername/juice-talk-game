extends Node2D

@onready var p: CharacterBody2D = get_parent()

func _physics_process(delta):
	for i in range(p.get_slide_collision_count()):
		var collision: KinematicCollision2D = p.get_slide_collision(i)
		var collider: Object = collision.get_collider()
		if(collider.has_method("on_collide_player")):
			collider.on_collide_player(self)
