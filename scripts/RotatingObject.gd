extends MoveBase

@export var indefinite: bool = false
@export var rotation_speed: float = 2  #Degrees per Second
@export var rotation_scale: float = 10  #Degrees

func _ready():
	var start_rot: float = rotation
	var finish_rot: float = rotation + rotation_scale
	
	hardlock_position()
	
	duration = rotation_scale / rotation_speed
	var tween: Tween = create_tween().set_loops()
	if indefinite == true:
		tween.tween_property(self, "rotation_degrees", start_rot + 360, 360 / rotation_speed).set_trans(trans_type)
	else:
		tween.tween_property(self, "rotation_degrees", finish_rot, duration).set_trans(trans_type).set_delay(idle_time)
		tween.tween_property(self, "rotation_degrees", start_rot, duration).set_trans(trans_type).set_delay(idle_time)
