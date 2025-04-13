extends Node2D

@export var zombie_1_scene : PackedScene
@export var zombie_2_scene : PackedScene
@onready var wall: TileMapLayer = $wall
@onready var attacking_zombies = []
@onready var wall_health: ProgressBar = $"UI/wall_health"

func _ready() -> void:
	# create zombie instances with randomized parameters for more variety
	var spawn_timer = Timer.new()
	add_child(spawn_timer)
	spawn_timer.wait_time = 15
	spawn_timer.connect("timeout", Callable(self, "_on_spawn_timeout"))
	
	## create zombie 1 instances
	for i in 5:
		var new_zombie = zombie_1_scene.instantiate()

		var random_height = randi_range(20 ,600)
		var random_distance = randi_range(900 ,1300)
		
		var random_animation_speed = randf_range(0.2, 1.0)
		var random_velocity = random_animation_speed * new_zombie.default_speed
		new_zombie.position = Vector2(random_distance, random_height)
		new_zombie.speed = random_velocity		
		new_zombie.add_to_group("zombies")
		new_zombie.get_node("AnimatedSprite2D").speed_scale = random_animation_speed
		add_child(new_zombie)
		
	# create zombie 2 instances
	for i in 5:
		var new_zombie = zombie_2_scene.instantiate()

		var random_height = randi_range(20 ,600)
		var random_distance = randi_range(900 ,1300)
		
		var random_animation_speed = randf_range(0.7, 1.0)
		var random_velocity = random_animation_speed * new_zombie.default_speed
		
		new_zombie.position = Vector2(random_distance, random_height)
		new_zombie.speed = random_velocity		
		new_zombie.add_to_group("zombies")
		new_zombie.get_node("AnimatedSprite2D").speed_scale = random_animation_speed
		add_child(new_zombie)
	
func _on_spawn_timeout():
	pass
func _on_hit():
	# keep track of the number of currently attacking zombies
	# the Array attacking_zombies contains all currently alive zombies on the wall
	# we remove them from the array once they die so that they do not further  deal damage to the wall
	for i in len(attacking_zombies):
		if not attacking_zombies[i].alive:
			attacking_zombies[i].queue_free() 
			attacking_zombies.remove_at(i)
			break
			
	# deal damage to the wall as lon as its health is above 0
	# once the wall falls, make all alive zombies walk again
	if wall:
		if wall.health > 0:
			for zombie in attacking_zombies:
				var damage = zombie.damage
				wall.health-= damage
				wall_health.value = wall.health
				print(wall.health)
			
		else:
			for zombie in attacking_zombies:
				zombie.get_node("AnimatedSprite2D").play("walk")
				zombie.speed = zombie.default_speed
			wall.queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("zombies"):
		attacking_zombies.append(body)
		body.mob_attack_timer.start()
		body.get_node("AnimatedSprite2D").play("attack")
		body.speed = 0
		body.hit.connect(_on_hit)
		
