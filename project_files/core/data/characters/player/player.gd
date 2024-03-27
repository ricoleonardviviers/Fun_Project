class_name Player
extends CharacterBody2D

enum States {
	IDLE, WALK, JUMP, FALL, DEAD
}

var state: States = States.IDLE
@export var jump_power: int
@export var max_speed: int
var can_double_jump: int
var dead: bool
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Variables used for level
var last_checkpoint: Node2D
var exit: String
var on_exit: bool

func _physics_process(delta: float) -> void:
	match_states(delta)
	move_and_slide()


func get_input() -> float:
	return Input.get_action_strength("move_right") - Input.get_action_strength("move_left")


func match_states(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and on_exit:
		get_tree().change_scene_to_file(exit)
	match state:
		States.IDLE:
			if not is_zero_approx(get_input()):
				state = States.WALK
				return
			if is_on_floor() and Input.is_action_pressed("jump"):
				state = States.JUMP
				velocity.y = -jump_power
			velocity.x = 0
			velocity.y += 980 * delta
			
			animated_sprite_2d.animation = "Idle"
		
		States.WALK:
			if is_zero_approx(get_input()):
				state = States.IDLE
				return
			if is_on_floor() and Input.is_action_just_pressed("jump"):
				state = States.JUMP
				velocity.y = -jump_power
				return
			
			velocity.x = max_speed * get_input()
			velocity.y += 980 * delta
			
			animated_sprite_2d.animation = "Run"
			
			
		
		States.JUMP:
			if is_on_floor():
				state = States.WALK
				return
			if Input.is_action_just_released("jump") and velocity.y < -10:
				var tween: Tween = get_tree().create_tween()
				tween.tween_property(self, ":velocity:y", 0.0, 0.1)
			if velocity.y >= 0:
				state = States.FALL
				return
			velocity.x = max_speed * get_input()
			velocity.y += 980 * delta
		
		States.FALL:
			if is_on_floor():
				var collider = get_last_slide_collision().get_collider()
				if collider is Enemy:
					collider.health -= 1
					velocity.y = -jump_power - (jump_power/3)
					return
				state = States.WALK
				return
			velocity.x = max_speed * get_input()
			velocity.y += 980 * delta
	
		States.DEAD:
			velocity.x = 0
			
	

func kill() -> void:
	# run death anim
	if not dead:
		state = States.DEAD
		dead = true
		await get_tree().create_timer(1.0).timeout
		state = States.IDLE
		dead = false
		global_position = last_checkpoint.global_position



