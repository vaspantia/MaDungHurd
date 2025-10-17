extends Node2D

class_name HandComponent;

@export var HAND_DISTANCE_FROM_PLAYER = 10;

var HAND_NODE: Node2D;

var current_weapon: Node2D;



func _ready() -> void:
	HAND_NODE = $Hand;
	if not HAND_NODE:
		push_error("HandComponent error: Can't find Hand node");
		set_process(false);
		return;
	
	current_weapon = HAND_NODE.get_child(0);
	if not current_weapon:
		push_error("HandComponent error: No weapon found in Hand node. Not even a fucking Hand!!");
		set_process(false);
		return;

func _physics_process(_delta: float):
	if not HAND_NODE:
		return;
	var mouse_relative_pos = get_local_mouse_position();
	HAND_NODE.position = mouse_relative_pos.normalized() * HAND_DISTANCE_FROM_PLAYER;
	HAND_NODE.rotation = mouse_relative_pos.angle();


func attack_primary():
	if current_weapon and current_weapon.has_method("attack_primary"):
		current_weapon.attack_primary();
	else:
		push_error("HandComponent error: Current weapon has no attack_primary method");
	pass
