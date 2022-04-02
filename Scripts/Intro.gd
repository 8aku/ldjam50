extends Node2D


var label_text = ['oh.. h-hey there...i know, things have been a little rough lately. I think we call this a rough patch.',
'A little rough patch. A teeny, tiny little rough patch.',
'I know it feels like it has been forever since you, um... did much of anything.',
'I can - apparently - help you out of your slump...',
'Press X to (maybe?) alleviate some of that crushing anxiety and depression.',
'Unfortunately this action may cause your health to be compromised.',
'I know, kinda bullshit.',
'You can try eating some healthy-ish food to manage your health.',
'...You do not have a lot of food - because you are too anxious to leave the house.',
'Damn, this really is the time to start taking care of yourself.',
'Just remember - if things get TOO REAL TO DEAL, POP A PILL AND HEAL...ish!',
'*** Press X to take your medication, press SPACE to jump. ***',
'Ready to play? Go for it champ!']

var label_next = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	get_node("Panel/TextureRect/Label").text = label_text[label_next]

func _on_TextureButton_pressed():
	if (label_next >= label_text.size() -1):
		label_next = -1
	else:
		label_next +=1;
		get_node("Panel/TextureRect/Label").text = label_text[label_next]


func _on_PlayButton_pressed():
	hide()
	get_tree().paused = false
