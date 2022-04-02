extends Node

const MAX_HEALTH = 10
const MAX_REALITY = 20
var health
var dead
var reality

func _ready():
	health = MAX_HEALTH
	dead = false
	reality = 0
	
func reset():
	dead = false
	health = MAX_HEALTH
	reality = 0
