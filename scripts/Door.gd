extends Area2D

@export var next_level: PackedScene

var player_entered: bool = false

func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and player_entered == true:
		if next_level != null:
			get_tree().change_scene_to_packed(next_level)
		else:
			print_rich("[color=red]ALERT: ", self, " does not have any level set to transition to.[/color]")

func _on_body_entered(body):
	if body is Player:
		player_entered = true

func _on_body_exited(body):
	if body is Player:
		player_entered = false
