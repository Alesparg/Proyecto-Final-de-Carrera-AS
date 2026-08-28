extends GPUParticles2D

func _ready():
	emitting = true
	if has_node("Timer"):
		$Timer.start()


func _on_Timer_timeout():
	queue_free()

