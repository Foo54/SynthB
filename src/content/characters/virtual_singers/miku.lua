SynthB.Character{
	key = "miku1",
	config = {
		extra = {
			min_chips = 1.25,
			max_chips = 2,
			minor_boost = 1.25,
			major_boost = 1.5,
			count = 10
		},
		immutable = {
			counted = 0
		}
	},
	synthb_minor = {
		"j_synthb_needle",
		"j_synthb_dna",

	}, -- every single song used in other characters
	loc_vars = function(self, info_queue, card)
		local chips = SynthB.get_character_boosted_value(card, "chips")
		return {vars = {(card.fake_card or (card.area and card.area.config.collection)) and (card.ability.extra.min_chips .. "/" .. card.ability.extra.max_chips) or chips, card.ability.extra.count}}
	end,
	calculate = function(self, card, context)
		if context.press_play then
			card.ability.immutable.counted = 0
		end
		if context.synthb_mod_scoring then
			if card.ability.immutable.counted <= card.ability.extra.count then
				local chips = SynthB.get_character_boosted_value(card, "chips")
				local mod = false
				if context.synthb_mod_scoring.chips and context.synthb_mod_scoring.chips > 0 then
					context.synthb_mod_scoring.chips = context.synthb_mod_scoring.chips * chips
					card.ability.immutable.counted = card.ability.immutable.counted + 1
					mod = true
				end
				if context.synthb_mod_scoring.mod_chips and context.synthb_mod_scoring.mod_chips > 0 then
					context.synthb_mod_scoring.mod_chips = context.synthb_mod_scoring.mod_chips * chips
					card.ability.immutable.counted = card.ability.immutable.counted + 1
					mod = true
				end
				if mod then
					return {
						message = "X" .. number_format(chips),
						colour = G.C.CHIPS
					}
				end
			end
		end
	end,
}

SynthB.Character{
	key = "miku_ln",
	config = {
		extra = {

		}
	},
}