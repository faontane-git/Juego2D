extends RigidBody2D

var hud_height = 300
var respawn_interval: float = 5  # Intervalo de tiempo en segundos para que la basura reaparezca
var disappear_time: float = 10   # Tiempo en segundos hasta que la basura desaparezca
var appear_timer: float = 0
var trash_spawned: bool = false  # Variable para verificar si la basura ya apareció

func _ready():
	randomize()
	randomize_appear_timer()
	Signals.connect("on_game_over", self, "_on_game_over")

func randomize_appear_timer():
	appear_timer = rand_range(5, 10)  # Tiempo aleatorio entre 5 y 10 segundos

func randomize_position():
	position.x = rand_range(80, get_viewport().size.x)
	position.y = rand_range(80, hud_height)
func restablish():
	position.x= 0
	position.y=0
func _physics_process(delta):
	if appear_timer > 0:
		appear_timer -= delta
		if appear_timer <= 0 and !trash_spawned:
			randomize_position()
			self.visible = true
			get_node("ApareceBasura").play()
			trash_spawned = true

	if trash_spawned:
		disappear_time -= delta
		if disappear_time <= 0:
			self.visible = false
			trash_spawned = false
			restablish()
			randomize_appear_timer()  # Genera un nuevo tiempo de aparición
			disappear_time = 15  # Restablece el tiempo de desaparición


func _on_game_over():
	queue_free()
