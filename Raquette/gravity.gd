extends CharacterBody2D

@export var vitesse: float = 400

var y_fixe: float

func _ready() -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	y_fixe = position.y

func _physics_process(_delta: float) -> void:
	var direction = Input.get_axis("P1_left", "P1_right")
	velocity.x = direction * vitesse
	velocity.y = 0

	move_and_slide()

	# Fixe la raquette
	position.y = y_fixe

	# Limite de la map
	var limite = get_viewport().get_visible_rect().size
	var min_x = limite.x * 0.05
	var max_x = limite.x * 0.95
	position.x = clamp(position.x, min_x, max_x)
