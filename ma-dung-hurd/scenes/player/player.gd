extends CharacterBody2D

class_name Player

const player_move_speed = 100;
const player_sprint_mult = 1.8;
const player_acceleration = 100;
const player_decceleration = 100;
const player_velocity_power = 0.8;

var player_current_move_direction = "front";

const dash_force = 1000;
var dash_is_ready: bool = true;

func _physics_process(delta: float):
	handel_movement_and_move_animation(delta)
	
	
func handel_movement_and_move_animation(delta):
	
	var input_velocity = Vector2.ZERO;
	
	if Input.is_action_pressed("player_move_up"):
		input_velocity.y -= 1;

	
	if Input.is_action_pressed("player_move_down"):
		input_velocity.y += 1;

	
	if Input.is_action_pressed("player_move_right"):
		input_velocity.x += 1;

	
	if Input.is_action_pressed("player_move_left"):
		input_velocity.x -= 1;
	
	var input_velocity_mult = 1;
	if Input.is_action_pressed("player_sprint"):
		input_velocity_mult = player_sprint_mult;
		
		
	input_velocity = input_velocity.normalized();
	
	play_move_animation(input_velocity, input_velocity_mult);
	
	velocity = calc_player_move_velocity(delta, input_velocity, input_velocity_mult);


	if Input.is_action_just_pressed("player_dash") and dash_is_ready:
		dash_is_ready = false;
		$Dash_coolcown.start();
		velocity = input_velocity*dash_force;
		
	
	move_and_slide()




func calc_player_move_velocity(delta, input_velocity, input_velocity_mult):
	
	velocity.x = calc_player_axic_velocity(delta, input_velocity.x,velocity.x,input_velocity_mult);
	velocity.y = calc_player_axic_velocity(delta, input_velocity.y,velocity.y,input_velocity_mult);
	
	return velocity;
	
	
func calc_player_axic_velocity(delta, input_velocity, _velocity, input_velocity_mult):
	
	var target_speed = input_velocity * player_move_speed * input_velocity_mult;
	
	var speed_dif = target_speed - _velocity;
	
	var acceleration_rate = player_acceleration if(abs(target_speed) > 0.01) else player_decceleration
	
	var movement = pow(abs(speed_dif) * acceleration_rate, player_velocity_power) * sign(speed_dif);
	
	return _velocity + movement * delta
	


func _on_dash_coolcown_timeout() -> void:
	dash_is_ready = true;




static var DIRECTION_LOOKUP = {
			"back": 0,
			"right": 1,
			"front": 2,
			"left": 3,
		}


static var ANIMATION_LOOKUP = {
			0: "back_idle",
			1: "back_walk",
			2: "side_idle",
			3: "side_walk",
			4: "front_Idle",
			5: "front_walk",
			6: "side_idle",
			7: "side_walk"
		}

func play_move_animation(input_velocity, input_velocity_mult):
	
	var is_moving = 0;
	
	if(input_velocity.x != 0):
		is_moving = 1;
		if(input_velocity.x > 0):
			player_current_move_direction = "right";
		else:
			player_current_move_direction = "left";
	elif(input_velocity.y != 0):
		is_moving = 1;
		if(input_velocity.y > 0):
			player_current_move_direction = "front";
		else:
			player_current_move_direction = "back";
		
	
	
	var dir = DIRECTION_LOOKUP[player_current_move_direction];

	var anim = $AnimatedSprite2D;

	var animation_picker = (dir << 1);
	animation_picker += is_moving;

	var animation = ANIMATION_LOOKUP[animation_picker];

	anim.flip_h = dir > 2;

	anim.play(animation);
