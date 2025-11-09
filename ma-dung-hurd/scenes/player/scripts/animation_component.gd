extends Node

class_name AnimationComponent

@export var HandRoot : Node2D;

var player_current_move_direction = "front";


var is_weapon_animation_playing = false;
var can_leg_animation_play_on_weapon_animation = false;
var is_moving = 0;


@export var ANIMATION_TREE: AnimationTree;

func _ready() -> void:
	if not ANIMATION_TREE:
		push_error("Can't find leg animation player");

	if not HandRoot:
		push_error("Can't find HandRoot node");
	
	HandRoot.connect("attack_performed", attack_animation);
	set_process(false);



func play_animation(_velocity: Vector2, _input_velocity: Vector2, _is_sprinting: bool) -> void:
	if not ANIMATION_TREE:
		return;
	play_leg_animation(_velocity, _input_velocity, _is_sprinting);
	return;





func play_leg_animation(_velocity: Vector2, _input_velocity: Vector2, _is_sprinting: bool) -> void:
	
	is_moving = 0;
	
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

	if not is_moving:
		ANIMATION_TREE.set("parameters/Movment/transition_request","Idle");
	else:
		ANIMATION_TREE.set("parameters/Movment/transition_request","Front_walk");
		ANIMATION_TREE.set("parameters/MoceScale/scale",_velocity.length()/80);


func attack_animation(_info: Dictionary) -> void:
	ANIMATION_TREE.set("parameters/OneShots/transition_request","Swing");
	ANIMATION_TREE.set("parameters/OneShot/request", 1);
	return;


static var LEG_ANIMATION_ON_WEAPON_ANIMATION_LOOKUP = {
	"something": false,
}



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
