extends Node

var mainMenuMusic = load("res://sounds/main-theme.ogg");
var inGameMusic = load("res://sounds/in-game-music.ogg");
var gameOverMusic = load("res://sounds/game-over.ogg");

func _ready():
	pass

func stop():
	$Music.stop()
	
func playMenuMusic():
	if ($Music.stream != mainMenuMusic):
		$Music.stream = mainMenuMusic
		$Music.play()

func playGameMusic():
	$Music.stream = inGameMusic
	$Music.play()

func playGameOverMusic():
	$Music.stream = gameOverMusic
	$Music.play()
