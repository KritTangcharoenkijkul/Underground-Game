extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _process(delta):
	global_position.x = sin(OS.get_ticks_msec())*64

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
