extends CharacterBody2D


func _physics_process(delta: float) -> void:

	velocity += Vector2.from_angle(randf()*PI*2)*10;
	move_and_slide();


func _on_health_component_health_depleted() -> void:
	self.hide();


func _on_health_component_health_changed(new_health: float) -> void:
	pass;
