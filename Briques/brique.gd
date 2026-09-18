extends StaticBody2D

signal detruite(brique: Node)

@export var points: int = 100
@export var vie: int = 1

func toucher() -> void:
	vie -= 1
	if vie <= 0:
		detruite.emit(self)
		queue_free()
