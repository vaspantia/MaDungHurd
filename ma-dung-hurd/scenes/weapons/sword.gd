extends Node2D

class_name Sword;

@export var SWORD_DAMAGE: int = 10;
@export var SWORD_RANGE: float = 50.0;
@export var SWORD_SWING_SPEED: float = 50.0;
@export var SWORD_ATTACK_COOLDOWN: float = 0.5;

@export var HITBOX: HitBox;

var attack_primary_cooldown: Cooldown = Cooldown.new(SWORD_ATTACK_COOLDOWN);

var parent_hand: Node2D;

func _ready() -> void:
	if not HITBOX:
		push_error("Can't find weapon hitbox");
		return;
	
	parent_hand = get_parent();
	if not parent_hand:
		push_error("Sword.gd error: Can't find parent hand node");
		return;
	
	innitiate_weapon();
	
func innitiate_weapon() -> void:
	parent_hand.attatch_weapon(self, attack_primary_cooldown);
	parent_hand.connect("attack_performed", on_attack_performed);
	parent_hand.connect("hitbox_state_changed", hitbox_set_state);


func _process(_delta: float) -> void:
	attack_primary_cooldown.update(_delta);


func on_attack_performed(attack_info: Dictionary) -> bool:
	if attack_info["weapon"] != self:
		return false;
	if attack_info["type"] != "primary":
		return false;
	
	attack_primary_cooldown.start(SWORD_ATTACK_COOLDOWN);
	return false;


func hitbox_set_state(hitbox_state: bool) -> void:
	if not HITBOX:
		return;
	HITBOX.set_state_hitbox(hitbox_state);
