class_name HealthComponent

extends Node


@export var max_health: float = 100.0;
var current_health: float = max_health;


signal health_changed(new_health: float);
signal health_depleted();


func _on_damage_received(damage_amount: float) -> float:
	current_health -= damage_amount;
	current_health = clamp(current_health, 0.0, max_health);
	emit_signal("health_changed", current_health);
	if current_health == 0:
		emit_signal("health_depleted");
	return damage_amount;

func _on_health_received(health_amount: float) -> float:
	current_health += health_amount;
	current_health = clamp(current_health, 0.0, max_health);
	emit_signal("health_changed", current_health);
	if current_health == 0:
		emit_signal("health_depleted");
	return health_amount;


func get_health() -> float:
	return current_health;
