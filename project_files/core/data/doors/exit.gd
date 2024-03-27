extends Node2D


@export_file("*.tscn") var target_scene


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.on_exit = true
		body.exit = self


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		body.on_exit = true
