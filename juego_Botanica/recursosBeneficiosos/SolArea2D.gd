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
		#print("Se recibio sol")
		get_node("../AgarraSol").play()
		var sol = get_parent()
		var personaje = get_node("../../personajePrincipal")
		sol.visible = false
		sol.picked = false
		personaje.canPick = true
		sol._on_disappear_timer_timeout()
		
		var progresoSol = get_node("../../HUD/Sol_Progress")
		progresoSol.value += increaseValue
