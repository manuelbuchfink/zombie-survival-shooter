extends CharacterBody2D

@export var Shot : PackedScene
@onready var muzzle: Marker2D = $Muzzle  
@onready var ammo: Sprite2D = $"../UI/ammo"

const MAX_MAG_SIZE = 4
const SPEED = 200.0

var mag_size = MAX_MAG_SIZE
var is_reloading = false
#signal timeout

func shoot() -> void:  
	# instance new bullet if we have ammo
	# spawn bullet instance at muzzle location
	# decrement mag size and change mag frame to coresponding amount of bullets
	if mag_size > 0:
		var bullet_scene = preload("res://shot.tscn").instantiate()	
		var level_root = get_tree().get_root() # access root
		
		level_root.add_child(bullet_scene) # add child to root
		bullet_scene.transform = muzzle.global_transform # assign muzzle pos to new bullet
		
		mag_size-=1
		if mag_size > 0:			
			ammo.frame = mag_size-1
		else:
			ammo.frame = 5
			
func reload() -> void:
	# reload bullets into the magazine	
	# reload speed is determined by reload_timers wait time
	# reload is executed when timer is timeout
	var reload_timer = Timer.new()
	add_child(reload_timer)
	reload_timer.wait_time = 0.5
	reload_timer.one_shot = true	
	reload_timer.connect("timeout", Callable(self,  "_on_timer_timeout"))
	reload_timer.start()
	is_reloading = true
		

func _on_timer_timeout() -> void:
	# cap to MAX_MAG_SIZE
	mag_size = clamp(mag_size+1, 0, MAX_MAG_SIZE)
	ammo.frame = mag_size-1
	
	# reload until fully reloaded
	if mag_size < MAX_MAG_SIZE:
		reload()
	else:
		is_reloading = false
		
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		if not is_reloading:
			shoot()
		
	if Input.is_action_just_pressed("reload"):
		reload()
		
	var direction := Input.get_axis("move_down", "move_up")
	
	if direction:
		velocity.y = -direction * SPEED
		$AnimatedSprite2D.play("move")
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		$AnimatedSprite2D.play("idle")
	
	move_and_slide()
	
