extends Node

@export var vitesse: float = 500
@export var vitesse_balle: float = 500
@export var angle_max_degres: float = 75
@export var angle_lancement_min: float = -15
@export var angle_lancement_max: float = 15

var balle: RigidBody2D
var peut_rebondir: bool = true

func _ready() -> void:
	balle = get_parent()

	balle.gravity_scale = 0
	balle.contact_monitor = true
	balle.max_contacts_reported = 4
	balle.body_entered.connect(_on_body_entered)

	# Lancement initial
	var angle_depart = deg_to_rad(randf_range(angle_lancement_min, angle_lancement_max))
	var direction_depart = Vector2(sin(angle_depart), cos(angle_depart))
	balle.linear_velocity = direction_depart.normalized() * vitesse


func _on_body_entered(body: Node) -> void:
	if not peut_rebondir:
		return

	if body.is_in_group("raquette"):
		_rebond_raquette(body)
	elif body.is_in_group("briques"):
		body.toucher()


func _rebond_raquette(raquette: Node) -> void:
	peut_rebondir = false

	var largeur_raquette = raquette.get_node("hitboxRaquette").shape.size.x
	var offset = (balle.global_position.x - raquette.global_position.x) / (largeur_raquette / 2.0)
	offset = clamp(offset, -1.0, 1.0)

	var angle = offset * deg_to_rad(angle_max_degres)
	var nouvelle_direction = Vector2(sin(angle), -cos(angle))
	balle.linear_velocity = nouvelle_direction.normalized() * vitesse_balle

	var haut_raquette = raquette.global_position.y - raquette.get_node("hitboxRaquette").shape.size.y / 2.0
	var rayon_balle = balle.get_node("hitboxBall").shape.radius
	balle.global_position.y = haut_raquette - rayon_balle - 1.0

	await get_tree().create_timer(0.1).timeout
	peut_rebondir = true


func _physics_process(delta: float) -> void:
	if balle.linear_velocity.length() > 0:
		balle.linear_velocity = balle.linear_velocity.normalized() * vitesse_balle
