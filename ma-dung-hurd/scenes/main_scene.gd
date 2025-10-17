extends Control

@onready var hud: Control = $HUD
@onready var menu: Control = $Menu
@onready var main_2d: Node2D = $Main2D
var level_instance: Node2D

func _ready() -> void:
	Global.main_screen = self

func unload_level() -> void:
	if is_instance_valid(level_instance):
		level_instance.queue_free()
		level_instance = null

func load_level(level_name: String) -> void:
	unload_level()
	var level_path := "res://scenes/levels/%s.tscn" % level_name
	var level_resource := load(level_path)
	if level_resource:
		level_instance = level_resource.instantiate()
		main_2d.add_child(level_instance)

func _on_load_1_pressed() -> void:
	load_level("overworld")

func _on_load_2_pressed() -> void:
	load_level("dungeon_1")
