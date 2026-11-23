extends Control




func _on_start_btn_button_up() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")


func _on_credits_button_up() -> void:
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")


func _on_exit_btn_button_up() -> void:
	get_tree().quit()
