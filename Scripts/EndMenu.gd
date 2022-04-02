extends Node2D

onready var player_stats = get_node("/root/PlayerStats")
onready var end_menu = get_node("/root/EndMenu/CanvasLayer/Panel")

func _on_Play_pressed():
	player_stats.reset()
	end_menu.hide()
	get_tree().reload_current_scene()
