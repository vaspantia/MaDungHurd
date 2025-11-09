extends Node2D

class_name HandComponent;

var current_weapon: Node2D;

var current_weapon_cooldown: Cooldown;

signal no_weapon_found();

signal weapon_changed(new_weapon: Node2D);

signal attack_performed(attack_info: Dictionary);

signal hitbox_state_changed(state: bool);

	
func _ready() -> void:
	return;
	
func attatch_weapon(_weapon_instance, _weapon_cooldown) -> void:
	
	if not _weapon_instance || not _weapon_cooldown:
		return;

	
	current_weapon = _weapon_instance;
	current_weapon_cooldown = _weapon_cooldown;
	
	weapon_changed.emit(current_weapon);

	return;


func attack_primary():
	
	if not current_weapon:
		no_weapon_found.emit();
		return;
		
	if not current_weapon_cooldown.is_ready():
		return;

	attack_performed.emit({"type": "primary", "weapon": current_weapon});




func Set_weapon_hitbox(_state: bool) -> void:
	print("Setting weapon hitbox state to: ", _state);
	hitbox_state_changed.emit(_state);
	
