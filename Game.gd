extends Node2D

@onready var _player := $Player
@onready var _relic := $Relic


var playerPos := Vector2i(0,0)

var relicPos := Vector2i(1,1)

const TILE_SIZE = 32

func _updatePositions():
	_player.position = playerPos * TILE_SIZE
	_relic.position = relicPos * TILE_SIZE 
	
func _ready():
	_updatePositions()
	
func _on_left_pressed():
	playerPos.x -= 1
	_updatePositions()

func _on_forward_pressed():
	playerPos.y -= 1
	_updatePositions()

func _on_right_pressed():
	playerPos.x += 1
	_updatePositions()


# TODO: Next up 
# - show direction player is facing. 
# - do movement relative to player's current facing 
# - add "win" condition of reaching the relic
