extends Node

enum States {
	IDLE, WALK, JUMP, FALL
}

var state: States = States.IDLE
var jump_power: int
var max_speed: int
var can_double_jump: int



func _physics_process(delta: float) -> void:
	pass



func match_state(delta: float) -> void:
	match state:
		States.IDLE:
			pass
		States.WALK:
			pass
		States.JUMP:
			pass
	pass
