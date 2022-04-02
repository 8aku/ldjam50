extends Node2D

onready var player_stats = get_node("/root/PlayerStats")
var MAX_WIDTH = 10


func _process(delta):
	player_stats.reality += delta
	if player_stats.reality > MAX_WIDTH:
		print('you died')
		player_stats.dead = true
		player_stats.reality = 0
	else:
		get_node("ColorRect").rect_size.x = float(player_stats.reality)
