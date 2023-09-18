extends Control
var Nombre

func _ready():
	get_node("BGM").play()
	var line_edit = $Nombre/LineEdit
	line_edit.connect("text_changed", self, "_on_line_edit_text_changed")

func _on_line_edit_text_changed(new_text):
	var max_length = 20
	var line_edit = $Nombre/LineEdit
	if new_text.length() > max_length:
		line_edit.text = new_text.substr(0, max_length)
	# Aquí puedes realizar cualquier otra acción con el nuevo texto
	# que cumple con la limitación de 20 caracteres
 
	
func _on_Button2_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.4),"timeout")
	get_tree().quit()

func _on_Button_pressed():
	get_node("Click").play()
	$Popup.hide()

func _on_Nuevo_pressed():
	get_node("Click").play()
	$Nombre.popup()

func _on_Cargar_pressed():
	GameManager.loadJson()
	get_node("Click").play()
	yield(get_tree().create_timer(.4),"timeout")
	$CargarPartida.popup()
	for i in GameManager.allPlayers.keys():
		var monedas=str(GameManager.allPlayers[i]["monedas"]);
		$CargarPartida/ScrollContainer/Partidas.add_child(PartidaObj.new(str("Jugador: "+i+" Monedas:"+monedas)))

func _on_Cerrar_pressed():
	get_node("Click").play()
	$Popup.popup()

func _on_Cerrar2_pressed():
	get_node("Click").play()
	$Seleccionar.hide()
	$Nombre.popup()

func _on_Cerrar3_pressed():
	get_node("Click").play()
	$Nombre.hide()

		
func _on_Continuar_pressed():
	get_node("Click").play()
	Nombre = $Nombre/LineEdit.text
	for i in GameManager.allPlayers.keys():
		if (i==Nombre or Nombre==""):
			if(Nombre==""):
				print("¡No ingrese un nombre en repetido!")
				$Advertencia.popup()
			else:
				print("¡No se vale ingresar un nombre repetido!")
				$Repetido.popup()
			return
	$Nombre/LineEdit.text = Nombre # Asigna el texto limitado al cuadro de texto
	$Seleccionar.popup()

func _on_personaje1_pressed():
	get_node("Click").play()
	GameManager.addPlayer(Nombre, 1)
	GameManager.loadPlayer(Nombre)
	GameManager.saveJson(GameManager.allPlayers)
	GameManager.currentPlayer = Nombre
	GameManager.newGameFlag = true
	get_tree().change_scene("res://hubinicial/Hub/GameHub2D.tscn")

func _on_personaje2_pressed():
	get_node("Click").play()
	GameManager.addPlayer(Nombre, 2)
	GameManager.loadPlayer(Nombre)
	GameManager.saveJson(GameManager.allPlayers)
	GameManager.currentPlayer = Nombre
	GameManager.newGameFlag = true
	get_tree().change_scene("res://hubinicial/Hub/GameHub2D.tscn")

func _on_personaje3_pressed():
	get_node("Click").play()
	GameManager.addPlayer(Nombre, 3)
	GameManager.loadPlayer(Nombre)
	GameManager.saveJson(GameManager.allPlayers)
	GameManager.currentPlayer = Nombre
	GameManager.newGameFlag = true
	get_tree().change_scene("res://hubinicial/Hub/GameHub2D.tscn")

func _on_personaje4_pressed():
	get_node("Click").play()
	GameManager.addPlayer(Nombre, 4)
	GameManager.loadPlayer(Nombre)
	GameManager.saveJson(GameManager.allPlayers)
	GameManager.currentPlayer = Nombre
	GameManager.newGameFlag = true
	get_tree().change_scene("res://hubinicial/Hub/GameHub2D.tscn")

func _on_CerrarCarga_pressed():
	var listaPartida = $CargarPartida/ScrollContainer/Partidas
	for n in listaPartida.get_children():
		listaPartida.remove_child(n)
		n.queue_free()
	
	get_node("Click").play()
	$CargarPartida.hide()
	
func _on_TextureButton_pressed():
	$Advertencia.hide()

func _on_BotonSalir_pressed():
	$Repetido.hide()
	
	
