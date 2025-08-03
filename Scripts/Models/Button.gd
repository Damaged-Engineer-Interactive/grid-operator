extends Node3D

@export_group("Colors", "color_")
@export var color_base: Color = Color.BLACK
@export var color_case: Color = Color.BLACK
@export var color_handle: Color = Color.BLACK

func _ready() -> void:
	%Base.mesh.surface_get_material(0).albedo_color = color_base
	%Button.mesh.surface_get_material(0).albedo_color = color_case
	%Interactable.mesh.surface_get_material(0).albedo_color = color_handle
