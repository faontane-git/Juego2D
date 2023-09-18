extends Button

class_name PartidaObj

var partida
var font = DynamicFont.new()

func _ready():
	self.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	self.set("custom_fonts/font", font)
	text = str(partida)
	self.connect("pressed", self, "_onClickPartida")
	
func _init(var partida):
	font.font_data = load("res://fonts/Righteous-Regular.ttf")
	font.size = 50
	self.partida = partida
	
func _onClickPartida():
	var jugador = partida.split(" ")[1]

	GameManager.currentPlayer = jugador
	GameManager.player = GameManager.allPlayers[jugador]
	get_tree().change_scene("res://hubinicial/Hub/GameHub2D.tscn")
