extends Node2D

class_name Sword;

@onready var SwordAnimationPlayer: AnimationPlayer = $SwordAnimation;

@export var SWORD_DAMAGE: int = 10;
@export var SWORD_RANGE: float = 50.0;
@export var SWORD_ATTACK_COOLDOWN: float = 0.5;

var attack_primary_cooldown: Cooldown = Cooldown.new(SWORD_ATTACK_COOLDOWN);

func _process(_delta: float) -> void:
	attack_primary_cooldown.update(_delta);


func attack_primary() -> void:
	if attack_primary_cooldown.is_ready():
		attack_primary_cooldown.start(SWORD_ATTACK_COOLDOWN);
		SwordAnimationPlayer.play("sword_swing");
