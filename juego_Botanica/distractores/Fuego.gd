extends RigidBody2D

var hud_height = 300
var spread_interval: float = 10  # Intervalo de propagación en segundos
var fire_spawned: bool = false  # Variable para verificar si el fuego ya apareció
var initial_position: Vector2  # Almacenar la posición inicial del fuego
var fire_appear_timer: float = 0  # Tiempo inicial de aparición aleatorio

func _ready():
	randomize()
	randomize_fire_appear_timer()
	Signals.connect("on_game_over", self, "_on_game_over")

func randomize_fire_appear_timer():
	fire_appear_timer = rand_range(1, 5)  # Tiempo aleatorio entre 1 y 5 segundos

func randomize_position():
	position.x = rand_range(80, get_viewport().size.x)
	position.y = rand_range(80, hud_height)

func restablish():
	position.x= -10000
	position.y=-10000
func _physics_process(delta):
	if fire_appear_timer > 0:
		fire_appear_timer -= delta
		if fire_appear_timer <= 0 and !fire_spawned:
			randomize_position()
			self.visible = true
			get_node("ApareceFuego").play()
			fire_spawned = true

	if fire_spawned:
		spread_interval -= delta
		if spread_interval <= 0:
			self.visible = false
			fire_spawned = false
			restablish()
			randomize_fire_appear_timer() 
			spread_interval = 10


func _on_game_over():
	queue_free()
