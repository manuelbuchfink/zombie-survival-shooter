extends Zombie


func _ready():
	mob_attack_timer = $mob_attack_timer
	collision = $CollisionShape2D
	progress_bar = $ProgressBar
	
	progress_bar.visible = false
	progress_bar.value = health
	

	
	
