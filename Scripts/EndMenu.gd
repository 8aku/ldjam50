extends Node2D

onready var player_stats = get_node("/root/PlayerStats")
onready var end_menu = get_node("/root/EndMenu/CanvasLayer/Panel")
var label_next = 0
var label_text = ['Yikes. You died. Did you take your meds? Did you eat food?',
'Oh - you did? And you still died? I guess shit got TOO REAL TO DEAL.',
'I guess that is... inevitable. Tehe.']

func _ready():
	get_tree().paused = true
	get_node("CanvasLayer/Panel/Label").text = label_text[label_next]

func _on_Play_pressed():
	player_stats.reset()
	end_menu.hide()
	get_tree().reload_current_scene()

func _on_TextureButton_pressed():
	print('ok')
	if (label_next >= label_text.size() -1):
		label_next = -1
	else:
		label_next +=1;
		get_node("CanvasLayer/Panel/Label").text = label_text[label_next]
