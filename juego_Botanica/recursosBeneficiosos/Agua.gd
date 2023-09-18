extends RigidBody2D

var picked = false
var agua_appear_timer := Timer.new()
var agua_disappear_timer := Timer.new()
var agua_object_lifetime = 2
var hud_height = 300
var is_visible = true

func _ready():
	randomize()
	add_child(agua_appear_timer)
	add_child(agua_disappear_timer)
	agua_appear_timer.connect("timeout", self, "_on_appear_timer_timeout")
	agua_disappear_timer.connect("timeout", self, "_on_disappear_timer_timeout")
	_on_appear_timer_timeout()  # Realizar la primera aparición del agua
	Signals.connect("on_game_over", self, "_on_game_over")

func randomize_position():
	position.x = rand_range(80, get_viewport().size.x)
	position.y = rand_range(80, hud_height)

func _on_appear_timer_timeout():
	randomize_position()
	#print("Agua aparece") Descomentar para debug
	self.visible = true
	if not picked:  # Solo iniciar el temporizador de desaparición si no está en estado "picked"
		agua_disappear_timer.start(agua_object_lifetime)
	agua_appear_timer.stop()


func _on_disappear_timer_timeout():
	#print("Agua desaparece") Descomentar para debug
	self.visible = false
	restablish()
	if not picked:  # Solo iniciar el temporizador de aparición si no está en estado "picked"
		agua_appear_timer.start(agua_object_lifetime)
	agua_disappear_timer.stop()

func restablish():
	position.x= 0
	position.y=0
	
func _physics_process(delta):
	self.rotation_degrees = 0
	if picked == true and get_node("../personajePrincipal") != null:
		self.position = Vector2(get_node("../personajePrincipal/Position2D").global_position)
		

func _input(event):
	if Input.is_action_just_pressed("ui_grab") and get_node("../personajePrincipal") != null:
		if picked == false:
			var bodies = $Area2D.get_overlapping_bodies()
			for body in bodies:
				if body.name == "personajePrincipal" and get_node("../personajePrincipal").canPick == true:
					picked = true
					get_node("../personajePrincipal").canPick = false
					agua_appear_timer.stop()  # Detener temporizador de aparición
					agua_disappear_timer.stop()  # Detener temporizador de desaparición
		else:
			picked = false
			get_node("../personajePrincipal").canPick = true
			agua_disappear_timer.start(agua_object_lifetime)
			if get_node("../personajePrincipal")._animated_sprite.flip_h == false:
				apply_impulse(Vector2(), Vector2())
			else:
				apply_impulse(Vector2(), Vector2())

func _on_game_over():
	agua_appear_timer.stop()  # Detener los temporizadores al finalizar el juego
	agua_disappear_timer.stop()
	queue_free()
