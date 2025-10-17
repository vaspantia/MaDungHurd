extends Node2D;

@onready var SceneTransitionAnimation = $SceneTransition/AnimationPlayer

func _ready() -> void:
	SceneTransitionAnimation.get_parent().get_node("ColorRect").color.a = 255
	SceneTransitionAnimation.play("fade_out");

var entered = false;

func _process(_delta) -> void:
	if entered == true:
		#if Input.is_action_just_pressed("ui_accept"):
			SceneTransitionAnimation.play("fade_in");
			await get_tree().create_timer(SceneTransitionAnimation.get_animation("fade_in").get_length()).timeout
			get_tree().change_scene_to_file("res://scenes/levels/dungeon_1.tscn");

func _on_portal_change_scene_body_entered(body: PhysicsBody2D) -> void:
	if body is Player:
		entered = true;
