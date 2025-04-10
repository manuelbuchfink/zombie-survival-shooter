extends TileMapLayer
var health = 100
@onready var area_2d: Area2D = $Area2D
@onready var wall_health: ProgressBar = $"../UI/wall_health"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	wall_health.value = health
	pass
	
func _on_body_entered(body: Node2D) -> void:
	print(body)
