# item interaction component script 
extends Area2D

func _on_body_entered(body):
	body.collect()
