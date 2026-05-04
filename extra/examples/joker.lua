-- LOCALIZATION FILE
local localize_out = { -- storing as a local variable isn't needed I just need this to be valid lua
	descriptions = {
		Joker = {
			j_foobar_parry = {
				name = {"{f:5}パリィ", "{s:0.7}Parry"},
				text = {
					"does something really cool",
					"{C:inactive,s:0.8,f:5}刻み込まれた腕章と突っ切る"
				}
			}
		},
		SongInfo = {
			parry = {
				"{C:attention}Title",
				"{f:5}パリィ",
				"{C:inactive,s:0.8}Parry",
				"{C:attention}Producer:",
				"{f:5}宮守文学",
				"{C:inactive,s:0.8}Miyamori Bungaku",
				"{C:attention}Voice:",
				"{f:5}鏡音レン{C:inactive} & {f:5}鏡音リン",
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
	attributes = {"song", "vocaloid song", "Len", "Miku", "Miyamori Bungaku"}
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
	link = "https://www.youtube.com/watch?v=p9F__9fciRo",
	atlas = "foobar_covers",
	pos = {x = 0, y = 0}
}