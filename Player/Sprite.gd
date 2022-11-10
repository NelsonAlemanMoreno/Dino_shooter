extends Sprite


const SPRITES_MAP = {
	Vector2.RIGHT: preload("res://assets/dino_sider.png"),
	Vector2.LEFT: preload("res://assets/dino_sidel.png"),
	Vector2.DOWN: preload("res://assets/dino_front.png"),
	Vector2.UP: preload("res://assets/dino_back.png"),
	Vector2(1.0, 1.0): preload("res://assets/dino_sider.png"),
	Vector2(1.0,-1.0): preload("res://assets/dino_sider.png"),
	Vector2(-1.0, -1.0): preload("res://assets/dino_sidel.png"),
	Vector2(-1.0, 1.0): preload("res://assets/dino_sidel.png"),
}

var look_direction = Vector2.DOWN

func _process(_delta: float) -> void:
	var input_vector = Vector2(
		float(Input.is_action_pressed("ui_right")) - float(Input.is_action_pressed("ui_left")),
		float(Input.is_action_pressed("ui_down")) - float(Input.is_action_pressed("ui_up"))
	)
	
	if input_vector.length() > 0.0 and input_vector != look_direction:
		texture = SPRITES_MAP[input_vector]
		look_direction = input_vector
