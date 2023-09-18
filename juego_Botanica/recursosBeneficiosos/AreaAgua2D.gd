extends Area2D


var increaseValue = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("Planta"):
		#print("Se recibio agua")
		get_node("../AgarraAgua").play()
		var agua = get_parent()
		var personaje = get_node("../../personajePrincipal")
		agua.visible = false
		agua.picked = false
		personaje.canPick = true
		agua._on_disappear_timer_timeout()
		
		var progresoAgua = get_node("../../HUD/Agua_Progress")
		progresoAgua.value += increaseValue
