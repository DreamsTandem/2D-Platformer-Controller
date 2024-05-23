extends Camera2D

@onready var player: Node = get_parent()

func _process(delta):
	offset.x = lerp(offset.x, clamp(player.velocity.x / 2, -500.0, 500.0), 0.05)
	offset.y = lerp(offset.y, clamp(player.velocity.y / 4.5, -250.0, 250.0), 0.05)
#WARNING: Do not set weight on offset.x OR offset.y above 0.05 unless intent is to prevent motion sickness.
