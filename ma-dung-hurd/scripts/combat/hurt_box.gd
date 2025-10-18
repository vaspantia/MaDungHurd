class_name HurtBox;
extends Area2D;

@export var health_component: HealthComponent;

## Handles damage taken from a HitBox. Applies damage to the associated HealthComponent
func _on_take_damage(damage_amount: float) -> void:
	print("hell");
	if not health_component:
		print("HurtBox: No HealthComponent assigned.");
	else:	
		if health_component.has_method("_on_damage_received"):
			damage_amount = health_component._on_damage_received(damage_amount);
		else:
			print("HurtBox: HealthComponent missing _on_damage_received method.");
