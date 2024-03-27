extends CharacterBody2D

enum States {
	LEFT = -1, RIGHT = 1
}


var health: int = 1

@export var max_speed: int
var state : States = States.LEFT
@onready var ray_right: RayCast2D = $RayRight
@onready var ray_left: RayCast2D = $RayLeft

func _physics_process(delta: float) -> void:
	match state:
		States.LEFT:
			if not ray_left.is_colliding() or is_on_wall():
				state = States.RIGHT
		States.RIGHT:
			if not ray_right.is_colliding() or is_on_wall():
				state = States.LEFT
	velocity.x = max_speed * int(state)
	velocity.y += 980 * delta
	move_and_slide()
