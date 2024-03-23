extends RigidBody2D

func _ready():$AnimatedSprite.playing = true
	#var mob_types = $AnimatedSprite.frames.get_animation_names()
	#print(mob_types)
	#$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	#$AnimatedSprite.animation = mob_types[0]

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
