extends Node2D

onready var player_stats = get_node("/root/PlayerStats")


func _process(delta):
	player_stats.reality += delta
	if player_stats.reality > player_stats.MAX_REALITY:
		print('player died from high reality')
		player_stats.dead = true
	else:
		get_node("ColorRect").rect_size.x = float(player_stats.reality)
