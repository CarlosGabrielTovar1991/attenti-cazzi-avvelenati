extends Node2D

var launchCounter = 0

const MIN_LAUNCH_SPEED = 450
const MAX_LAUNCH_SPEED = 750

var launchDickSound = preload("res://sounds/fart.ogg");
var launchCoinSound = preload("res://sounds/harp-glissando-up.ogg");
var launchMoneySound = preload("res://sounds/cash-register-purchase.ogg");

var PoisonedDick = load("res://scenes/dick/dick.tscn")
var MoneyBag = load("res://scenes/moneyBag/moneyBag.tscn")
var Coin = load("res://scenes/coin/coin.tscn")
var SoundPlayer = load("res://scenes/soundPlayer/soundPlayer.tscn")

var random = RandomNumberGenerator.new()

func _ready():
	pass

func proccessNextDifficulty():
	if (launchCounter >= 8 && launchCounter < 20):
		$Timer.wait_time = 4
	elif (launchCounter >= 20 && launchCounter < 35):
		$Timer.wait_time = 2
	elif (launchCounter >= 35 && launchCounter < 45):
		$Timer.wait_time = 1
	elif (launchCounter > 45):
		$Timer.wait_time = 0.5
	

func launchItem():
	random.randomize()
	var randomIndex = random.randi_range(1, 3)
	var nextItem
	var nextSound = SoundPlayer.instance()
	match randomIndex:
		1:
			nextItem = MoneyBag.instance()
			nextSound.stream = launchMoneySound
		2:
			nextItem = Coin.instance()
			nextSound.stream = launchCoinSound
		3:
			nextItem = PoisonedDick.instance()
			nextSound.stream = launchDickSound
	get_parent().add_child(nextSound)
	nextSound.play()
	$LaunchAnimation.play("Launch");
	nextItem.position = $Polygons/LaunchArm/LaunchSpawn.get_global_transform().get_origin()
	nextItem.z_index = -1
	var rotation = deg2rad(-60)
	random.randomize()
	var launchSpeed = random.randi_range(MIN_LAUNCH_SPEED, MAX_LAUNCH_SPEED)
	var launchDirection = Vector2(-cos(rotation), sin(rotation))
	nextItem.linear_velocity = launchDirection * launchSpeed
	get_parent().add_child(nextItem)
	launchCounter += 1
	proccessNextDifficulty()

func _on_Timer_timeout():
	launchItem()
	
