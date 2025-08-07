extends Interactable

@onready var animation_player: AnimationPlayer = get_node(^"../../AnimationPlayer")

var is_pressed: bool = false

func get_interaction_text():
	return "E/LMB : Push"

func primary():
	if is_pressed:
		return
	is_pressed = true
	animation_player.play(&"push")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	is_pressed = false
