@tool
class_name LevelTransition extends Area2D

enum SIDE { LEFT, RIGHT, TOP, BOTTOM }

var offset_value : float = 32

@export_file( "*.tscn" ) var level
@export var target_transition_area : String = "LevelTransition"

@export_category("Collision Area Settings")

@export_range(1,12,1, "or_greater") var size : int = 2 : 
		set( _v ):
			size = _v
			_update_area()

@export var side : SIDE = SIDE.TOP :
		set( _v ):
			side = _v
			_update_area()



@export var snap_to_grid : bool = false :
		set( _v ):
			_snap_to_grid()



@onready var collision_shape : CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	_update_area()
	if Engine.is_editor_hint():
		return
	
	monitoring = false
	_place_player()
	
	await GlobalLevelManager.level_loaded
	
	monitoring = true
	
	body_entered.connect( _player_entered )
	
	pass

func _player_entered( _p : Node2D ) -> void:
	GlobalLevelManager.load_new_level( level, target_transition_area, get_offset())
	pass

func _place_player() -> void:
	if name != GlobalLevelManager.target_transition:
		return
	GlobalPlayerManager.set_player_position( global_position + GlobalLevelManager.position_offset )

func get_offset() -> Vector2:
	var offset : Vector2 = Vector2.ZERO
	var player_pos = GlobalPlayerManager.player.global_position


	#
	#
	# Fix later
	#
	#
	if side == SIDE.LEFT or side == SIDE.RIGHT:
		offset.y = player_pos.y - global_position.y
		if side == SIDE.LEFT:
			offset.x = -offset_value
		if side == SIDE.RIGHT:
			offset.x = offset_value
	elif side == SIDE.BOTTOM or side == SIDE.TOP:
		offset.x = player_pos.x - global_position.x
		if side == SIDE.TOP:
			offset.y = -offset_value
		if side == SIDE.BOTTOM:
			offset.y = 0
	
	
	return offset

##update the area
func _update_area() -> void:
	var new_rect : Vector2 = Vector2( 32, 32 )
	var new_position : Vector2 = Vector2.ZERO
	
	if side == SIDE.TOP:
		new_rect.x *= size
		new_position.y -= new_rect.y/2
	elif side == SIDE.BOTTOM:
		new_rect.x *= size
		new_position.y += new_rect.y/2
	elif side == SIDE.RIGHT:
		new_rect.y *= size
		new_position.x += new_rect.x/2
	elif side == SIDE.LEFT:
		new_rect.y *= size
		new_position.x -= new_rect.x/2
		
	if collision_shape == null:
		collision_shape = get_node("CollisionShape2D")
	
	collision_shape.shape.size = new_rect
	collision_shape.position = new_position
		

func _snap_to_grid() -> void:
	position.x = round( position.x / 16 ) * 16
	position.y = round( position.y / 16 ) * 16
