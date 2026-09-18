extends Node2D

@export var brique_scene: PackedScene
@export var colonnes: int = 10
@export var taille_brique: Vector2 = Vector2(80, 16)
@export var marge: Vector2 = Vector2(8, 2)
@export var offset_depart: Vector2 = Vector2(180, 80)
@export var lignes_supplementaires: int = 2

func _ready() -> void:
	var espacement = taille_brique + marge
	var lignes_par_colonne = _get_lignes_par_colonne()
	var max_lignes = lignes_par_colonne.max()

	# Grille principale
	for x in range(colonnes):
		var nb_lignes = lignes_par_colonne[x]
		for y in range(nb_lignes):
			var brique = brique_scene.instantiate()
			brique.position = offset_depart + Vector2(x * espacement.x, y * espacement.y)
			add_child(brique)

	# Lignes supplémentaires
	for x in range(colonnes):
		for i in range(lignes_supplementaires):
			var y = max_lignes + i
			var brique = brique_scene.instantiate()
			brique.position = offset_depart + Vector2(x * espacement.x, y * espacement.y)
			add_child(brique)


func _get_lignes_par_colonne() -> Array:
	var result = []
	for x in range(colonnes):
		if x >= 0 and x <= 3:
			result.append(6)
		elif x >= 4 and x <= 5:
			result.append(4)
		elif x >= 6 and x <= 9:
			result.append(6)
		else:
			result.append(0)
	return result
