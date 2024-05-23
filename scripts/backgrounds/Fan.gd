extends Node2D

@export var fan_blades: Node
@export var acceleration: float = 0.01
@export var max_speed: float = 1

@export var lights: Node
@export var light_color: Color = Color(1, 1, 1)

var current_speed: float = 0

func _ready():
	lights.modulate = light_color

func _process(delta):
	current_speed = clamp(current_speed + acceleration, 0, max_speed)
	fan_blades.rotation += current_speed
