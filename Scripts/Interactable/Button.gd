extends Interactable

@onready var animation_player: AnimationPlayer = get_node(^"../../AnimationPlayer")


func get_interaction_text():
	return "interact"

func interact():
	print("interacted with button")
	animation_player.play(&"press")
