extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("BackSound").play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Jugar_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.4),"timeout")
	get_tree().change_scene("res://juego_Botanica/Botanica.tscn")
	
	


func _on_Instrucciones_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.4),"timeout")
	get_tree().change_scene("res://juego_Botanica/HUDs/Instrucciones.tscn")


func _on_Back_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.4),"timeout")
	get_tree().change_scene("res://hubinicial/Hub/GameHub2D.tscn")
