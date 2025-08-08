extends Node3D
class_name Interactable

func primary_text() -> String:
	return ""

func secondary_text() -> String:
	return ""

func primary():
	push_error("Must be implemented in sub class!")

func secondary():
	push_error("Must be implemented in sub class!")
