extends KinematicBody2D

var speed = 100 
var rotation_speed = 2 
var player 

func _ready(): 
	player = get_node("/root/Map/YSort/Player_KinematicBody2D") 

func _physics_process(delta): 
	var direction = (player.position - position).normalized() 
	var angle = direction.angle() 
	rotation = lerp(rotation, angle, rotation_speed * delta) 
	move_and_slide(direction * speed) 
