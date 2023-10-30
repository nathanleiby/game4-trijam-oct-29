class_name Puzzle
extends Node2D

@onready var _player := $Player
@onready var _playerArrow := $Player/Arrow
@onready var _relic := $Relic

var playerPos := Vector2(2,2)
var playerRotation := Vector2.UP
var relicPos := Vector2(2,2)

const TILE_SIZE = 32
const MAX = 4

func _generatePositions():
	# random new player pos
	var newPlayerPos = playerPos
	while newPlayerPos.is_equal_approx(playerPos):
		newPlayerPos = Vector2(randi_range(0,MAX),randi_range(0,MAX))
	
	# random new relic pos, also that != playerPos
	var newRelicPos = relicPos
	while newRelicPos.is_equal_approx(playerPos) or newRelicPos.is_equal_approx(relicPos):
		newRelicPos = Vector2(randi_range(0,MAX),randi_range(0,MAX))
		
	playerPos = newPlayerPos
	relicPos = newRelicPos

func is_relic_collected():
	return playerPos.is_equal_approx(relicPos) # TODO: Vector2i could help here

func reset():
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

