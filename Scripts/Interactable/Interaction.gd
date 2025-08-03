extends RayCast3D

var current_collider

@onready var interaction_label = get_node(^"/root/World/UI/InteractionLabel/InteractionLabel")

func _ready() -> void:
	set_interaction_text()

func _process(_delta: float) -> void:
	var collider = get_collider()
	
	if is_colliding() and collider is Interactable:
		if current_collider != collider:
			current_collider = collider
			set_interaction_text(collider.get_interaction_text())
		
		if Input.is_action_just_pressed(&"interact"):
			collider.interact()
			set_interaction_text(collider.get_interaction_text())
	elif current_collider:
		current_collider = null
		set_interaction_text()

func set_interaction_text(text: String = ""):
	if not interaction_label:
		return
	
	if !text:
		interaction_label.set_text("")
		interaction_label.get_parent().hide()
	else:
		interaction_label.set_text("Click to %s" % text)
		interaction_label.get_parent().show()
	
