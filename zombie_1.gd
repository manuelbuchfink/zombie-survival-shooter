extends CharacterBody2D

var speed = 50
var alive = true
@onready var collision: CollisionShape2D = $CollisionShape2D

func _ready():
	pass
	
func _physics_process(delta: float) -> void:
	if alive:		
		velocity.x = -speed
	else:
		velocity.x = 0
		collision.set_deferred("disabled", true) # turn collision off when enemy dies
	move_and_slide()
