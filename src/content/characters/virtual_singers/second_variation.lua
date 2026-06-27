SynthB.Character{
	key = "rin2",
	pos = {x = 5, y = 4},
	synthb_character = "rin",
	config = {
		extra = {
			min_money = 1,
			max_money = 2
		}
	},
	loc_vars = function(self, info_queue, card)
		return {vars = {SynthB.get_character_loc_vars(card, "money")}}
	end,
	calculate = function(self, card, context)
		if context.individual and context.other_card.repetition_trigger then
			return {
				dollars = SynthB.get_character_boosted_value(card, "money")
			}
		end
	end,
}

SynthB.Character{
	key = "len2",
	pos = {x = 6, y = 4},
	synthb_character = "len",
	config = {
		extra = {
			min_xscore = 1.1,
			max_xscore = 1.2
		}
	},
	loc_vars = function(self, info_queue, card)
		return {vars = {SynthB.get_character_loc_vars(card, "xscore")}}
	end,
	calculate = function(self, card, context)
		if context.other_joker then
			return {
				xscore = SynthB.get_character_boosted_value(card, "xscore")
			}
		end
	end,
}

SynthB.Character{
	key = "luka2",
	pos = {x = 7, y = 4},
	synthb_character = "luka",
	config = {
		extra = {
			min_chips = 5,
			max_chips = 10
		}
	},
	synthb_major = {
		"j_synthb_needle"
	},
	loc_vars = function(self, info_queue, card)
		return {vars = {SynthB.get_character_loc_vars(card, "chips")}}
	end,
	calculate = function(self, card, context)
		if context.before then
			G.GAME.hands[context.scoring_name].chips = G.GAME.hands[context.scoring_name].chips + SynthB.get_character_boosted_value(card, "chips")
			return nil, true
		end
	end,
}

SynthB.Character{
	key = "meiko2",
	pos = {x = 8, y = 4},
	synthb_character = "meiko",
	config = {
		extra = {
			min_xmult = 2,
			max_xmult = 3
		},
		immutable = {
			last_scored = math.huge
		}
	},
	loc_vars = function(self, info_queue, card)
		return {vars = {SynthB.get_character_loc_vars(card, "xmult"), card.ability.immutable.last_scored}}
	end,
	calculate = function(self, card, context)
		if context.after then
			card.ability.immutable.last_scored = SMODS.calculate_round_score()
		end
		if context.final_scoring_step then
			if SMODS.calculate_round_score() < card.ability.immutable.last_scored then
				return {
					xmult = SynthB.get_character_boosted_value(card, "xmult")
				}
			end
		end
	end,
}

SynthB.Character{
	key = "kaito2",
	pos = {x = 9, y = 4},
	synthb_character = "kaito",
	config = {
		extra = {
			min_scaling = 1.25,
			max_scaling = 1.5
		}
	},
	loc_vars = function(self, info_queue, card)
		return {vars = {SynthB.get_character_loc_vars(card, "scaling")}}
	end,
	calc_scaling = function(self, card, other_card, initial_value, scalar_value, args)
		return {
			override_scalar_value = {
				value = scalar_value * SynthB.get_character_boosted_value(card, "scaling")
			}
		}
	end
}