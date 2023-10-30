extends Node2D

@export var _puzzleScene: PackedScene
@onready var _puzzles: Array[Puzzle] = [$Puzzles/Puzzle, $Puzzles/Puzzle2, $Puzzles/Puzzle3, $Puzzles/Puzzle4, $Puzzles/Puzzle5, $Puzzles/Puzzle6, $Puzzles/Puzzle7, $Puzzles/Puzzle8]

@onready var _movesLabel: Label = $Control/VBoxRight/MovesLabel as Label
@onready var _relicsLabel: Label = $Control/VBoxRight/RelicsLabel as Label
@onready var _storyLabel: Label = $Control/VBoxLeft/StoryLabel as Label
@onready var _timerLabel: Label = $Control/VBoxLeft/TimerLabel as Label
@onready var _timer: Timer = $Timer as Timer

var totalMoves := 0
var relicsCollected := 0
var story = [
	"The relic is within reach...",
	"<YOUR TIME HERE IS LIMITED>",
]

func _handleRelicCollected():
	var newPuzzles: Array[Puzzle] = []
	var to_spawn = 0
	for p in _puzzles:
		if p.visible:
			if p.is_relic_collected():
				relicsCollected += 1
				if relicsCollected == 1:
					_movesLabel.visible = true
					_relicsLabel.visible = true
					_timerLabel.visible = true
					_storyLabel.text = story[1]
					_timer.start()
					
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

func _process(_delta):
	_timerLabel.text = str(int(ceil(_timer.time_left)))
	
func _ready():
	# init new game
	_puzzles[0].reset(true)
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



func _on_timer_timeout():
	get_tree().paused = true
	$GameOver.visible = true
	$GameOver/VBoxContainer/MovesLabel.text = "Moves: %d" % totalMoves
	$GameOver/VBoxContainer/RelicsLabel.text = "Relics: %d" % relicsCollected

func _on_restart_button_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false
	
