---@class SynthB.Joker: SMODS.Joker
SynthB.Joker = SMODS.Joker:extend{
	synthb_song = true,
	atlas = "synthb_placeholder",
	synthb_count = 0,
	synthb_timer = 0,
}

---@class SynthB.Tuning: SMODS.Consumable
SynthB.Tuning = SMODS.Consumable:extend{
	atlas = "synthb_tuning",
	set = "Tuning"
}