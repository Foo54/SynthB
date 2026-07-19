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

---@class SynthB.Sign: SMODS.Consumable
SynthB.Sign = SMODS.Consumable:extend{
	atlas = "synthb_streetcat",
	set = "synthb_Sign",
	synthb_song = "song_synthb_streetcat",
	synthb_count = 0,
	synthb_timer = 0,
	synthb_credits = {
		Artist = "Foo54"
	},
}