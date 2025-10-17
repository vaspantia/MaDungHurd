extends Node

class_name DashComponent

@export var DASH_COOLDOWN_TIME: float = 1.0;
@export var DASH_FORCE = 1000;

var dash_cooldown := Cooldown.new(DASH_COOLDOWN_TIME);

var movement_component: MovementComponent;

func _ready() -> void:
	movement_component = get_parent().get_node("MovementComponent") as MovementComponent;
	if not movement_component:
		push_error("DashComponent requires a MovementComponent sibling");
		return


func _physics_process(delta: float) -> void:
	dash_cooldown.update(delta);


func dash(input_velocity: Vector2):
	
	if not movement_component:
		return;
	
	if not dash_cooldown.is_ready():
		return;

	dash_cooldown.start(DASH_COOLDOWN_TIME);

	var dash_velocity = input_velocity * DASH_FORCE;
	movement_component.set_velocity(dash_velocity);
