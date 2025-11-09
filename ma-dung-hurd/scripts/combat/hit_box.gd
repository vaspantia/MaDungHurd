class_name HitBox
extends Area2D;

@export var damage: float = 1.0;

#signal damage_dealt(hurtbox: HurtBox, damage_amount: float);

var collision_shape;

func _ready() -> void:
	collision_shape = get_child(0);
	if not collision_shape:
		push_error("HitBox.gd error: Can't find collision shape");
		return;
	connect("area_entered", _on_area_entered);
	connect("area_exited", _on_area_exited);


func _on_area_entered(hurtbox: HurtBox) -> void:
	if not hurtbox is HurtBox:
		return;
	print("HitBox dealt %f damage to HurtBox" % damage);
	hurtbox._on_take_damage(damage);
	#damage_dealt.emit(hurtbox, damage);


func _on_area_exited(hurtbox: HurtBox) -> void:
	if not hurtbox is HurtBox:
		return;
	# You can add logic here if needed when the hurtbox exits


func set_damage(new_damage: float) -> void:
	damage = new_damage;

func get_damage() -> float:
	return damage;

func set_state_hitbox(state: bool) -> void:
	if not collision_shape:
		return;
		
	collision_shape.set("disabled", not state);
