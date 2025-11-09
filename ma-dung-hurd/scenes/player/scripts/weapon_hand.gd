extends RemoteTransform2D


@export var handRoot: Node2D;

func _ready() -> void:
	handRoot.connect("weapon_changed", _on_weapon_changed);


func _on_weapon_changed(new_weapon: Node2D) -> void:
	if new_weapon:
		remote_path = new_weapon.get_path();
	else:
		remote_path = NodePath();
