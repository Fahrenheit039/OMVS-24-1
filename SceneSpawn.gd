extends Node

var speed = 100 
var rotation_speed = 2 
var player 

func _ready():
	var rand = RandomNumberGenerator.new()
	var enemyscene = load("res://models/enemies/Enemy.tscn")
	
	var screen_size = get_viewport().get_visible_rect().size
	
	for i in range(0,30):
		var enemy = enemyscene.instance()
		rand.randomize()
		var x = rand.randf_range(0, screen_size.x)
		rand.randomize()
		var y = rand.randf_range(0, screen_size.y)
		enemy.position.x = x
		enemy.position.y = y
		add_child(enemy)
	
