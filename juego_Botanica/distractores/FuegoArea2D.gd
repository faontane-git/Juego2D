extends Area2D


var fireRespawnTime = 15
onready var labelPuntos = get_node("../../Info/NumPuntos")
onready var descripcion = get_node("../../Info/detallesPuntos")
onready var puntosRef = get_parent().get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func descriptionUpdate():
	descripcion.text = "Controlador de incendios: +10 puntos"
	yield(get_tree().create_timer(5),"timeout")
	descripcion.text = ""

func _on_Area2D_body_entered(body):
	if body.is_in_group("Planta"):
		var planta = get_node("../../Planta")
		planta.damage()
		get_node("../FuegoDamage").play()
	if body.is_in_group("Agua"):
		var fuego = get_node("../../Fuego")
		fuego.position.x = -1000
		fuego.position.y = -1000
		puntosRef.puntos += 10
		labelPuntos.text = str(puntosRef.puntos)
		descriptionUpdate()
		yield(get_tree().create_timer(fireRespawnTime), "timeout")
		fuego.randomize_position()
		

