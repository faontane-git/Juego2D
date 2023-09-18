extends RigidBody2D

var picked = false
export var vida_planta: int = 7


func _ready():
	Signals.connect("on_game_over", self, "_on_game_over")



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
					get_node("AgarraPlanta").play()
					get_node("../personajePrincipal").canPick = false
		else:
			picked = false
			get_node("../personajePrincipal").canPick = true
			if get_node("../personajePrincipal")._animated_sprite.flip_h == false:
				apply_impulse(Vector2(), Vector2())
			else:
				apply_impulse(Vector2(), Vector2())

func damage():
	if vida_planta > 0:
		var vida = get_node("../Info/Vida"+str(vida_planta))
		var texture = ImageTexture.new()
		texture = load("res://assets/iconos/heart_border.png")
		vida.set_texture(texture)
		vida_planta -= 1
func _on_game_over():
	queue_free()



