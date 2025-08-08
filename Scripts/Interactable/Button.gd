extends Interactable

@onready var animation_player: AnimationPlayer = get_node(^"../../AnimationPlayer")
@onready var interactable: MeshInstance3D = get_node(^"..")

var is_pressed: bool = false

func _ready() -> void:
	interactable.mesh = interactable.mesh.duplicate(true)

func primary_text() -> String:
	return "Push"

func primary():
	if is_pressed:
		return
	is_pressed = true
	animation_player.play(&"press")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	is_pressed = false
