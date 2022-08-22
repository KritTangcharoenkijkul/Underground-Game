extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var stage = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Second")	
	
	var changestationnode = get_tree().get_root().find_node("Train",true, false)
	changestationnode.connect("change_map_position",self,"changemap")

func changemap():
	if stage ==2:
		$AnimationPlayer.play("Third")	
		stage += 1
	elif stage == 3:
		$AnimationPlayer.play("Fourth")	
		stage += 1
	elif stage == 4:
		$AnimationPlayer.play("Fifth")	
		stage += 1
	elif stage == 5:
		$AnimationPlayer.play("Sixth")	
		stage += 1
	elif stage == 6:
		$AnimationPlayer.play("Seventh")	
		stage += 1
	elif stage == 7:
		$AnimationPlayer.play("Eight")	
		stage += 1
	elif stage == 8:
		$Sprite.visible = false	
	else:
		$AnimationPlayer.play("Eight")	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
