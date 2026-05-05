# SynthB
Vocaloid Themed Balatro Mod by Foo54

## Content
- 35 New Jokers!
	- 14 Voicebanks
	- 30 Artists
	- Links to all the songs
- 4 New Editions!
- New Mechanic!
	- Temperature: High temp increases stats of some cards, but go too high and face the consequences
- Crossmod Content
	- [Feli's Jokeria](https://github.com/LasagnaFelidae/Balatro-FelisJokeria)
- Crossmod Support
	- Cryptid Forcetriggers
	- Paperback Music Attribute

## Crossmod API
When implementing crossmod songs, make sure the following standards are met:
- `descriptions.SongInfo` entry in the following format
	```lua
	song_key = {
		text = {
			"{C:attention}Title",
			"Official name",
			"{C:inactive,s:0.8}english name", -- only needed if song title isn't english
			"{C:attention}Producer:",
			"producer 1{C:inactive} & {}producer 2",
			"{C:inactive,s:0.8}producer 1 english & producer 2 english", -- only needed if producer's name isn't english
			"{C:attention}Voice:",
			"voicebank 1{C:inactive} & {}voicebank 2",
			"{C:inactive,s:0.8}voicebank 1 english & voicebank 2 english" -- only needed if voicebank's name isn't english
		}
	}
	```
	This information can be displayed by running `SynthB.song_info(info_queue, "song_key")` in the cards `loc_vars`
- `descriptions.Joker.key.name` entry in the following format
	```lua
	name = {
		"official name",
		"{s:0.7}english name" -- only needed if song title isn't english
	},
	text = {
		"card effects stuff",
		"{C:inactive,s:0.8}lyrics from the song, preferably related to the effect"
	}
	```
- Songs should be defined via SynthB.Joker or should have the following keys in their definition
	```lua
	synthb_song = true, -- passing in true is the same as passing in the jokers key without "j_modprefix_"
	synthb_count = 0,
	synthb_timer = 0,
	```
- Songs should have the `song` and `vocaloid song` attributes, along with attributes for the voicebank(s) and producer(s)
- Atlas containing `300x300` covers for added songs with a `1px` buffer
- data for each song inserted via `SynthB.inject_song_data`
	```lua
	SynthB.inject_song_data{
		key = "key" -- related card's key without "j_modprefix_",
		prefix = "j_modprefix_",
		link = "official youtube or niconico link to the song",
		atlas = "cover art atlas key mentioned above",
		pos = {x = 0, y = 0} -- position on the atlas
	}
	--- providing a list of these tables is also valid
	```
If your mod is loaded before SynthB, include the file `SynthB.lua` in your mods folder. This file will be loaded after SynthB is finished loading.
An example of what to do can be found in SynthB/extra/examples/joker.lua