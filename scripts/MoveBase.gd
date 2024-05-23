class_name MoveBase
extends Node2D

@export_enum("Linear", "Sine", "Quintic", "Quartic", "Quadratic", "Exponential",
"Elastic", "Cubic", "Circular", "Bounce", "Back", "Spring") var trans_type: int

@export var idle_time: float = 0  #Seconds

var duration: float

func hardlock_position():
	position = position
	#I know this seems redundant, but without it, TileMaps will just snap to Vector2.ZERO if
	#collision_animatable is set to true. The reason for this behavior is unknown.
	
	#ALERT: It does NOT prevent this behavior if you enter from another level rather than from Run Current Scene!
