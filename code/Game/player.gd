extends KinematicBody2D

var vel = Vector2()

func _ready():
	pass

func _physics_process(delta):
	
	movement_loop()
	vel = move_and_slide(vel, Vector2(0, -1))
	

func movement_loop():
	
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var up = Input.is_action_pressed("up")
	var down = Input.is_action_pressed("down")
	var rotate_left = Input.is_action_pressed("rotate_left")
	var rotate_right = Input.is_action_pressed("rotate_right")
	
	var dirx = int(right) - int(left)
	var diry = int(down) - int(up)
	var dir_rotate = int(rotate_right) - int(rotate_left)
	
	if dirx == -1 :
		vel.x = max(vel.x - 1000, -10000)
	elif dirx == 1 :
		vel.x = min(vel.x + 1000, 10000)
	else:
		vel.x = lerp(vel.x, 0, 1)
	
	if diry == -1 :
		vel.y = max(vel.y - 1000, -10000)
	elif diry == 1 :
		vel.y = min(vel.y + 1000, 10000)
	else:
		vel.y = lerp(vel.y, 0, 1)
	
	if dir_rotate == -1:
		pass
	elif dir_rotate == 1:
		pass