extends KinematicBody2D

onready var sprite = get_node("Sprite")

var velocity = Vector2.ZERO
var speed = 250
var damage = 1

onready var Explosion = load("res://Effects/Explosion.tscn")
var Effects = null

func _ready():

	velocity = Vector2(speed, 0)
func _physics_process(_delta):
	velocity = move_and_slide(velocity, Vector2.ZERO)
	position.x = wrapf(position.x, 0, 1024)
	position.y = wrapf(position.y, 0, 600)

func _on_Area2D_body_entered(body):
	if body.has_method("damage"):
		body.damage(damage)
	Effects = get_node_or_null("/root/Game/Effects")
	if Effects != null:
		var explosion = Explosion.instance()
		Effects.add_child(explosion)
		explosion.global_position = global_position
	print("dead fireball")
	queue_free()

func _on_Timer_timeout():
	queue_free()



