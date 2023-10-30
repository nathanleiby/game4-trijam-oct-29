class_name Puzzle
extends Node2D

@onready var _player := $Player
@onready var _playerArrow := $Player/Arrow
@onready var _relic := $Relic

var ROTATIONS = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN ]

const DEFAULT_PLAYER_POS := Vector2(2,3)
const DEFAULT_RELIC_POS := Vector2(2,1)
const DEFAULT_PLAYER_ROTATION := Vector2.UP

var playerPos := DEFAULT_PLAYER_POS
var playerRotation := DEFAULT_PLAYER_ROTATION
var relicPos := DEFAULT_RELIC_POS



const TILE_SIZE = 32
const MAX = 4

func _generatePositions():
	# random new player pos
	var newPlayerPos = playerPos
	while newPlayerPos.is_equal_approx(playerPos):
		newPlayerPos = Vector2(randi_range(0,MAX),randi_range(0,MAX))
	
	# random new player rotation
	var newPlayerRotation = playerRotation
	while newPlayerRotation.is_equal_approx(playerRotation):
		newPlayerRotation = ROTATIONS[randi_range(0, ROTATIONS.size()-1)]
	
	# random new relic pos, also that != playerPos
	var newRelicPos = relicPos
	while newRelicPos.is_equal_approx(playerPos) or newRelicPos.is_equal_approx(relicPos):
		newRelicPos = Vector2(randi_range(0,MAX),randi_range(0,MAX))
		
	playerRotation = newPlayerRotation
	playerPos = newPlayerPos
	relicPos = newRelicPos

func is_relic_collected():
	return playerPos.is_equal_approx(relicPos) # TODO: Vector2i could help here

func reset(is_new_game = false):
	if is_new_game:
		playerPos = DEFAULT_PLAYER_POS
		playerRotation = DEFAULT_PLAYER_ROTATION
		relicPos = DEFAULT_RELIC_POS
	else:
		_generatePositions()
		
	_updateView()
	
func _updateView():
	_player.position = playerPos * TILE_SIZE
	_playerArrow.rotation = playerRotation.angle()
	_relic.position = relicPos * TILE_SIZE 

	
func _ready():
	reset()
	
func _on_left_pressed():
	playerRotation = playerRotation.rotated(-PI/2)
	_updateView()

func _on_forward_pressed():
	playerPos = playerPos + playerRotation
	# walls
	playerPos.x = clamp(playerPos.x, 0, MAX)
	playerPos.y = clamp(playerPos.y, 0, MAX)
	
	_updateView()

func _on_right_pressed():
	playerRotation = playerRotation.rotated(PI/2)
	_updateView()

