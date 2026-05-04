SynthB = SynthB or {}

SynthB.mod = SMODS.current_mod

SynthB.Globals = SynthB.Globals or {}

SynthB.GUI = {}

SynthB.custom_colors = {
	LIGHT_GREEN = HEX("99e550"),
}

--- Prefaces print statements with some information, and doesn't do anything if debug is off
function SynthB.debug(...) 
	if SynthB.mod.config.DEBUG then
		print("SynthB | ", ...)
	end
end

--- wrap load_file with assert
function SynthB.load_file (file_name) assert(SMODS.load_file("src/" .. file_name .. ".lua"))() end

SynthB.debug("Loading Files")

SynthB.debug("Loading Utility Files")
SynthB.load_file("util/util")
SynthB.load_file("util/songs")

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

SynthB.debug("Loading Content Files")
SynthB.load_file("content/shader")
SynthB.load_file("content/jokers/page 1")
SynthB.load_file("content/jokers/page 2")
SynthB.load_file("content/jokers/page 3")
SynthB.load_file("content/edition")
