extends CharacterBody2D
class_name Zombie

var default_speed = 50
var speed = 50
var alive = true
var health = 100
var damage = 5

var mob_attack_timer: Timer
var collision: CollisionShape2D
var progress_bar: ProgressBar

signal hit

func _physics_process(_delta: float) -> void:
	if alive:
		velocity.x = -speed
	else:
		velocity.x = 0
		collision.set_deferred("disabled", true) # turn collision off when enemy dies
	move_and_slide()


func _on_mob_attack_timer_timeout() -> void:
	hit.emit()
