extends CharacterBody2D

@onready var movement_component: MovementComponent = $scripts/MovementComponent;
@onready var dash_component: DashComponent = $scripts/DashComponent;
@onready var animation_component: AnimationComponent = $scripts/AnimationComponent;
@onready var hand_component: HandComponent = $HandRoot;

var input_velocity: Vector2 = Vector2.ZERO;
var is_sprinting: bool = false;


func _ready() -> void:
	if not movement_component:
		push_error("Player.gd error: Missing MovementComponent");
	if not dash_component:
		push_error("Player.gd error: Missing DashComponent");
	if not animation_component:
		push_error("Player.gd error: Missing AnimationComponent");
	if not hand_component:
		push_error("Player.gd error: Missing HandComponent");


func _physics_process(_delta: float):
	process_movement_input();

	animation_component.play_move_animation(input_velocity, is_sprinting);
	
func _process(_delta: float):
	process_attack_input();


func process_movement_input():
	
	input_velocity = Vector2.ZERO;
	
	if Input.is_action_pressed("player_move_up"):
		input_velocity.y -= 1;

	
	if Input.is_action_pressed("player_move_down"):
		input_velocity.y += 1;

	if Input.is_action_pressed("player_move_right"):
		input_velocity.x += 1;

	
	if Input.is_action_pressed("player_move_left"):
		input_velocity.x -= 1;

	is_sprinting = Input.is_action_pressed("player_sprint");
		
		
	input_velocity = input_velocity.normalized();

	movement_component.process_movement(input_velocity, is_sprinting);

	if Input.is_action_just_pressed("player_dash"):
		dash_component.dash(input_velocity);
	

func process_attack_input():
	if not hand_component:
		return;
		
	if Input.is_action_just_pressed("player_attack_primary"):
		hand_component.attack_primary();

	if Input.is_action_just_pressed("player_attack_secondary"):
		print("Secondary attack");


	
