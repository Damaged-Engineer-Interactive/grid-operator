extends Interactable

@onready var animation_player: AnimationPlayer = get_node(^"../../../AnimationPlayer")

var is_pressed: bool = false
var state: bool = false

func get_interaction_text():
	return "E/LMB : Switch"

func primary():
	if is_pressed:
		return
	is_pressed = true
	state = not state
	if state:
		animation_player.play(&"switch")
	else:
		animation_player.play_backwards(&"switch")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	is_pressed = false
