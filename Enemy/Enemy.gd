extends KinematicBody2D

var inittial_position = Vector2.ZERO
var direction = Vector2(1.5, 0)

var health = 1

var Effects
onready var Explosion = load("res://Effects/Explosion.tscn")



func _ready():
	pass
func _physics_process(_delta):
	position -= direction
	if position.x > 1010:
		position -= direction
		$Sprite.flip_h = false
	if position.x <= 10:
		position.x = 50
		position += direction
		$Sprite.flip_h = true
		print("flip")


func damage(d):
	health -= d
	if health <= 0:
		Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var explosion = Explosion.instance()
			Effects.add_child(explosion)
			explosion.global_position = global_position
		print("enemy_tpyteradacdal is dead")
		queue_free()

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		body.damage(100)
		damage(100)
