extends Node2D

@onready var _puzzles: Array[Puzzle] = [$Puzzles/Puzzle, $Puzzles/Puzzle2]
@onready var _movesLabel: Label = $Control/VBoxContainer/MovesLabel as Label
@onready var _relicsLabel: Label = $Control/VBoxContainer/RelicsLabel as Label

var totalMoves := 0
var relicsCollected := 0

func _handleRelicCollected():
	for _puzzle in _puzzles:
		if _puzzle.is_relic_collected():
			relicsCollected += 1
			_puzzle.reset()
		
func _updateView():
	_movesLabel.text = "Moves: %d" % totalMoves
	_relicsLabel.text = "Relics: %d" % relicsCollected
	
func _ready():
	_updateView()

func _on_left_pressed():
	for _puzzle in _puzzles:
		_puzzle._on_left_pressed()
	totalMoves += 1
	_handleRelicCollected()
	_updateView()

func _on_forward_pressed():
	for _puzzle in _puzzles:
		_puzzle._on_forward_pressed()
	totalMoves += 1
	_handleRelicCollected()
	_updateView()

func _on_right_pressed():
	for _puzzle in _puzzles:
		_puzzle._on_right_pressed()
	totalMoves += 1
	_handleRelicCollected()
	_updateView()

