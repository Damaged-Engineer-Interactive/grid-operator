extends Interactable

@onready var animation_player: AnimationPlayer = get_node(^"../../AnimationPlayer")

var is_pressed: bool = false
var state: bool = false

func primary_text() -> String:
	return "Press"

func secondary_text() -> String:
	return "Reset"

func primary():
	if is_pressed or state:
		return
	is_pressed = true
	state = true
	animation_player.play(&"stop-activate")

func secondary():
	if is_pressed or not state:
		return
	is_pressed = true
	state = false
	animation_player.play(&"reset-stop")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	is_pressed = false
