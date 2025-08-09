extends Node3D
class_name Interactable

func primary_text() -> String:
	return ""

func secondary_text() -> String:
	return ""

func increase_text() -> String:
	return ""

func decrease_text() -> String:
	return ""

func primary():
	push_error("Must be implemented in sub class!")

func secondary():
	push_error("Must be implemented in sub class!")

func increase():
	push_error("Must be implemented in sub class!")

func decrease():
	push_error("Must be implemented in sub class!")
