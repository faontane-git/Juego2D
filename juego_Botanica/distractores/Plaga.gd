extends RigidBody2D

var hud_height = 300
var plaga_respawn_interval: float = 5  # Intervalo de tiempo en segundos para que la basura reaparezca
var plaga_disappear_time: float = 15   # Tiempo en segundos hasta que la basura desaparezca
var plaga_appear_timer: float = 0
var plaga_spawned: bool = false  # Variable para verificar si la basura ya apareció
var target_plant: Node2D = null  # Referencia al objeto "planta"
var speed: float = 25  # Velocidad de la plaga

func _ready():
	randomize()
	randomize_appear_timer()
	Signals.connect("on_game_over", self, "_on_game_over")

func randomize_appear_timer():
	plaga_appear_timer = rand_range(5, 10)  # Tiempo aleatorio entre 5 y 10 segundos

func randomize_position():
	position.x = rand_range(80, get_viewport().size.x)
	position.y = rand_range(80, hud_height)
func restablish():
	position.x= -10000
	position.y=-10000
	
func _physics_process(delta):
	if plaga_appear_timer > 0:
		plaga_appear_timer -= delta
		if plaga_appear_timer <= 0 and !plaga_spawned:
			randomize_position()
			#print("Plaga aparece")
			get_node("AparecePlaga").play()
			self.visible = true
			plaga_spawned = true

	if plaga_spawned:
		var new_target_plant = get_node("../Planta")
		if new_target_plant:
			target_plant = new_target_plant

		if target_plant:
			var direction = (target_plant.global_position - global_position).normalized()
			linear_velocity = direction * speed
		else:
			linear_velocity = Vector2.ZERO

		plaga_disappear_time -= delta
		if plaga_disappear_time <= 0:
			self.visible = false
			plaga_spawned = false
			target_plant = null
			restablish()
			#print("Plaga desaparece")
			randomize_appear_timer()  # Genera un nuevo tiempo de aparición
			plaga_disappear_time = 15  # Restablece el tiempo de desaparición

func _on_game_over():
	queue_free()


