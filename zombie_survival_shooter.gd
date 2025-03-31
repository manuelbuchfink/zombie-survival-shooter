extends Node2D

#var zombie_scene = preload("res://zombie_1.tscn")
@export var zombie_scene : PackedScene
@onready var wall: TileMapLayer = $wall
@onready var attack_timer = Timer.new()
@onready var time = 1.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in 10:
		var new_zombie = zombie_scene.instantiate()
				
		var random_height = randi_range(20 ,600)
		var random_distance = randi_range(900 ,1300)
		var random_velocity = randi_range(30,100)
		
		new_zombie.position = Vector2(random_distance, random_height)
		new_zombie.speed = random_velocity
		
		add_child(new_zombie)
		new_zombie.add_to_group("zombies")
		new_zombie.default_speed  = random_velocity
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("zombies"):
		if wall.health > 0:
			
			attack_timer.set_wait_time(max(0.1, time))
			attack_timer.autostart = true
			time-=0.1
			if attack_timer.timeout:
				attack_timer.start()
				wall.health -= 5
				print(wall.health)
			# stop velocity, switch to attack mode
			body.get_node("AnimatedSprite2D").play("attack")
			body.speed = 0
			
		else:
			body.get_node("AnimatedSprite2D").play("walk")
			body.speed = body.default_speed
	#print(body.is_in_group("zombies"))
	
	pass # Replace with function body.
