extends Node2D

@export var _puzzleScene: PackedScene
@onready var _puzzles: Array[Puzzle] = [$Puzzles/Puzzle, $Puzzles/Puzzle2, $Puzzles/Puzzle3, $Puzzles/Puzzle4, $Puzzles/Puzzle5, $Puzzles/Puzzle6, $Puzzles/Puzzle7, $Puzzles/Puzzle8]
@onready var _movesLabel: Label = $Control/VBoxContainer/MovesLabel as Label
@onready var _relicsLabel: Label = $Control/VBoxContainer/RelicsLabel as Label

var totalMoves := 0
var relicsCollected := 0

func _handleRelicCollected():
	var newPuzzles: Array[Puzzle] = []
	var to_spawn = 0
	for p in _puzzles:
		if p.visible:
			if p.is_relic_collected():
				relicsCollected += 1
				# set two other puzzles as visible
				to_spawn += 2	

				# make this one invisible
				p.visible = false
				p.reset()
				
			
	var puzzleIdxs = range(len(_puzzles))
	puzzleIdxs.shuffle()
	for i in puzzleIdxs:
		if to_spawn <= 0:
			break
		var p = _puzzles[i]
		if not p.visible:
			p.visible = true
			p.reset()
			to_spawn -= 1
			
			
			
	# TODO: figure out dynamically handling this. instantiating..
	# .. ran into an issue with Puzzle instantiate() having null member vars like Player
	
func _updateView():
	_movesLabel.text = "Moves: %d" % totalMoves
	_relicsLabel.text = "Relics: %d" % relicsCollected
	
func _ready():
	_updateView()

func _on_left_pressed():
	for _puzzle in _puzzles:
		if _puzzle.visible:
			_puzzle._on_left_pressed()
	totalMoves += 1
	_handleRelicCollected()
	_updateView()

func _on_forward_pressed():
	for _puzzle in _puzzles:
		if _puzzle.visible:
			_puzzle._on_forward_pressed()
	totalMoves += 1
	_handleRelicCollected()
	_updateView()

func _on_right_pressed():
	for _puzzle in _puzzles:
		if _puzzle.visible:
			_puzzle._on_right_pressed()
	totalMoves += 1
	_handleRelicCollected()
	_updateView()

