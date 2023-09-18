extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Resumir_pressed():
	var menu = get_node("../PausaMenu")
	menu.visible = false
	var juego = get_tree()
	juego.paused = false


func _on_Salir_pressed():
	var juego = get_tree()
	juego.paused = false
	get_tree().change_scene("res://juego_Botanica/HUDs/BotanicaTitle.tscn")
