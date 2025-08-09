class_name SignalComponent
extends Node

enum DATA_TYPES { INT, BOOL }

#region SIGNAL / FUNCTION
# without prefix
func get_function_names() -> Array[String]:
	return []

func get_function_descriptions() -> Array[String]:
	return []

func get_function_arguments() -> Array[Dictionary]:
	return []

# prefixed with func_
func get_function(_name: String) -> Callable:
	return Callable()
#endregion

#region SIGNAL / SIGNAL
# without prefix
func get_signal_names() -> Array[String]:
	return []

func get_signal_descriptions() -> Array[String]:
	return []

func get_signal_arguments() -> Array[Dictionary]:
	return []

# prefixed with sig_
func get_signal(_name: String) -> Signal:
	return Signal()

#endregion
