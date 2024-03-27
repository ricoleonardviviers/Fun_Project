extends Node2D


@export_file("*.tscn") var target_scene


@onready var player : Player = get_node(^"../Player")


func _ready() -> void:
	player.key_lost.connect(Callable(self, "_on_key_lost"))
	player.key_collected.connect(Callable(self, "_on_key_collected"))


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player and body.has_key:
		body.on_exit = true
		body.exit = self


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		body.on_exit = true


func _on_key_lost() -> void:
	set_door_open(false)


func _on_key_collected() -> void:
	set_door_open(true)


func set_door_open(value: bool) -> void:
	pass
