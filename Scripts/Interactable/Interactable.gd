extends Node3D
class_name Interactable

func get_interaction_text():
	return "Interact"

func primary():
	push_error("Must be implemented in sub class!")

func secondary():
	push_error("Must be implemented in sub class!")
