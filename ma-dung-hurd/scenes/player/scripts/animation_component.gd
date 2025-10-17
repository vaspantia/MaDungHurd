extends Node

class_name AnimationComponent

var player_current_move_direction = "front";

var animation_node: AnimatedSprite2D;

func _ready() -> void:
	animation_node = get_parent().get_parent().get_node("PlayerAnimation") as AnimatedSprite2D;
	if not animation_node:
		push_error("Can't find animation player");
	set_process(false);

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

func play_move_animation(_input_velocity, _is_sprinting):
	
	var is_moving = 0;
	
	if(_input_velocity.x != 0):
		is_moving = 1;
		if(_input_velocity.x > 0):
			player_current_move_direction = "right";
		else:
			player_current_move_direction = "left";
	elif(_input_velocity.y != 0):
		is_moving = 1;
		if(_input_velocity.y > 0):
			player_current_move_direction = "front";
		else:
			player_current_move_direction = "back";
		
	
	
	var dir = DIRECTION_LOOKUP[player_current_move_direction];

	var animation_picker = (dir << 1);
	animation_picker += is_moving;

	var animation = ANIMATION_LOOKUP[animation_picker];

	animation_node.flip_h = dir > 2;

	animation_node.play(animation);
