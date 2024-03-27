extends Node2D


@export_file("*.tscn") var target_scene

var entered = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	entered = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	entered = false


func _process(delta: float) -> void:
	if entered:
		if  Input.is_action_just_pressed("interact"):
			get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
