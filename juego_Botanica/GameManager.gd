extends Node2D

#Elementos del HUD

onready var agua = $HUD/Agua_Progress
onready var sol = $HUD/Sol_Progress
onready var nut = $HUD/Nutrientes_Progress
onready var timer = $Decrementar  # Asegúrate de conectar el Timer en el editor de nodos.
onready var nivel = $Info/NumNivel
onready var labelPuntos = $Info/NumPuntos
onready var hud = $Info

#Elementos del juego

onready var plaga = $Plaga
onready var fuego = $Fuego
onready var basura = $Basura
onready var aguaObj = $Agua
onready var solObj = $Sol
onready var nutObj = $Nutriente
onready var planta = $Planta
#Interacciones con los objetos

onready var aguaArea = $Agua/Area2D
onready var solArea = $Sol/Area2D
onready var nutArea = $Nutriente/Area2D
onready var fireArea = $Fuego/Area2D
onready var TrashArea = $Basura/Area2D
onready var validador = $Validador
#Variables locales del juego
var nivelActual = 1
var decreaseSpeed = 10
var puntos=0
var monedas=0
#Variables para debug

var winValue = 100
var looseValue = 0

func _ready():
	# Inicia el Timer cuando el juego comienza.
	timer.start()
	nivel.text = str(nivelActual)
	pauseGame()

# Función para disminuir el valor de las barras de progreso 
func decreaseBars():
	# Resta puntos de las tres barras de progreso
	agua.value -= decreaseSpeed
	sol.value -= decreaseSpeed
	nut.value -= decreaseSpeed
	# Verificar si el juego debe terminar.
	

func asiganar_puntos(puntos:int):
	GameManager.loadJson()
	for i in GameManager.allPlayers.keys():
		if i==GameManager.currentPlayer:
			GameManager.allPlayers[i]["monedas"]+=puntos;
	 GameManager.saveJson(GameManager.allPlayers)		

# Esta función verifica si todas las barras de progreso están en 0 y finaliza el juego si es así.
func checkGameOver():
	if (agua.value == looseValue and sol.value == looseValue and nut.value == looseValue) or planta.vida_planta==0 :
		validador.stop()
		var popupOver = get_node("GameOver")
		popupOver.visible = true
		get_node("GameOver2").play()
		yield(get_tree().create_timer(1),"timeout")
		get_tree().paused = true
		
func checkLevelComplete():
	if agua.value >= winValue and sol.value >= winValue and nut.value >= winValue:
		validador.stop()
		if nivelActual != 6:
			print("NIVEL COMPLETADO")
			var popup = get_node("LevelComplete")
			get_node("LevelComplete2").play()
			popup.visible=true
			get_node("LevelComplete2").play()
			yield(get_tree().create_timer(1),"timeout")
			get_tree().paused = true
			nivelActual +=1;
			nivel.text = str(nivelActual)
			growTree()
			increaseDifficulty()
			resetLevel()
			puntos+=20
			labelPuntos.text = str(puntos)
			asiganar_puntos(puntos)
		else:
			var popup_complete = get_node("GameComplete")
			get_node("LevelComplete2").play()
			yield(get_tree().create_timer(1),"timeout")
			popup_complete.visible = true
			get_tree().paused = true
			
		
func pauseGame():
	if hud.botanicaPausado == true:
		get_tree().paused = true
	else:
		get_tree().paused = false
		
func resetLevel():
	agua.value = 25
	sol.value = 25
	nut.value = 25
	validador.start()

func game_over():
	# Puedes mostrar un mensaje de "Juego Terminado" o realizar otras acciones de finalización aquí.
	print("Juego Terminado")
	# Luego, puedes salir del juego, cargar una pantalla de resultados, etc.
	# Por ejemplo, si deseas salir del juego, puedes hacerlo así:
	get_tree().quit()  # Esto cerrará la aplicación.


#Funciones para manejar emision de senales

func _on_Validador_timeout():
	checkLevelComplete()
	checkGameOver()
# Esta función se ejecuta cada vez que el Timer se activa (cada 10 segundos).
func _on_Decrementar_timeout():
	decreaseBars()

func _on_TextureButton_pressed():
	 get_tree().paused = false
	 var popup = get_node("LevelComplete")
	 popup.visible = false

func _on_VolverAlMenu_pressed():
	get_tree().change_scene("res://juego_Botanica/HUDs/BotanicaTitle.tscn")
	var popup_complete = get_node("GameComplete")
	popup_complete.visible = false
	get_tree().paused = false
	
func _on_Retry_pressed():
	get_tree().reload_current_scene()
	
	
#Funcion para cambiar los arboles con el paso de los niveles
func growTree():
	match nivelActual:
		2: 
			print("Planta nivel 2")
			var upgrade2 = get_node("Planta/Sprite")
			var texture = ImageTexture.new()
			print(texture)
			texture = load("res://assets/assets_Botanica/Arbol2.png")
			upgrade2.set_texture(texture)
			
		3:
			print("Planta nivel 3")
			var upgrade3 = get_node("Planta/Sprite")
			var texture = ImageTexture.new()
			print(texture)
			texture = load("res://assets/assets_Botanica/Arbol3.png")
			upgrade3.set_texture(texture)
		
		4: 
			print("Planta nivel 4")
			var upgrade4 = get_node("Planta/Sprite")
			var texture = ImageTexture.new()
			print(texture)
			texture = load("res://assets/assets_Botanica/Arbol4.png")
			upgrade4.set_texture(texture)
		5: 
			print("Planta nivel 5")
			var upgrade5 = get_node("Planta/Sprite")
			var texture = ImageTexture.new()
			print(texture)
			texture = load("res://assets/assets_Botanica/Arbol5.png")
			upgrade5.set_texture(texture)


# MODIFICAR LOS VALORES AQUI PARA BUFFEAR / NERFEAR EL JUEGO

func increaseDifficulty():
	match nivelActual:
		2: 
			print("Dificultad 2")
			#Ajuste de objetos Distractores
			plaga.speed = 30
			fireArea.fireRespawnTime = 15
			basura.disappear_time = 12
			#Ajuste de tiempos de aparicion
			aguaObj.agua_object_lifetime = 5
			solObj.sol_object_lifetime = 7
			nutObj.nut_object_lifetime = 8
			#Ajuste de velocidad de reduccion de barras de progreso
			decreaseSpeed = 8
			#Ajuste de valor incrementado por recoger objeto
			aguaArea.increaseValue = 15
			solArea.increaseValue = 15
			nutArea.increaseValue = 15
		3:
			print("Dificultad 3")
			#Ajuste de objetos Distractores
			fireArea.fireRespawnTime = 10
			plaga.speed = 50
			basura.disappear_time = 15
			#Ajuste de tiempos de aparicion
			aguaObj.agua_object_lifetime = 7
			solObj.sol_object_lifetime = 10
			nutObj.nut_object_lifetime = 12
			#Ajuste de velocidad de reduccion de barras de progreso
			decreaseSpeed = 5
			#Ajuste de valor incrementado por recoger objeto
			aguaArea.increaseValue = 10
			solArea.increaseValue = 10
			nutArea.increaseValue = 10
			
		4: 
			print("Dificultad 4")
			#Ajuste de objetos Distractores
			fireArea.fireRespawnTime = 10
			plaga.speed = 75
			basura.disappear_time = 20
			#Ajuste de tiempos de aparicion
			aguaObj.agua_object_lifetime = 10
			solObj.sol_object_lifetime = 12
			nutObj.nut_object_lifetime = 12
			#Ajuste de velocidad de reduccion de barras de progreso
			decreaseSpeed = 2
			#Ajuste de valor incrementado por recoger objeto
			aguaArea.increaseValue = 7
			solArea.increaseValue = 7
			nutArea.increaseValue = 7
		5: 
			print("Dificultad 5")
			#Ajuste de objetos Distractores
			fireArea.fireRespawnTime = 5
			plaga.speed = 100
			basura.disappear_time = 25
			#Ajuste de tiempos de aparicion
			aguaObj.agua_object_lifetime = 15
			solObj.sol_object_lifetime = 15
			nutObj.nut_object_lifetime = 15
			#Ajuste de velocidad de reduccion de barras de progreso
			decreaseSpeed = 1
			#Ajuste de valor incrementado por recoger objeto
			aguaArea.increaseValue = 5
			solArea.increaseValue = 5
			nutArea.increaseValue = 5

