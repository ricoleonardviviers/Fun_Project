extends Node2D


const player = preload("res://core/data/characters/player/player.tscn")

func _ready() -> void:
	var node = player.instantiate()
	get_parent().add_child.call_deferred(node)
	node.global_position = global_position
