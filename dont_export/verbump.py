import json
from datetime import date

if __name__ == "__main__":
	path = "C:\\Users\\foo54\\AppData\\Roaming\\Balatro\\Mods\\SynthB\\dont_export\\version_data.json"
	data = json.load(open(path))

	if data["change"]:
		data["change"] = True
		d = date.today()
		da = f'{d.year % 100:0>2}{d.month:0>2}{d.day:0>2}'
		if da != data["date"]:
			data["date"] = da
			data["rev"] = [0]
		else:
			i = len(data["rev"]) - 1
			while i >= 0:
				data["rev"][i] += 1
				if data["rev"][i] >= 26:
					data["rev"][i] = 0
					if i == 0:
						data["rev"].insert(0, 0)
					else:
						i -= 1
				else:
					break
		file = open(path, "w")
		json.dump(data, file, indent = 2)
		file.close()
	version = f"{data['major']}.{data['minor']}.{data['patch']}-{data['date']}{''.join(['abcdefghijklmnopqrstuvwxyz'[n] for n in data['rev']])}"
	print(version)
	
	VERSION_LUA_PATH = "C:\\Users\\foo54\\AppData\\Roaming\\Balatro\\Mods\\SynthB\\VERSION.lua"
	version_lua = open(VERSION_LUA_PATH, "w")
	version_lua.write(f'return "{data["prefix"]}-{version}"')
	version_lua.close()

	CONFIG_JSON_PATH = "C:\\Users\\foo54\\AppData\\Roaming\\Balatro\\Mods\\SynthB\\config.json"
	config_json_data = json.load(open(CONFIG_JSON_PATH))
	config_json_data["version"] = version
	config_json = open(CONFIG_JSON_PATH, "w")
	json.dump(config_json_data, config_json, indent=2)
	config_json.close()


