extends Control


onready var botanicaPausado = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass




func _on_Pausa_pressed():
	var menu = get_node("../PausaMenu")
	menu.visible = true
	botanicaPausado = true
	var juego = get_tree()
	juego.paused = true


func _on_Ayuda_pressed():
	get_tree().change_scene("res://juego_Botanica/HUDs/Instrucciones.tscn")
