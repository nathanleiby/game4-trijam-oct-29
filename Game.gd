extends Node2D

@onready var _player := $Player
@onready var _playerArrow := $Player/Arrow
@onready var _relic := $Relic


var playerPos := Vector2(0,0)
var playerRotation := Vector2.UP
var relicPos := Vector2(1,1)

const TILE_SIZE = 32

func _updatePositions():
	_player.position = playerPos * TILE_SIZE
	_playerArrow.rotation = playerRotation.angle()
	_relic.position = relicPos * TILE_SIZE 
	
func _ready():
	_updatePositions()
	
func _on_left_pressed():
	playerRotation = playerRotation.rotated(-PI/2)
	_updatePositions()

func _on_forward_pressed():
	print(rotation)
	playerPos = playerPos + playerRotation
	_updatePositions()

func _on_right_pressed():
	playerRotation = playerRotation.rotated(PI/2)
	_updatePositions()


# TODO: Next up 
# - show direction player is facing. 
# - do movement relative to player's current facing 
# - add "win" condition of reaching the relic
