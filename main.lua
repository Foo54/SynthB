SynthB = SynthB or {}

SynthB.mod = SMODS.current_mod
SynthB.DEBUG = true

--- Prefaces print statements with some information, and doesn't do anything if debug is off
function SynthB.debug(...) 
	if SynthB.DEBUG then
		print("SynthB | ", ...)
	end
end

--- wrap load_file with assert
function SynthB.load_file (file_name) assert(SMODS.load_file(file_name))() end

SynthB.debug("Loading Files")
SynthB.debug("Loading Utility Files")

SynthB.debug("Loading API Files")

SynthB.debug("Loading Content Files")
SynthB.load_file("src/content/joker.lua")