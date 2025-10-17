extends Node

class_name MovementComponent

@export var PLAYER_MOVE_SPEED: int = 100;
@export var PLAYER_SPRINT_MULT: float = 1.8;
@export var PLAYER_ACCELERATION: int = 100;
@export var PLAYER_DECCELERATION: int = 100;
@export var PLAYER_VELOCITY_POWER: float = 0.8;

var target_speed: Vector2 = Vector2.ZERO;
	
# Refrence to the velocity of the parent character
var character: CharacterBody2D;

func _ready() -> void:
	character = get_parent().get_parent() as CharacterBody2D;
	if not character:
		push_error("MovementComponent error: MovementComponent must be child of child of CharacterBody2D");
		set_process(false);


func _physics_process(_delta: float) -> void:
	var _target_speed = target_speed;
	character.velocity.x = calc_player_axis_velocity(_delta, _target_speed.x, character.velocity.x);
	character.velocity.y = calc_player_axis_velocity(_delta, _target_speed.y, character.velocity.y);
	character.move_and_slide();

func process_movement(input_velocity: Vector2, is_sprinting: bool) -> void:

	if not character:
		return;

	var input_velocity_mult = PLAYER_SPRINT_MULT if is_sprinting else 1.0;

	target_speed = input_velocity * PLAYER_MOVE_SPEED * input_velocity_mult;


func calc_player_axis_velocity(delta: float, _target_speed: float, _velocity: float) -> float:
	
	var speed_dif = _target_speed - _velocity;

	var acceleration_rate = PLAYER_ACCELERATION if(abs(_target_speed) > 0.01) else PLAYER_DECCELERATION;

	var movement = pow(abs(speed_dif) * acceleration_rate, PLAYER_VELOCITY_POWER) * sign(speed_dif);

	return _velocity + movement * delta;



func set_velocity(new_velocity: Vector2) -> void:
	if not character:
		return;
	character.velocity = new_velocity;

func add_velocity(added_velocity: Vector2) -> void:
	if not character:
		return;
	character.velocity += added_velocity;


func get_velocity() -> Vector2:
	if not character:
		return Vector2.ZERO;
	return character.velocity;
