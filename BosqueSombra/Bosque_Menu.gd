extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _ready():
	$sonidos.stream = preload("res://sounds/click.wav") as AudioStream
	$sonidos.play()

# Called when the node enters the scene tree for the first time.
func _on_trigger_button_pressed():
	get_tree().change_scene("res://BosqueSombra/BosqueInstrucciones.tscn")


func _on_Jugar_pressed():
	$sonidos.stream = preload("res://sounds/click.wav") as AudioStream
	$sonidos.play()
	get_tree().change_scene("res://BosqueSombra/BosqueJuego.tscn")

func _on_Home_pressed():
	$sonidos.stream = preload("res://sounds/click.wav") as AudioStream
	$sonidos.play()
	get_tree().change_scene("res://hubinicial/Hub/GameHub2D.tscn")

func _on_help_pressed():
	$sonidos.stream = preload("res://sounds/click.wav") as AudioStream
	$sonidos.play()
	get_tree().change_scene("res://BosqueSombra/BosqueInstrucciones.tscn")

func _on_almanque_pressed():
	get_tree().change_scene("res://BosqueSombra/Tutorial.tscn")
