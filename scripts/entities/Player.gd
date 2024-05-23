extends CharacterBody2D
class_name Player

@export var base_speed: int = 30*32 #960
@export var jump_velocity: int = -800
@export var max_coyote_time: float = 0.25 #Time in Seconds
@export var max_jump_buffer: float = 0.25 #WARNING: DO NOT SET EITHER ABOVE 0.25, OR IT'LL BE TOO OBVIOUS

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var weight: float

var gravity_scale: float = 1.5

var has_jumped: bool = false
var has_pressed_jump: bool = false
var was_in_air: bool
var just_landed: bool

var coyote_time: float = 0.0
var jump_buffer: float = 0.0

var x_plat_speed: float = 0

var term_velocity = 8000


func _physics_process(delta):
	was_in_air = not is_on_floor()
	move_and_slide()
	just_landed = is_on_floor() and was_in_air
	
	handle_horizontal()
	handle_vertical(delta)


func handle_horizontal():
	var direction: float = Input.get_axis("move_left", "move_right")
	var move_speed: float = base_speed * direction

	if not is_on_floor():
		velocity.x = lerp(velocity.x, move_speed + x_plat_speed, weight)
	elif get_platform_velocity().x != 0 and just_landed and not direction:
		velocity.x = 0 #So the players don't just slide randomly when landing on a platform
	else:
		velocity.x = lerp(velocity.x, move_speed, weight)

func handle_vertical(delta):
	if not is_on_floor():
		if velocity.y < 0: #Rising
			gravity_scale = 1.5
		else: #Falling
			gravity_scale = 2 #MUST be higher than in the last statement, so it doesn't feel as floaty
		velocity.y = clamp(velocity.y + gravity * gravity_scale * delta, -term_velocity, term_velocity)
		weight = 0.05 #Sets horizontal movement to be slower; WARNING: DO NOT LEAVE BELOW 0.05
		coyote_time = clamp(coyote_time - delta, 0, max_coyote_time)
		if has_pressed_jump == true:
			jump_buffer = clamp(jump_buffer - delta, 0, max_jump_buffer)
			if jump_buffer == 0:
				has_pressed_jump = false
	else:
		has_jumped = false
		weight = 0.25 #Returns horizontal movement to normal; WARNING: DO NOT LEAVE ABOVE 0.3
		coyote_time = max_coyote_time #Gives a short timeframe to jump after falling off
		x_plat_speed = get_platform_velocity().x
	
	#Normal Jump
	if Input.is_action_just_pressed("jump"):
		has_pressed_jump = true
		modulate = Color(0,0.5,1)
		jump_buffer = max_jump_buffer
	if has_pressed_jump == true and has_jumped == false and coyote_time > 0:
		has_jumped = true
		velocity.y = jump_velocity
		has_pressed_jump = false
	
	#Short Jump
	if Input.is_action_just_released("jump"):
		modulate = Color(1,1,1)
		if velocity.y < jump_velocity / 4.0:
			velocity.y = jump_velocity / 4.0
