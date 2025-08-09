extends Interactable

const DIMM: StandardMaterial3D = preload("res://Assets/Materials/Text_Inactive.material")
const LIT: StandardMaterial3D = preload("res://Assets/Materials/Text_Active.material")

@onready var animation_player: AnimationPlayer = get_node(^"../../AnimationPlayer")
@onready var lights: Array[MeshInstance3D] = [
	get_node(^"../../Lights/Segment_001"),
	get_node(^"../../Lights/Segment_002"),
	get_node(^"../../Lights/Segment_003"),
	get_node(^"../../Lights/Segment_004"),
	get_node(^"../../Lights/Segment_005"),
	get_node(^"../../Lights/Segment_006"),
	get_node(^"../../Lights/Segment_007"),
	get_node(^"../../Lights/Segment_008"),
	get_node(^"../../Lights/Segment_009"),
	get_node(^"../../Lights/Segment_010"),
	get_node(^"../../Lights/Segment_011"),
	get_node(^"../../Lights/Segment_012"),
	get_node(^"../../Lights/Segment_013"),
	get_node(^"../../Lights/Segment_014"),
	get_node(^"../../Lights/Segment_015"),
	get_node(^"../../Lights/Segment_016"),
	get_node(^"../../Lights/Segment_017"),
	get_node(^"../../Lights/Segment_018"),
	get_node(^"../../Lights/Segment_019"),
	get_node(^"../../Lights/Segment_020"),
	get_node(^"../../Lights/Segment_021"),
	get_node(^"../../Lights/Segment_022"),
	get_node(^"../../Lights/Segment_023"),
	get_node(^"../../Lights/Segment_024"),
	get_node(^"../../Lights/Segment_025"),
	get_node(^"../../Lights/Segment_026"),
	get_node(^"../../Lights/Segment_027"),
	get_node(^"../../Lights/Segment_028"),
	get_node(^"../../Lights/Segment_029"),
	get_node(^"../../Lights/Segment_030"),
	get_node(^"../../Lights/Segment_031"),
	get_node(^"../../Lights/Segment_032"),
	get_node(^"../../Lights/Segment_033"),
	get_node(^"../../Lights/Segment_034"),
	get_node(^"../../Lights/Segment_035"),
	get_node(^"../../Lights/Segment_036"),
	get_node(^"../../Lights/Segment_037"),
	get_node(^"../../Lights/Segment_038"),
	get_node(^"../../Lights/Segment_039"),
	get_node(^"../../Lights/Segment_040"),
	get_node(^"../../Lights/Segment_041"),
	get_node(^"../../Lights/Segment_042"),
	get_node(^"../../Lights/Segment_043"),
	get_node(^"../../Lights/Segment_044"),
	get_node(^"../../Lights/Segment_045"),
	get_node(^"../../Lights/Segment_046"),
	get_node(^"../../Lights/Segment_047"),
	get_node(^"../../Lights/Segment_048"),
	get_node(^"../../Lights/Segment_049"),
	get_node(^"../../Lights/Segment_050"),
	get_node(^"../../Lights/Segment_051"),
	get_node(^"../../Lights/Segment_052"),
	get_node(^"../../Lights/Segment_053"),
	get_node(^"../../Lights/Segment_054"),
	get_node(^"../../Lights/Segment_055"),
	get_node(^"../../Lights/Segment_056"),
	get_node(^"../../Lights/Segment_057"),
	get_node(^"../../Lights/Segment_058"),
	get_node(^"../../Lights/Segment_059"),
	get_node(^"../../Lights/Segment_060"),
	get_node(^"../../Lights/Segment_061"),
	get_node(^"../../Lights/Segment_062"),
	get_node(^"../../Lights/Segment_063"),
	get_node(^"../../Lights/Segment_064"),
	get_node(^"../../Lights/Segment_065"),
	get_node(^"../../Lights/Segment_066"),
	get_node(^"../../Lights/Segment_067"),
	get_node(^"../../Lights/Segment_068"),
	get_node(^"../../Lights/Segment_069"),
	get_node(^"../../Lights/Segment_070"),
	get_node(^"../../Lights/Segment_071"),
	get_node(^"../../Lights/Segment_072"),
	get_node(^"../../Lights/Segment_073"),
	get_node(^"../../Lights/Segment_074"),
	get_node(^"../../Lights/Segment_075"),
	get_node(^"../../Lights/Segment_076"),
	get_node(^"../../Lights/Segment_077"),
	get_node(^"../../Lights/Segment_078"),
	get_node(^"../../Lights/Segment_079"),
	get_node(^"../../Lights/Segment_080"),
	get_node(^"../../Lights/Segment_081"),
	get_node(^"../../Lights/Segment_082"),
	get_node(^"../../Lights/Segment_083"),
	get_node(^"../../Lights/Segment_084"),
	get_node(^"../../Lights/Segment_085"),
	get_node(^"../../Lights/Segment_086"),
	get_node(^"../../Lights/Segment_087"),
	get_node(^"../../Lights/Segment_088"),
	get_node(^"../../Lights/Segment_089"),
	get_node(^"../../Lights/Segment_090"),
	get_node(^"../../Lights/Segment_091"),
	get_node(^"../../Lights/Segment_092"),
	get_node(^"../../Lights/Segment_093"),
	get_node(^"../../Lights/Segment_094"),
	get_node(^"../../Lights/Segment_095"),
	get_node(^"../../Lights/Segment_096"),
	get_node(^"../../Lights/Segment_097"),
	get_node(^"../../Lights/Segment_098"),
	get_node(^"../../Lights/Segment_099"),
	get_node(^"../../Lights/Segment_100")
]

@onready var _module: SignalComponent = get_node(^"../..")

var is_pressed: bool = false
var is_pressed_internal: bool = false

var state: int = 0

@export var update: bool = false:
	set(_value):
		_update_lights()
		if is_pressed_internal:
			_module._set_value(state)

func _ready() -> void:
	for light: MeshInstance3D in lights:
		light.mesh = light.mesh.duplicate()
	_update_lights()

func increase_text() -> String:
	return "Increase"

func decrease_text() -> String:
	return "Decrease"

func increase():
	if is_pressed or state == 100:
		return
	is_pressed = true
	is_pressed_internal = true
	state += 1
	animation_player.play(&"step")

func decrease():
	if is_pressed or state == 0:
		return
	is_pressed = true
	is_pressed_internal = true
	state -= 1
	animation_player.play_backwards(&"step")

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	is_pressed = false
	is_pressed_internal = false

func _set_value(value: int) -> void:
	if value == state:
		return
	elif value not in range(0, 101):
		return
	while value != state:
		if value < state:
			animation_player.play_backwards(&"step")
			await animation_player.animation_finished
			state -= 1
		else:
			animation_player.play(&"step")
			await animation_player.animation_finished
			state += 1

func _update_lights() -> void:
	
	for light: MeshInstance3D in lights.slice(0, state, 1, false):
		light.mesh.set("surface_0/material", LIT)
	
	for light: MeshInstance3D in lights.slice(state, lights.size(), 1, false):
		light.mesh.set("surface_0/material", DIMM)
