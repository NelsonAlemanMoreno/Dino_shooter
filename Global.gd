extends Node


var VP = null

var score = 0
var time = 30
var lives = 3

func _ready():
	randomize()
	pause_mode = Node.PAUSE_MODE_PROCESS
	VP = get_viewport().size
	var _signal = get_tree().get_root().connect("size_changed", self, "_resize")
	reset()

func _physics_process(_delta):
	var Enemy = get_node_or_null("/root/Enemy/Enemy.tscn")
	var Enemy2 = get_node_or_null("/root/Enemy/Enemy2.tscn")
	if Enemy != null: 
		if Enemy2 != null:
			if Enemy.get_child_count() == 0: 
				if Enemy2.get_child_count() == 0:
					print("scene change")
					var _scene = get_tree().change_scene("res://UI/End_game.tscn")


func _unhandled_input(event):
	if event.is_action_pressed("menu"):
		var Pause_menu = get_node_or_null("/root/Game/UI/Pause_menu")
		if Pause_menu == null:
			get_tree().paused = false
		else:
			Pause_menu.show()
			get_tree().paused = true
	pass
	
func update_score(s):
	score += s
	var HUD = get_node_or_null("res://UI/Hud.gd")
	if HUD != null:
		HUD.update_score()

func update_lives():
	lives -= 1
	print("-1 life")
	if lives < 0:
		var _scene = get_tree().change_scene("res://UI/End_game.tscn")
	
	else:
		var HUD = get_node_or_null("/root/Game/UI/HUD")
		if HUD != null:
			HUD.update_lives()
		
func reset():
	score = 0
	time = 30
	lives = 3
