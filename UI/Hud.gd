extends Control


func _ready():
	update_score()
	update_time()
	pass

func update_score():
	$Score.text = "Score: " +str.(Globe.score)
	pass
	
func update_time():
	$Time.text = "Time: " +str.(Globe.time)
