extends Node2D

var pos1 : Vector2
var pos2 : Vector2

var angle1 : float
var angle2 : float

var end_pos : Vector2

@onready var x1_input: TextEdit = %x1
@onready var z1_input: TextEdit = %z1
@onready var a1_input: TextEdit = %angle1

@onready var x2_input: TextEdit = %x2
@onready var z2_input: TextEdit = %z2
@onready var a2_input: TextEdit = %angle2

func _ready():
	for container in [%HBoxContainer,%HBoxContainer2]:
		for text_edit in container.get_children():
			if text_edit is TextEdit:
				text_edit.size_flags_vertical = Control.SIZE_SHRINK_CENTER
				text_edit.custom_minimum_size = Vector2(100,50)
	pass
	
func _process(delta):
	if end_pos:
		%Label.text = "x: " + str(int(end_pos.x)) +"  z: "+ str(int(end_pos.y))

func triangulate():
	var x1 = float(x1_input.text)
	var z1 = float(z1_input.text)
	var a1 = float(a1_input.text)
	var x2 = float(x2_input.text)
	var z2 = float(z2_input.text)
	var a2 = float(a2_input.text)
	
	prints("a1:", a1, "a2:", a2)
	print(deg_to_rad(180))
	
	pos1 = Vector2(x1, z1)
	pos2 = Vector2(x2, z2)
	var v1 = pos2 - pos1
	
	prints("v1:", v1)
	
	var th1 = deg_to_rad(a1)
	var th2 = deg_to_rad(a2)
	var th3 = v1.angle_to(Vector2(0,1))
	
	prints("th1:", th1, "th2:", th2, "th3:", th3)
	
	var alpha = deg_to_rad(180) - th3 - th2
	var beta =  th2 - th1
	var l1 = v1.length()
	
	prints("alpha:", alpha, "beta:", beta, "l1:", l1)
	
	var l2 = l1 * (sin(alpha)/sin(beta))
	var v2 = Vector2(0,l2).rotated(th1)
	end_pos = pos1 + v2
	prints("l2:", l2, "v2:", v2, "end_pos:", end_pos)
	
	return end_pos

func _on_button_button_down():
	print(triangulate())
