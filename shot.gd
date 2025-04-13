extends Area2D

@export var speed = 2000

func _physics_process(delta):
	position += transform.x * speed * delta


func _on_body_entered(body: Node2D) -> void:	
	queue_free()
	body.progress_bar.value = body.health
	if body.alive:
		body.progress_bar.visible = true
		if body.health > 0:
			body.health -= 25
			
		else:
			body.progress_bar.visible = false
			body.get_node("AnimatedSprite2D").play("die")
			body.alive = false
			
	else:
		pass
	 
	
