extends CharacterBody2D
var default_speed = 50
var speed = 50
var alive = true
var health = 100

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var progress_bar: ProgressBar = $ProgressBar


signal zombie_collider
func _ready():
	progress_bar.visible = false
	progress_bar.value = health
	zombie_collider.emit()
	
	pass

	
func _physics_process(delta: float) -> void:
	if alive:
		velocity.x = -speed
	else:
		velocity.x = 0
		collision.set_deferred("disabled", true) # turn collision off when enemy dies
	move_and_slide()
