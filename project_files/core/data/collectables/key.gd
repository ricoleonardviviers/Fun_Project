extends Area2D


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.has_key = true
		body.key_lost.connect(Callable(self, "enable"))


func disable() -> void:
	collision_shape_2d.set_deferred("disabled", true)


func enable() -> void:
	collision_shape_2d.set_deferred("disabled", false)
