---@meta


---@class SynthB.Credits.Contributor: SMODS.Joker
---@field create_area? fun(self: SynthB.Credits.Contributor, w?: number, h?: number, extra_params?: table): CardArea Creates the card area for the credits
---@field create_sprite? fun(self: SynthB.Credits.Contributor, area: CardArea, extra_params?: table): SMODS.Joker creates the joker for the credits and emplaces it into the provided area
---@field hover? fun(self: SynthB.Credits.Contributor) called when the card is hovered while in the credits
---@field stop_hover? fun(self: SynthB.Credits.Contributor) called when the card is not hovered while in the credits
---@field click? fun(self: SynthB.Credits.Contributor) called when the card is clicked in the credits
---@field name string name to display during the option cycle
---@field synthb_role {coders: boolean?, artists: boolean?, artists2: boolean?, music: boolean?} your role(s) in the mod
---@field custom_ui? fun(self: SynthB.Credits.Contributor): table complete control of the credit UI
---@overload fun(self: SynthB.Credits.Contributor): SynthB.Credits.Contributor
SynthB.Credits.Contributor = setmetatable({}, {
	__call = function(self)
		return self
	end
})