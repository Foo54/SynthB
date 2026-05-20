import json
from datetime import date
import file_paths
'''
file_paths.py
VERSION_DATA = path to version_data.json
VERSION = path to VERSION.lua
CONFIG = path to config.json
'''

if __name__ == "__main__":
	data = json.load(open(file_paths.VERSION_DATA))

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
		file = open(file_paths.VERSION_DATA, "w")
		json.dump(data, file, indent = 2)
		file.close()
	version = f"{data['major']}.{data['minor']}.{data['patch']}-{data['date']}{''.join(['abcdefghijklmnopqrstuvwxyz'[n] for n in data['rev']])}"
	print(version)

	version_lua = open(file_paths.VERSION, "w")
	version_lua.write(f'return "{data["prefix"]}-{version}"')
	version_lua.close()
	config_json_data = json.load(open(file_paths.CONFIG))
	config_json_data["version"] = version
	config_json = open(file_paths.CONFIG, "w")
	json.dump(config_json_data, config_json, indent=2)
	config_json.close()


