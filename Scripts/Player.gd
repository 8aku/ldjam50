extends KinematicBody2D

const FLOOR_UP = Vector2(0, -1)

const LEFT = 0
const RIGHT = 1

const GRAVITY = 350
const AIR_RESIST = 300
const MAX_VELOCITY = Vector2(80, 210)
const JUMP_PERIOD = 0.1
const MAX_FALL = 15
const FRICTION = 200

var velocity = Vector2(0, 0)
var run_accel = FRICTION + 500
var jump_accel = 200
var last_direction = LEFT
var jump_timer = 0
var fall_timer = 0
var canInteract
var target

onready var player_stats = get_node("/root/PlayerStats")
onready var end_menu = get_node("/root/EndMenu/CanvasLayer/Panel")

func _ready():
	$AnimatedSprite.play("default")
	last_direction = RIGHT


func _bound_vars():
	velocity.x = min(velocity.x, MAX_VELOCITY.x)
	velocity.x = max(velocity.x, -MAX_VELOCITY.x)
	velocity.y = min(velocity.y, MAX_VELOCITY.y)
	velocity.y = max(velocity.y, -MAX_VELOCITY.y)
	

func _set_animation():
	$AnimatedSprite.flip_h = last_direction == LEFT

func _process_input(delta):
	if Input.is_action_just_pressed("ui_left"):
		print('left')
		last_direction = LEFT
	if Input.is_action_just_pressed("ui_right"):
		last_direction = RIGHT
	if Input.is_action_just_released("ui_left") and Input.is_action_pressed("ui_right"):
		last_direction = RIGHT
	if Input.is_action_just_released("ui_right") and Input.is_action_pressed("ui_left"):
		last_direction = LEFT
	
	if !player_stats.dead:
		if last_direction == LEFT and Input.is_action_pressed("ui_left"):
			velocity.x -= run_accel
#			$AnimatedSprite.play("walk")
		elif last_direction == RIGHT and Input.is_action_pressed("ui_right"):
			velocity.x += run_accel
#			$AnimatedSprite.play("walk")
#		else:
			$AnimatedSprite.play("default")
		
		if Input.is_action_just_pressed("jump") and jump_timer > 0:
			velocity.y = min(0, velocity.y)
			velocity.y -= jump_accel
			jump_timer = 0
		
		if Input.is_action_just_pressed("take_pill"):
			player_stats.reality = 0
			player_stats.health -=1
	
#	if dead:
#		$AnimatedSprite.play('dead')
	
	
func _process_environment(delta):
	var gravity_factor = 1.0
	
	if !player_stats.dead and Input.is_action_pressed("jump"):
#		$AnimatedSprite.play("jump")
		gravity_factor = 0.7
			
	velocity.y += GRAVITY * delta * gravity_factor
	
	if velocity.x > 0:
		if is_on_floor():
			velocity.x = max(0, velocity.x - FRICTION * delta)
		else:
			velocity.x = max(0, velocity.x - AIR_RESIST * delta)
	elif velocity.x < 0:
		if is_on_floor():
			velocity.x = min(0, velocity.x + FRICTION * delta)
		else:
			velocity.x = min(0, velocity.x + AIR_RESIST * delta)
		
	if is_on_floor():
		jump_timer = JUMP_PERIOD
		fall_timer = 0
		if velocity.y > 0:
			velocity.y = 0;
	elif velocity.y > 0:
		fall_timer += delta
	if is_on_ceiling() and velocity.y < 0:
		velocity.y = 0
		
	if (player_stats.health == 0):
		print('player died from low health')
		die()
		
	if (player_stats.reality > player_stats.MAX_REALITY):
		print('player died from high reality')
		die()
	
func _process_movement(delta):
	var movement = velocity
	move_and_slide(movement, FLOOR_UP)
	

func _update_timers(delta):
	jump_timer -= delta
	fall_timer += delta
	
	if fall_timer >= MAX_FALL:
		#player is dead
		get_tree().reload_current_scene()
	
	
func _process(delta):
	_update_timers(delta)
	_process_input(delta)
	_process_environment(delta)
	_bound_vars()
	_process_movement(delta)
	_set_animation()
	
func die():
	print('player is dead!')
	player_stats.dead = true
	player_stats.reset()
	end_menu.show()
