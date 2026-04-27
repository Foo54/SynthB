SynthB = SynthB or {}

SynthB.mod = SMODS.current_mod
SynthB.DEBUG = false

--- Prefaces print statements with some information, and doesn't do anything if debug is off
function SynthB.debug(...) 
	if SynthB.DEBUG then
		print("SynthB | ", ...)
	end
end

--- wrap load_file with assert
function SynthB.load_file (file_name) assert(SMODS.load_file("src/" .. file_name .. ".lua"))() end

SynthB.debug("Loading Files")
SynthB.debug("Loading Utility Files")
SynthB.load_file("util/util")

SynthB.debug("Loading API Files")
SynthB.load_file("api/attributes")
SynthB.load_file("api/atlas")
SynthB.load_file("api/mod_object")

SynthB.debug("Loading Content Files")
SynthB.load_file("content/joker")
