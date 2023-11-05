extends TextEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	var player_name = Game.playerName
	text = 'Hello ' + player_name
