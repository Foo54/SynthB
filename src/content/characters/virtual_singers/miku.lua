SynthB.Character{
	key = "miku1",
	config = {
		extra = {
			min_chips = 1.25,
			max_chips = 2,
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
		return {vars = {SynthB.get_character_loc_vars(card, "chips"), card.ability.extra.count}}
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
			min_boost = 1.25,
			max_boost = 2,
		}
	},
	synthb_minor = {
	},
	synthb_major = {
		"j_synthb_needle"
	},
	loc_vars = function(self, info_queue, card)
		return {vars = {SynthB.get_character_loc_vars(card, "boost")}}
	end,
	calculate = function(self, card, context)
		if context.synthb_mod_poker_hand_scaling then
			local boost = SynthB.get_character_boosted_value(card, "boost")
			context.synthb_dif = context.synthb_dif * boost
			return {
				message = "X" .. number_format(boost),
				colour = G.ARGS.LOC_COLOURS.planet
			}
		end
	end,
}



