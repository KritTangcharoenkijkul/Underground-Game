extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var removecrowdnode = get_tree().get_root().find_node("Train",true, false)
	removecrowdnode.connect("remove_crowd",self,"crowdgone")
	var removecrowdsafenode = get_tree().get_root().find_node("Train",true, false)
	removecrowdsafenode.connect("remove_crowd_safe",self,"crowdsafegone")
	

func crowdgone():
	$Crowd.queue_free()
	
func crowdsafegone():
	$CrowdSafe.queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
