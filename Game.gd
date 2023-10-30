extends Node2D

@onready var _puzzle: Puzzle = $Puzzle as Puzzle
@onready var _movesLabel: Label = $Control/VBoxContainer/MovesLabel as Label
@onready var _relicsLabel: Label = $Control/VBoxContainer/RelicsLabel as Label

var totalMoves := 0
var relicsCollected := 0

func _handleRelicCollected():
	if _puzzle.is_relic_collected():
		relicsCollected += 1
		_puzzle.reset()
	
func _updateView():
	_movesLabel.text = "Moves: %d" % totalMoves
	_relicsLabel.text = "Relics: %d" % relicsCollected
	
func _ready():
	_updateView()

func _on_left_pressed():
	_puzzle._on_left_pressed()
	totalMoves += 1
	_handleRelicCollected()
	_updateView()

func _on_forward_pressed():
	_puzzle._on_forward_pressed()
	totalMoves += 1
	_handleRelicCollected()
	_updateView()

func _on_right_pressed():
	_puzzle._on_right_pressed()
	totalMoves += 1
	_handleRelicCollected()
	_updateView()

