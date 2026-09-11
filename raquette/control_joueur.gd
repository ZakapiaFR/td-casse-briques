extends Node

# Variable exportée pour la vitesse de déplacement de la raquette
@export var vitesse: float = 300.0

# Référence au nœud parent (la raquette)
@onready var raquette: Node2D = get_parent()

func _physics_process(delta: float) -> void:
	# Récupérer l'entrée horizontale en utilisant les inputs personnalisés
	var direction: float = Input.get_action_strength("p1_right") - Input.get_action_strength("p1_left")

	# Calculer le déplacement
	var deplacement: Vector2 = Vector2(direction * vitesse * delta, 0)

	# Appliquer le déplacement au nœud parent (la raquette)
	raquette.position += deplacement
	
	# Récupérer la taille du visuel (Sprite2D)
	var sprite: Sprite2D = raquette.get_child(0) as Sprite2D
	var taille_raquette: float = sprite.texture.get_size().x

	# Empêcher la raquette de sortir de l'écran
	var limite_gauche: float = 0 + (taille_raquette )
	var limite_droite: float = get_viewport().get_visible_rect().size.x - (taille_raquette )

	if raquette.position.x < limite_gauche:
		raquette.position.x = limite_gauche
	elif raquette.position.x > limite_droite:
		raquette.position.x = limite_droite
