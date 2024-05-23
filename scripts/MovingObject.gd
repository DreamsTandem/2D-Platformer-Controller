extends MoveBase

@export var speed: float = 32  #Pixels per Second
@export var distance: Vector2 = Vector2(32, 0)  #Pixels

func _ready():
	var start_pos: Vector2 = position
	var finish_pos: Vector2 = position + distance
	
	hardlock_position()
	
	duration = distance.length() / speed
	var tween: Tween = create_tween().set_loops()
	tween.tween_property(self, "position", finish_pos, duration).set_trans(trans_type).set_delay(idle_time)
	tween.tween_property(self, "position", start_pos, duration).set_trans(trans_type).set_delay(idle_time)
