extends Area2D

@export var speed = 3500

func _physics_process(delta):
	position += transform.x * speed * delta



func _on_body_entered(body: Node2D) -> void:
	print(body)
	if body.alive:
		body.get_node("AnimatedSprite2D").play("die")
		body.alive = false
		queue_free()
	else:
		pass
	 
	
