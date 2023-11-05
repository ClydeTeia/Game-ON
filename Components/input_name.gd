extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	grab_focus()
	set_caret_column(len(text))


func _on_text_submitted(new_text):
	Game.playerName = new_text
	print('Hello ' + Game.playerName)
	get_tree().change_scene_to_file("res://Cutscenes/scene0.tscn")
