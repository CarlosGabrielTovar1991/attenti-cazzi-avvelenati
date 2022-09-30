extends Node2D

var earnedCoinsCounter = 0
var earnedBagsCounter = 0
var missedCoinsCounter = 0
var missedBagsCounter = 0
var missedDicksCounter = 0
var score = 0
var gamePaused = false

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	get_tree().paused = false
	GlobalSignals.connect("moneyBag_picked", self, "moneyBag_picked_handler")
	GlobalSignals.connect("moneyBag_missed", self, "moneyBag_missed_handler")
	GlobalSignals.connect("dick_picked", self, "dick_picked_handler")
	GlobalSignals.connect("dick_missed", self, "dick_missed_handler")
	GlobalSignals.connect("coin_picked", self, "coin_picked_handler")
	GlobalSignals.connect("coin_missed", self, "coin_missed_handler")
	MusicPlayer.playGameMusic()


func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		if (gamePaused == false):
			$PauseDialogContainer/PauseDialog.show()
			get_tree().paused = true
			gamePaused = true
		else:
			$PauseDialogContainer/PauseDialog.hide()
			get_tree().paused = false
			gamePaused = false

func _process(_delta):
	var scoreFromBags = (10 * earnedBagsCounter) - (5 * missedBagsCounter)
	var scoreFromCoins = (25 * earnedCoinsCounter) - (15 * missedCoinsCounter)
	var newScore = scoreFromBags + scoreFromCoins
	if (newScore > 0):
		score = newScore
	$Score.text = String(score)
	$MoneyBagCounter.text = String(earnedBagsCounter)
	$CoinCounter.text = String(earnedCoinsCounter)

func moneyBag_picked_handler():
	earnedBagsCounter += 1
	$AudioStream.play()
	
func moneyBag_missed_handler():
	missedBagsCounter += 1

func coin_picked_handler():
	earnedCoinsCounter += 1
	$AudioStream.play()
	
func coin_missed_handler():
	missedCoinsCounter += 1

func dick_picked_handler():
	$GameOverDialogContainer/GameOverDialog.show()
	$GameOverDialogContainer/GameOverDialog/moneyEarnedQnty.text = String(earnedBagsCounter)
	$GameOverDialogContainer/GameOverDialog/coinEarnedQnty.text = String(earnedCoinsCounter)
	$GameOverDialogContainer/GameOverDialog/moneyMissedQnty.text = String(missedBagsCounter)
	$GameOverDialogContainer/GameOverDialog/coinMissedQnty.text = String(missedCoinsCounter)
	if (missedDicksCounter > 0):
		$GameOverDialogContainer/GameOverDialog/dickMissedQnty.text = String(missedDicksCounter)
	else:
		$GameOverDialogContainer/GameOverDialog/dickMissedLabel.text = 'Non sei riuscito a eludere nessuno'
		$GameOverDialogContainer/GameOverDialog/dickMissedQnty.text = ''
	$GameOverDialogContainer/GameOverDialog/TotalPoints.text = String(score)
	get_tree().paused = true

func dick_missed_handler():
	missedDicksCounter += 1

func _on_ResumeButton_pressed():
	$PauseDialogContainer/PauseDialog.hide()
	get_tree().paused = false
	gamePaused = false

func _on_ExitButton_pressed():
	get_tree().change_scene("res://scenes/mainMenu/MainMenu.tscn")

func _on_RestartButton_pressed():
	get_tree().reload_current_scene()
