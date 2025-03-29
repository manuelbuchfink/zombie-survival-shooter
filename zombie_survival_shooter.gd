extends Node2D

#var zombie_scene = preload("res://zombie_1.tscn")
@export var zombie_scene : PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in 10:
		var new_zombie = zombie_scene.instantiate()
	
		
		var random_height = randf_range(5 ,630)
		var random_distance = randf_range(900 ,1300)
		new_zombie.position = Vector2(random_distance, random_height)
		
		add_child(new_zombie)
	
	
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
