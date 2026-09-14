extends Node

# Vitesse
@export var vitesse: float = 400

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta):
	var direction = 0

	# Inputs
	if Input.is_action_pressed("P1_left"):
		direction = -1
	elif Input.is_action_pressed("P1_right"):
		direction = 1

	# Déplacement
	var mouvement = direction * vitesse * delta
	var parent = get_parent()

	parent.position.x += mouvement
	
	# Limite de la map
	var screen_size = get_viewport().get_visible_rect().size
	var min_x = screen_size.x * 0.05
	var max_x = screen_size.x * 0.95

	parent.position.x = clamp(parent.position.x, min_x, max_x)
