SynthB = SynthB or {}

SynthB.mod = SMODS.current_mod

SynthB.Globals = SynthB.Globals or {}

SynthB.GUI = {}

SynthB.custom_colors = {
	LIGHT_GREEN = HEX("99e550"),
	TUNING = HEX("00FFFF"),
	TUNING_DARK = darken(HEX("00FFFF"), 0.1),
	TETO = HEX("E54C75"),
	ENERGY_DRINK = HEX("F0EC11"),
	energy_drink = {
		ORANGE = HEX("EF8A10"),
		STRAWBERRY = HEX("EC2053"),
		BANANA = HEX("E9ED1C"),
		RASPBERRY = HEX("E61A21"),
		GRAPE = HEX("E11191"),
		MELON = HEX("11DA4E"),
		TRITIP = HEX("E95C5C"),
		DURIAN = HEX("0F7917")
	}
}

--- Prefaces print statements with some information, and doesn't do anything if debug is off
function SynthB.debug(...) 
	if SynthB.mod.config.DEBUG then
		print("SynthB |", ...)
	end
end

--- wrap load_file with assert
function SynthB.load_file (file_name) assert(SMODS.load_file("src/" .. file_name .. ".lua"))() end

SynthB.debug("Loading Files")

SynthB.debug("Loading Utility Files")
SynthB.load_file("util/util")
SynthB.load_file("util/songs")
SynthB.load_file("util/effect")

SynthB.debug("Loading API Files")
SynthB.load_file("api/extentions")
SynthB.load_file("api/hooks")
SynthB.load_file("api/attributes")
SynthB.load_file("api/atlas")
SynthB.load_file("api/mod_object")
SynthB.load_file("api/mod_badge")
SynthB.load_file("api/game")
SynthB.load_file("api/useable_joker")
SynthB.load_file("api/uidef")
SynthB.load_file("api/ownership")
SynthB.load_file("api/drawstep")
SynthB.load_file("api/sound")

SynthB.debug("Loading Content Files")
SynthB.load_file("content/shader")
SynthB.load_file("content/jokers/page 1")
SynthB.load_file("content/jokers/page 2")
SynthB.load_file("content/jokers/page 3")
--SynthB.load_file("content/jokers/page 4")
SynthB.load_file("content/tuning/tuning")
SynthB.load_file("content/tuning/page 1")
SynthB.load_file("content/spectral")
SynthB.load_file("content/edition")
--SynthB.load_file("content/back")
SynthB.load_file("content/seal")
SynthB.load_file("content/sticker")
--SynthB.load_file("content/tag")

SynthB.debug("Loading Crossmod Files")
-- cross mod loading modified from aikoshen
for _,mod in pairs(SMODS.Mods) do
	if mod.can_load and mod.path and not mod.meta_mod then
		pcall(function ()
			local p = SMODS.load_file("SynthB.lua", mod.id)
			if p then
				p()
			end
		end)
	end
end
