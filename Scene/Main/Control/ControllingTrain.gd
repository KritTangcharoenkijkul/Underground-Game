extends Node2D

signal start_engine
signal stop_engine
signal open_door
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Start_pressed():
	emit_signal("start_engine")

func _on_Stop_pressed():
	emit_signal("stop_engine")


func _on_OpenDoor_pressed():
	emit_signal("open_door")
