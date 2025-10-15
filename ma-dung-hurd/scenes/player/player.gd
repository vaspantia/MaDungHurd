extends CharacterBody2D


const player_move_speed = 300;
var player_current_move_direction = "front";



func _physics_process(delta: float):
	handel_movement_and_move_animation()
	
	
func handel_movement_and_move_animation():
	
	velocity = Vector2.ZERO;

	var is_moving = 0;
	
	if Input.is_action_pressed("ui_up"):
		velocity.y -= player_move_speed;
		player_current_move_direction = "back"; 
		is_moving = 1;
	
	
	if Input.is_action_pressed("ui_down"):
		velocity.y += player_move_speed;
		player_current_move_direction = "front";
		is_moving = 1;
	
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += player_move_speed;
		player_current_move_direction = "right";
		is_moving = 1;
	
	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= player_move_speed;
		player_current_move_direction = "left";
		is_moving = 1;
	
	play_move_animation(is_moving);
	
	move_and_slide()
	



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

func play_move_animation(is_moving):
	var dir = DIRECTION_LOOKUP[player_current_move_direction];

	var anim = $AnimatedSprite2D;

	var animation_picker = (dir << 1);
	animation_picker += is_moving;

	var animation = ANIMATION_LOOKUP[animation_picker];

	anim.flip_h = dir > 2;

	anim.play(animation);
