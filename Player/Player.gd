extends KinematicBody2D

onready var sprite = get_node("Sprite")
var fireball = load("res://Player/Fireball.tscn")
onready var speed = 400
var velocity = Vector2.ZERO
var health = 5

var Effects = null
onready var Explosion = load("res://Effects/Explosion.tscn")


#Player movement
func _physics_process(_delta):
	get_input()
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		
	velocity = velocity.normalized()
	move_and_slide(velocity * speed)

	position.x = wrapf(position.x, 0, 1024)
	position.y = wrapf(position.y, 0, 600)

func get_input():
	if Input.is_action_just_pressed("shoot"):
		var Effects = get_node_or_null("/root/Game/Effects")
		var bullet = fireball.instance()
		if Effects != null:
			if sprite.look_direction == Vector2.RIGHT:
				print("shooting")
				bullet.global_position = global_position + Vector2(0, 0)
				Effects.add_child(bullet)
			if sprite.look_direction == Vector2.LEFT:
				bullet.global_position = global_position + Vector2(-50, 0)
				bullet.rotation = PI
				Effects.add_child(bullet)
			if sprite.look_direction == Vector2.UP:
				bullet.global_position = global_position + Vector2(0, -150)
				bullet.rotation_degrees = 270
				Effects.add_child(bullet)
			if sprite.look_direction == Vector2.DOWN:
				bullet.global_position = global_position + Vector2(0, 100)
				bullet.rotation_degrees = 90
				Effects.add_child(bullet)
				velocity = Vector2(0, speed)
func damage(d):
	health -= d
	if health <= 0:
		Effects = get_node_or_null("/root/Game/Effects")
		var explosion = Explosion.instance()
		Effects.add_child(explosion)
		explosion.global_position = global_position
		hide()
		yield(explosion, "animation_finished")
		queue_free()
	

func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name != "Player":
		damage(100)
