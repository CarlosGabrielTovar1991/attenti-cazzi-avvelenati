extends Node2D

func _ready():
	get_tree().paused = false
	MusicPlayer.playMenuMusic()

func _on_ExitButton_pressed():
	get_tree().quit()

func _on_StartButton_pressed():
	get_tree().change_scene("res://scenes/game/game.tscn")


func _on_InstructionsButton_pressed():
	get_tree().change_scene("res://scenes/mainMenu/instructions.tscn")
