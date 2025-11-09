extends Camera2D

var cam_zoom = 1;


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("zoom_in"): increase_zoom();
	if Input.is_action_just_pressed("zoom_out"): decrease_zoom();


func increase_zoom() -> void:
	cam_zoom += 0.1;
	zoom_updated();

func decrease_zoom() -> void:
	cam_zoom -= 0.1;
	zoom_updated();
	
	
func zoom_updated() -> void:
	cam_zoom = clamp(cam_zoom,0.1,10);
	zoom = Vector2(cam_zoom,cam_zoom)
