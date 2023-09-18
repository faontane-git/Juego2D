extends RigidBody2D

var picked = false
var nut_appear_timer := Timer.new()
var nut_disappear_timer := Timer.new()
var nut_object_lifetime = 7
var hud_height = 300
var is_visible = true

func _ready():
	randomize()
	add_child(nut_appear_timer)
	add_child(nut_disappear_timer)
	nut_appear_timer.connect("timeout", self, "_on_appear_timer_timeout")
	nut_disappear_timer.connect("timeout", self, "_on_disappear_timer_timeout")
	randomize_position()
	_on_appear_timer_timeout()  # Realizar la primera aparición del agua
	Signals.connect("on_game_over", self, "_on_game_over")

func randomize_position():
	position.x = rand_range(80, get_viewport().size.x)
	position.y = rand_range(80, hud_height)

func _on_appear_timer_timeout():
	randomize_position()
	
	self.visible = true
	nut_appear_timer.stop()
	nut_disappear_timer.start(nut_object_lifetime)  # Desaparecer después de 5 segundos

func _on_disappear_timer_timeout():
	
	self.visible = false
	restablish()
	nut_disappear_timer.stop()
	nut_appear_timer.start(nut_object_lifetime)  # Volver a aparecer después de 5 segundos

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
		else:
			picked = false
			get_node("../personajePrincipal").canPick = true
			if get_node("../personajePrincipal")._animated_sprite.flip_h == false:
				apply_impulse(Vector2(), Vector2())
			else:
				apply_impulse(Vector2(), Vector2())

func _on_game_over():
	nut_appear_timer.stop()  # Detener los temporizadores al finalizar el juego
	nut_disappear_timer.stop()
	queue_free()
