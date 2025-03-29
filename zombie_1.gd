extends CharacterBody2D

var speed = 50
var alive = true
var health = 100
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var progress_bar: ProgressBar = $ProgressBar

func _ready():
	progress_bar.visible = false
	progress_bar.value = health	
	pass
	
func _physics_process(delta: float) -> void:
	if alive:		
		velocity.x = -speed
	else:
		velocity.x = 0
		collision.set_deferred("disabled", true) # turn collision off when enemy dies
	move_and_slide()
