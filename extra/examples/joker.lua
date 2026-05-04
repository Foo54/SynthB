-- LOCALIZATION FILE
local localize_out = { -- storing as a local variable isn't needed I just need this to be valid lua
	descriptions = {
		Joker = {
			j_foobar_parry = {
				name = {"{f:5}TEMP", "{s:0.7}Parry"},
				text = {
					"does something really cool",
					"{C:inactive,s:0.8,f:5}TEMP"
				}
			}
		},
		SongInfo = {
			parry = {
				"{C:attention}Title",
				"{f:5}TEMP",
				"{C:inactive,s:0.8}Parry",
				"{C:attention}Producer:",
				"{f:5}TEMP",
				"{C:inactive,s:0.8}temp",
				"{C:attention}Voice:",
				"{f:5}temp{C:inactive} & {f:5}temp",
				"{C:inactive,s:0.8}Kagamine Len & Kagamine Rin"
			}
		}
	}
}

-- OTHER FILES
SynthB.Joker{
	key = "parry",
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "parry")
	end,
}

SMODS.Atlas{
	key = "covers",
	path = "cover_art.png",
	px = 302,
	py = 302
}

SynthB.inject_song_data{
	key = "parry",
	prefix = "j_foobar_",
	link = "TEMP",
	atlas = "foobar_covers",
	pos = {x = 0, y = 0}
}