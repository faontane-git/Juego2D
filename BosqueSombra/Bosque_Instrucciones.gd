extends Node2D


func _ready():
	$sonidos.stream = preload("res://sounds/click.wav") as AudioStream
	$sonidos.play()

func _on_Atras_pressed():
	get_tree().change_scene("res://BosqueSombra/BosqueMenu.tscn")
