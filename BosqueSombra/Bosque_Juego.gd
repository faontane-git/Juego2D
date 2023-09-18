extends Node2D

var animal_names
var animal_sounds := [] # Almacena los sonidos de los animales en un arreglo
var current_round := 0
var current_animal
var animal_pressed
var vidas = 3
var descripcion = {}
var puntos = 0

onready var sprite3 = get_node("Cora3")
onready var sprite2 = get_node("Cora2")
onready var sprite1 = get_node("Cora1")

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.stream = preload("res://sounds/click.wav") as AudioStream
	$AudioStreamPlayer.play()
	animal_sounds = [preload("res://sounds/ardilla.wav") as AudioStream,
					 preload("res://sounds/mariposa.wav") as AudioStream,
					 preload("res://sounds/pajaro.wav") as AudioStream]
	animal_names = ["ardilla", "mariposa", "pajaro"]
	current_animal = animal_names[current_round]
	$ButtonParlante.connect("pressed", self, "play_animal_sound")
	Reset_Timer()
	descripcion  = {"ardilla":"Es una especie de mamífero arborícola mediano. Es de color grisáceo para camuflarse con el entorno y posee colores naranjas/amarillentas en la parte posterior de las patas.","mariposa":"Es de color azul iridiscente y gran tamaño, con una envergadura alar de 15 centímetros.","pajaro":"Suele posicionarse en zonas altas de los árboles con fines de resguardo, alimentación y puesta de nidos."}
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var seconds = 0
var minutes = 0 
var Dseconds = 30
var Dminutes = 1

func _on_Timer_timeout():
	if seconds == 0:
		if minutes > 0:
			minutes-=1
			seconds=60
	seconds-=1
	
	if seconds < 10 and minutes < 10:
		$Label.text=String(0)+String(minutes)+":"+String(0)+String(seconds)
	elif seconds < 10:
		$Label.text=String(minutes)+":"+String(0)+String(seconds)
	elif minutes < 10:
		$Label.text=String(0)+String(minutes)+":"+String(seconds)
	else:
		$Label.text=String(minutes)+":"+String(seconds)
		
	if seconds == 0 and minutes == 0:
		get_tree().change_scene("res://BosqueSombra/Perdiste.tscn")
		
	pass # Replace with function body.
	
	
func Reset_Timer():
	seconds = Dseconds
	minutes = Dminutes


func _on_mono_pressed():
	animal_pressed = "ardilla"
	print(animal_pressed)
	_on_AnimalButton()
	
func _on_iguana_pressed():
	animal_pressed = "mariposa"
	print(animal_pressed)
	_on_AnimalButton()
	
func _on_oso_peresozo_pressed():
	animal_pressed = "pajaro"
	print(animal_pressed)
	_on_AnimalButton()
	

func play_animal_sound():
	if current_round < len(animal_sounds):
		$AudioStreamPlayer.stream = animal_sounds[current_round]
		$AudioStreamPlayer.play()
	else:
		game_over()

func game_over():
	asiganar_puntos(50)
	#get_tree().change_scene("res://BosqueSombra/BosqueJuego2.tscn")
	
# Agrega esto al script principal para manejar los clics en los animales
func _on_AnimalButton():
	# Verifica si el usuario hizo clic en el animal correcto
	if current_round < len(animal_sounds):
		if animal_pressed == current_animal:
			puntos += 10
			$pts_n.text = str(puntos)
			mostrar_animal()
			# El usuario hizo clic en el animal correcto
			# sonido de algo correcto
			play_animal_sound()
			mostrar(animal_pressed)
			current_round += 1
			if current_round <= 2:
				current_animal = animal_names[current_round]
			print(current_animal)
			 # Reproduce el siguiente sonido
		else:
			$pausar.set_visible(false)
			$Light2D.set_visible(false)
			$infope.set_visible(true)
			vidas -=1
			fallo_acierto("fallo")
			#sonido de algo incorrecto
			
		if vidas == 2:
			var new_texture3 = preload("res://assets/coragris.png")
			sprite3.texture = new_texture3
			
			
		if vidas == 1:
			var new_texture2 = preload("res://assets/coragris.png")
			sprite2.texture = new_texture2
			
		if vidas == 0:
			var new_texture1 = preload("res://assets/coragris.png")
			sprite1.texture = new_texture1
			get_tree().change_scene("res://BosqueSombra/Perdiste.tscn")
			#Cambia a la siguiente escena
	else:
		game_over()

func mostrar_animal():
	if animal_pressed == "ardilla":
		var new_modulate_color = Color(1, 1, 1, 1) 
		$ardilla.modulate = new_modulate_color
		
	if animal_pressed == "mariposa":
		var new_modulate_color = Color(1, 1, 1, 1) 
		$mariposa.modulate = new_modulate_color
		
	if animal_pressed == "pajaro":
		var new_modulate_color = Color(1, 1, 1, 1) 
		$pajaro.modulate = new_modulate_color

func _on_TextureButton2_pressed():
	pass # Replace with function body.

func _on_pausar_pressed():
	$AudioStreamPlayer.stream = preload("res://sounds/click.wav") as AudioStream
	$AudioStreamPlayer.play()
	$pausar_ventana.set_visible(true)
	$Light2D.set_visible(false)
	
func _on_resume_pressed():
	$AudioStreamPlayer.stream = preload("res://sounds/click.wav") as AudioStream
	$AudioStreamPlayer.play()
	$pausar_ventana.set_visible(false)
	$Light2D.set_visible(true)

func _on_salir_pressed():
	$AudioStreamPlayer.stream = preload("res://sounds/click.wav") as AudioStream
	$AudioStreamPlayer.play()
	get_tree().change_scene("res://BosqueSombra/BosqueMenu.tscn")


func asiganar_puntos(puntos:int):
	GameManager.loadJson()
	for i in GameManager.allPlayers.keys():
		if i==GameManager.currentPlayer:
			GameManager.allPlayers[i]["monedas"]+=puntos;
	GameManager.saveJson(GameManager.allPlayers)

func fallo_acierto(fa:String):
	if fa == "fallo":
		$AudioStreamPlayer.stream = preload("res://sounds/fallo.wav") as AudioStream
		$AudioStreamPlayer.play()
	if fa == "acierto":
		$AudioStreamPlayer.stream = preload("res://sounds/acierto.wav") as AudioStream
		$AudioStreamPlayer.play()

func mostrar(animal:String):
	var scale = Vector2(0.25, 0.25)  # Change these values as needed
	if animal == "pajaro":
		$animal/animalab.text = animal.to_upper() + " CARPINTERO"
	else:
		$animal/animalab.text = animal.to_upper()
	$animal/foto.texture = load("res://assets/"+animal+".png")
	$animal/foto.scale = scale
	$animal/desc.text = descripcion[animal]
	$animal.set_visible(true)
	$Light2D.set_visible(false)
	
	
func _on_OK_pressed():
	$animal.set_visible(false)
	$Light2D.set_visible(true)
	$AudioStreamPlayer.stream = preload("res://sounds/click.wav") as AudioStream
	$AudioStreamPlayer.play()
	if current_round == 3:
		get_tree().change_scene("res://BosqueSombra/BosqueJuego2.tscn")
		
func _on_bot_pressed():
		$AudioStreamPlayer.stream = preload("res://sounds/click.wav") as AudioStream
		$AudioStreamPlayer.play()
		$Light2D.set_visible(true)
		$infopa.set_visible(false)
		$pausar.set_visible(true)

func _on_botp_pressed():
		$AudioStreamPlayer.stream = preload("res://sounds/click.wav") as AudioStream
		$AudioStreamPlayer.play()
		$Light2D.set_visible(true)
		$infope.set_visible(false)
		$pausar.set_visible(true)
