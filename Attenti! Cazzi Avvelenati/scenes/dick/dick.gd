extends RigidBody2D

var FloatinTextScene = load("res://scenes/floatingText/FloatingText.tscn");

var velocity = Vector2()

func killMe():
	queue_free()

func prepareToDie():
	set_deferred("mode", MODE_KINEMATIC)
	self.sleeping = true
	self.set_collision_layer_bit(0, false)
	self.set_collision_mask_bit(0, false)
	self.set_collision_layer_bit(10, true)
	self.set_collision_mask_bit(10, true)
	$CollisionShape2D/Particles2D.emitting = false
	$DeathTimer.start()

func _on_DeathTimer_timeout():
	killMe()

func _on_Dick_body_entered(body):
	var collisionName = body.get_name()
	var textInstance = FloatinTextScene.instance()
	textInstance.position = self.get_global_transform().get_origin()
	if (collisionName == "AreaFloor"):
		textInstance.content = "miss"
		$AnimationPlayer.play("FadeOut")
		get_parent().add_child(textInstance)
		GlobalSignals.emit_signal("dick_missed")
		prepareToDie()
	elif (collisionName == "Bucket"):
		MusicPlayer.playGameOverMusic()
		prepareToDie()
		GlobalSignals.emit_signal("dick_picked")
