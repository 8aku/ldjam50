extends Node2D

onready var player = get_parent().get_node("Player")
onready var player_stats = get_node("/root/PlayerStats")

func eat_food():
	print('ate foods!')
	player_stats.health += 1
	print(player_stats.health)

func _on_Area2D_body_entered(body):
	if (body.get_name() == 'Player'):
		if (player_stats.health < player_stats.MAX_HEALTH):
			eat_food()
			queue_free()
