extends KinematicBody2D

var max_speed = 400
var speed = 0
var acceleration = 1000

var move_direction = Vector2(0,0)
var anim_direction = "S"
var anim_mode = "Idle"
var animation = "Idle_S"

onready var _animated_sprite = $AnimatedSprite

var spell = preload("res://Scenes/Spell.tscn")
var can_fire = true
var rate_of_fire = 0.4
var shooting = false
var fire_direction

func _physics_process(delta):
	MovementLoop(delta)

func _process(_delta):
	AnimationLoop()
	SkillLoop()


func SkillLoop():
	if Input.is_action_pressed("Shoot") and can_fire == true:
		can_fire = false
		shooting = true
		get_node("TurnAxis").rotation = get_angle_to(get_global_mouse_position())
		var spell_instance = spell.instance()
		spell_instance.position = get_node("TurnAxis/CastPoint").get_global_position()
		spell_instance.rotation = get_angle_to(get_global_mouse_position())
		fire_direction = (get_angle_to(get_global_mouse_position())/3.14)*180
		get_parent().add_child(spell_instance)
		yield(get_tree().create_timer(rate_of_fire), "timeout")
		can_fire = true
		shooting = false


func MovementLoop(delta):
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var up = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")
	
	move_direction.x = -int(left) + int(right)
	move_direction.y = (-int(up) + int(down)) / float(2)
	
	var motion = move_direction.normalized() * max_speed # speed
	move_and_slide(motion, Vector2(0, 0))


func AnimationLoop():
	if shooting == true:
		anim_mode = "Shoot"
	else:
		match move_direction:
			Vector2(-1,0):
				anim_direction = "W"
			Vector2(1,0):
				anim_direction = "E"
			Vector2(0,0.5):
				anim_direction = "S"
			Vector2(0,-0.5):
				anim_direction = "N"
			Vector2(-1,-0.5):
				anim_direction = "NW"
			Vector2(-1,0.5):
				anim_direction = "SW"
			Vector2(1,-0.5):
				anim_direction = "NE"
			Vector2(1,0.5):
				anim_direction = "SE"
		
	if move_direction != Vector2(0,0):
		anim_mode = "Walk"
	else:
		anim_mode = "Idle"
	
	animation = anim_mode + "_" + anim_direction
	get_node("AnimatedSprite").play(animation)
