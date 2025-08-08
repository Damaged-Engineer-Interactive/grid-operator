extends Interactable

@onready var animation_player: AnimationPlayer = get_node(^"../../AnimationPlayer")

var is_pressed: bool = false
var state: int = 0

func primary_text() -> String:
	return "Switch left"

func secondary_text() -> String:
	return "Switch right"

func primary():
	if is_pressed or state == 2:
		return
	is_pressed = true
	state += 1
	match state:
		1:
			animation_player.play(&"O-I")
		2:
			animation_player.play(&"I-II")

func secondary():
	if is_pressed or state == 0:
		return
	is_pressed = true
	state -= 1
	match state:
		0:
			animation_player.play_backwards(&"O-I")
		1:
			animation_player.play_backwards(&"I-II")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	is_pressed = false
