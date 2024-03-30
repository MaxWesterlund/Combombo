extends Node

func is_mouse_over_ui(mouse_position):
	var ui_elements = get_tree().get_nodes_in_group("UI")

	for ui_element in ui_elements:
		if ui_element.get_global_rect().has_point(mouse_position):
			return true
