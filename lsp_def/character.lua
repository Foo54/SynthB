---@meta


---@class SynthB.Character: SMODS.Center
---@field synthb_minor? string[] list of keys to songs that give a minor boost to the card
---@field synthb_major? string[] list of keys to sogns that give a major boost to the card
---@field synthb_character string characters name, excluding variations
---@overload fun(self: SynthB.Character): SynthB.Character
SynthB.Character = setmetatable({}, {
	__call = function(self)
		return self
	end
})