extends Node

const save_path = "res://savegame.bin"

func SaveGame():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
#	var data: Dictionary = {}
	var data = {
		"playerHP": Game.playerHP,
		"Gold": Game.Gold
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)

func LoadGame():
	var file = FileAccess.open(save_path, FileAccess.READ)
	if FileAccess.file_exists(save_path):
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Game.playerHP = current_line["playerHP"]
				Game.Gold = current_line["Gold"]
				
			
			
			
