extends Interactable

@onready var animation_player: AnimationPlayer = get_node(^"../../AnimationPlayer")
@onready var interactable: MeshInstance3D = get_node(^"..")

@onready var model: SignalComponent = get_node(^"../..")

var is_pressed: bool = false
var is_pressed_internal: bool = false

@export var trigger_on: bool = false:
	set(_value):
		if is_pressed_internal:
			model._trigger(true)

@export var trigger_off: bool = false:
	set(_value):
		if is_pressed_internal:
			model._trigger(false)

func _ready() -> void:
	interactable.mesh = interactable.mesh.duplicate(true)

func primary_text() -> String:
	return "Push"

func primary():
	if is_pressed:
		return
	is_pressed = true
	is_pressed_internal = true
	animation_player.play(&"press")

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	is_pressed = false
	is_pressed_internal = false

func _trigger() -> void:
	if is_pressed:
		return
	is_pressed = true
	animation_player.play(&"press")
