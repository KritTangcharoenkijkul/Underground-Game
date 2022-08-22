extends KinematicBody2D


signal change_map_position
signal remove_crowd
signal remove_crowd_safe

var played = 1
var stage = 1
var positioning = Vector2()
var isdooropen = false
var iscrowdgone = false
var iscrowd2gone = false
var isbombing = false
var iscrowdbeingplayed = true
var isplaywinsound = false

# Called when the node enters the scene tree for the first time.
export (int) var speed = 1200

var velocity = Vector2()
var ismoving = false
func _ready():
	var startnode = get_tree().get_root().find_node("Button",true, false)
	startnode.connect("start_engine",self,"start_the_train")
	var stopnode = get_tree().get_root().find_node("Button",true, false)
	stopnode.connect("stop_engine",self,"stop_the_train")
	var doornode = get_tree().get_root().find_node("Button",true, false)
	doornode.connect("open_door",self,"open_the_train_door")
	
	if Global.time_played % 2 == 0:
		$AnimationPlayer.play("Default")
	else:
		$AnimationPlayer.play("SecondDefault")

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	velocity = Vector2()
	velocity = velocity.normalized() * speed
	var positioning = get_global_position()
	
	if (played == 1 and positioning.x > 7500 and positioning.x < 7525) or (played == 2 and positioning.x > 22500 and positioning.x < 22525) or (played == 3 and positioning.x > 37500 and positioning.x < 37525):
		played += 1
		playjingle()
	
	if positioning.x > 600 and stage == 1:
		emit_signal("change_map_position")
		stage = 2
		stopcrowd()
	elif positioning.x > 15200 and stage == 2:
		emit_signal("change_map_position")
		stage = 3
		$Crowder.play()
		
	elif positioning.x > 16204 and stage == 3:
		emit_signal("change_map_position")
		stage = 4
		stopcrowd()
	elif positioning.x > 30500 and stage == 4:
		emit_signal("change_map_position")
		stage = 5
		$Crowder.play()
	elif positioning.x > 32000 and stage == 5:
		emit_signal("change_map_position")
		stage = 6
		stopcrowd()
	elif positioning.x > 44000 and stage == 6:
		emit_signal("change_map_position")
		stage = 7
	else:
		pass
	
	if ismoving:
		
		if positioning.x < 46350:
			velocity.x += 1  #38000 38500
			if positioning.x > 38000 and positioning.x < 39080:
				velocity.y -= 1
			velocity = velocity.normalized() * speed
			velocity = move_and_slide(velocity)
		else:
			$TrainRunning.stop()
			if iscrowdgone == true and iscrowd2gone == false:
				
				if isplaywinsound == false:
					playwinsound()
					isplaywinsound = true
					
				if positioning.y < -648 and positioning.y > -1248:
					velocity.y -= 1
				else:
					velocity.y = 0
					emit_signal("change_map_position")
					yield(get_tree().create_timer(6.0), "timeout")
					Global.time_played += 1
					stopwinsound()
					get_tree().change_scene("res://Scene/Menu/Menu.tscn")
						
						
				velocity = velocity.normalized() * speed
				velocity = move_and_slide(velocity)
			else:
				if isbombing == false:
					isbombing = true
					bombing()
				$Fireball.visible = true
				yield(get_tree().create_timer(2.0), "timeout")
				Global.time_played += 1
				get_tree().change_scene("res://Scene/Menu/Menu.tscn")

	else:
		velocity = move_and_slide(velocity)
		
func playwinsound():
	$WinSound.play()
	
func stopwinsound():
	$WinSound.stop()
	
func playjingle():
	$Jingle.play()

func playcrowd():
	$Crowder.play()
func stopcrowd():
	$Crowder.stop()
func bombing():
	$Booming2.play()
func start_the_train():
	ismoving = true
	$TrainRunning.play()
	var positioning = get_global_position()
	print(positioning)

func stop_the_train():
	ismoving = false
	print("stop")
	var positioning = get_global_position()
	$TrainRunning.stop()
	$Brake.play()
	

func open_the_train_door():
	
	if isdooropen == true:
		if Global.time_played % 2 == 0:
			$AnimationPlayer.play("Default")
		else:
			$AnimationPlayer.play("SecondDefault")
		isdooropen = false
		$DoorOpen.play()
	else:
		if ismoving == false:
			$DoorClosed.play()
			if iscrowdgone == false:
				if iscrowd2gone:
					if Global.time_played % 2 == 0:
						$AnimationPlayer.play("Crowd_Type0")
					else:
						$AnimationPlayer.play("SecondCrowd0")
				else:
					if Global.time_played % 2 == 0:
						$AnimationPlayer.play("DoorOpen")
					else:
						$AnimationPlayer.play("SecondDoorOpen")
			
			else:
				if iscrowd2gone:
					if Global.time_played % 2 == 0:
						$AnimationPlayer.play("Crowd_Type0")
					else:
						$AnimationPlayer.play("SecondCrowd0")
				else:
					if Global.time_played % 2 == 0:
						$AnimationPlayer.play("Crowd_Type1")
					else:
						$AnimationPlayer.play("SecondCrowd1")
			isdooropen = true
	
	if isdooropen == true and ismoving == false and iscrowdgone == false:
		var positioning = get_global_position()
		if positioning.x > 15004 and positioning.x < 17004:
			emit_signal("remove_crowd")
			if Global.time_played % 2 == 0:
				$AnimationPlayer.play("Crowd_Type1")
			else:
				$AnimationPlayer.play("SecondCrowd1")
			iscrowdgone = true
	
	
	elif isdooropen == true and ismoving == false and iscrowd2gone == false:
		var positioning = get_global_position()
		if positioning.x > 30504 and positioning.x < 33004:
			emit_signal("remove_crowd_safe")
			if Global.time_played % 2 == 0:
				$AnimationPlayer.play("Crowd_Type0")
			else:
				$AnimationPlayer.play("SecondCrowd1")
			iscrowd2gone = true
	else:
		pass
		
	if isdooropen == true and ismoving == false and iscrowd2gone == false:
		var positioning = get_global_position()
		if positioning.x > 30504 and positioning.x < 33004:
			emit_signal("remove_crowd_safe")
			$AnimationPlayer.play("Crowd_Type0")
			iscrowd2gone = true
