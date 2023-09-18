extends Node2D

var current_round = 0
var animal_sounds := []
var animal_names

func _ready():
	$sonidos.stream = preload("res://sounds/click.wav") as AudioStream
	$sonidos.play()
	animal_sounds = [preload("res://sounds/ardilla.wav") as AudioStream,
					 preload("res://sounds/mariposa.wav") as AudioStream,
					 preload("res://sounds/pajaro.wav") as AudioStream,
					 preload("res://sounds/mono.wav") as AudioStream,
					 preload("res://sounds/iguana.wav") as AudioStream,
					 preload("res://sounds/oso peresozo.wav") as AudioStream,
					 preload("res://sounds/anhinga.wav") as AudioStream,
					 preload("res://sounds/tigrillo.wav") as AudioStream,
					 preload("res://sounds/zorra.wav") as AudioStream,
					 preload("res://sounds/garza.wav") as AudioStream,
					 preload("res://sounds/venado.wav") as AudioStream,
					 preload("res://sounds/rata.wav") as AudioStream,
					 preload("res://sounds/bolsero.wav") as AudioStream,
					 preload("res://sounds/hormiguero.wav") as AudioStream,
					 preload("res://sounds/loro.wav") as AudioStream]

	animal_names = ["ardilla", "mariposa", "pajaro","mono", "iguana", "oso peresozo", "anhinga", "tigrillo","zorra", "garza","venado","rata","bolsero", "hormiguero", "loro"]
	
	$titulo.text = animal_names[current_round].to_upper()
	#Setteo tamano e imagen
	var img = $imagena
	img.scale = Vector2(0.25, 0.25)
	img.texture = load("res://assets/"+animal_names[0]+".png")
	
func _on_izq_pressed():
	
	$sonidos.stream = preload("res://sounds/click.wav") as AudioStream
	$sonidos.play()
	
	if current_round == 0:
		current_round = 14
	else:
		current_round -= 1
		
	#Setteo texto de imagen
	$titulo.text = animal_names[current_round].to_upper()
	#Setteo tamano e imagen
	var img = $imagena
	img.scale = Vector2(0.25, 0.25)
	img.texture = load("res://assets/"+animal_names[current_round]+".png")
	
func _on_der_pressed():
	$sonidos.stream = preload("res://sounds/click.wav") as AudioStream
	$sonidos.play()
	
	if current_round == 14:
		current_round = 0
	else:
		current_round += 1
		
	#Setteo texto de imagen
	$titulo.text = animal_names[current_round].to_upper()
	#Setteo tamano e imagen
	var img = $imagena
	img.scale = Vector2(0.25, 0.25)
	img.texture = load("res://assets/"+animal_names[current_round]+".png")

func _on_salir_pressed():
	get_tree().change_scene("res://BosqueSombra/BosqueMenu.tscn")

func _on_sonido_pressed():
	
	$sonidos.stream = animal_sounds[current_round]
	$sonidos.play()
