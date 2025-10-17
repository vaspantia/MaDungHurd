extends RefCounted
class_name Cooldown

var duration: float
var time_left: float = 0.0

func _init(_duration: float) -> void:
	duration = _duration

func update(delta: float) -> void:
	if time_left > 0.0:
		time_left -= delta

func start(_new_duration = null) -> void:
	if _new_duration != null:
		duration = _new_duration;
	time_left = duration;

func is_ready() -> bool:
	return time_left <= 0.0;
