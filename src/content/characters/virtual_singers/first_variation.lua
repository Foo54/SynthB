SynthB.Character{
	key = "rin1",
	synthb_character = "rin",
	synthb_minor = SynthB.character_song_list,
	synthb_major = SynthB.character_major_song_list,
	pos = {x = 5, y = 2},
	config = {
		extra = {
			min_dollars = 1,
			max_dollars = 2,
		}
	},
	loc_vars = function(self, info_queue, card)
		return {vars = {SynthB.get_character_loc_vars(card, "dollars")}}
	end,
	calculate = function(self, card, context)
		if context.money_altered and context.amount > 0 and not SynthB.Globals.dont_mod_money then
			local dollars = SynthB.get_character_boosted_value(card, "dollars")
			SynthB.Globals.dont_mod_money = true
			if not SynthB.mod.config.disable_non_scoring_character_animations then delay(0.5) end
			ease_dollars(dollars, SynthB.mod.config.disable_non_scoring_character_animations)
			SynthB.Globals.dont_mod_money = false
			return SynthB.character_optional_return(card, {
				message = "+$" .. number_format(dollars),
				colour = G.C.MONEY
			})
		end
	end,
}

SynthB.Character{
	key = "len1",
	synthb_character = "len",
	synthb_minor = SynthB.character_song_list,
	synthb_major = SynthB.character_major_song_list,
	pos = {x = 6, y = 2},
	config = {
		extra = {
			min_dollars = 1,
			max_dollars = 2,
		}
	},
	loc_vars = function(self, info_queue, card)
		return {vars = {SynthB.get_character_loc_vars(card, "dollars")}}
	end,
	calculate = function(self, card, context)
		if context.money_altered and context.amount < 0 and not SynthB.Globals.dont_mod_money then
			local dollars = math.min(-context.amount, SynthB.get_character_boosted_value(card, "dollars"))
			SynthB.Globals.dont_mod_money = true
			if not SynthB.mod.config.disable_non_scoring_character_animations then delay(0.5) end
			ease_dollars(dollars, SynthB.mod.config.disable_non_scoring_character_animations)
			SynthB.Globals.dont_mod_money = false
			return SynthB.character_optional_return(card, {
				message = "+$" .. number_format(dollars),
				colour = G.C.MONEY
			})
		end
	end,
}

SynthB.Character{
	key = "luka1",
	synthb_character = "luka",
	synthb_minor = SynthB.character_song_list,
	synthb_major = SynthB.character_major_song_list,
	pos = {x = 7, y = 2},
	config = {
		extra = {
			min_gain = 1,
			max_gain = 2,
			chips = 0
		}
	},
	loc_vars = function(self, info_queue, card)
		local gain = SynthB.get_character_loc_vars(card, "gain")
		return {vars = {gain, (type(gain) == "string" or gain ~= 1) and "s" or "", card.ability.extra.chips, card.ability.extra.chips > 1 and "s" or ""}}
	end,
	calculate = function(self, card, context)
		if context.synthb_character_triggered and not context.retrigger_joker then
			local gain = SynthB.get_character_boosted_value(card, "gain")
			card.ability.extra.chips = card.ability.extra.chips + gain
			return SynthB.character_optional_return(card, {
				message = "+" .. number_format(gain),
				colour = G.C.CHIPS
			})
		end
		if context.joker_main then
			return {
				chips = card.ability.extra.chips
			}
		end
	end,
}

SynthB.Character{
	key = "meiko1",
	synthb_character = "meiko",
	synthb_minor = SynthB.character_song_list,
	synthb_major = SynthB.character_major_song_list,
	pos = {x = 8, y = 2},
	config = {
		extra = {
			min_scored = 1,
			max_scored = 2,
		},
		immutable = {
			scored = 0
		}
	},
	loc_vars = function(self, info_queue, card)
		local scored = SynthB.get_character_value(card, "scored")
		local _, boost = SynthB.get_character_boost(card)
		local scored_txt = SynthB.get_character_loc_vars(card, "scored", nil, true)
		return {vars = {type(scored_txt) == "string" and scored_txt or (scored + boost), (type(scored_txt) == "string" or (scored + boost ~= 1)) and "s" or ""}}
	end,
	calculate = function(self, card, context)
		if context.press_play then
			card.synthb_scored = {}
		end
		if context.setting_blind then
			card.ability.immutable.scored = 0
		end
		if context.individual and context.cardarea == G.play then
			local scored = SynthB.get_character_value(card, "scored")
			local _, boost = SynthB.get_character_boost(card)
			scored = scored + boost
			if not card.synthb_scored[context.other_card] then
				card.synthb_scored[context.other_card] = true
				for _, _card in ipairs(context.scoring_hand) do
					if card.ability.immutable.scored < scored then
						if _card == context.other_card then
							if not context.retrigger_joker then card.ability.immutable.scored = card.ability.immutable.scored + 1 end
							context.other_card:set_ability(SMODS.poll_enhancement{guaranteed = true})
							card.synthb_triggered = true
							return nil, true
						end
					end
				end
			end
		end
	end,
}

SynthB.Character{
	key = "kaito1",
	synthb_character = "kaito",
	synthb_minor = SynthB.character_song_list,
	synthb_major = SynthB.character_major_song_list,
	pos = {x = 9, y = 2},
	config = {
		extra = {
			min_retriggers = 1,
			max_retriggers = 2,
			num = 1,
			dem = 2
		}
	},
	loc_vars = function(self, info_queue, card)
		local _, prob_boost = SynthB.get_character_boost(card)
		local num, dem = SMODS.get_probability_vars(card, card.ability.extra.num + prob_boost, card.ability.extra.dem + prob_boost, "synthb_kaito_retrigger")
		local retriggers = SynthB.get_character_loc_vars(card, "retriggers", nil, true)
		return {vars = {retriggers, (type(retriggers) == "string" or retriggers ~= 1) and "s" or "", num, dem}}
	end,
	calculate = function(self, card, context)
		if context.retrigger_joker_check then
			if context.other_card.area == G.synthb_character_area then
				if context.other_card.rank == card.rank - 1 then
					local possible_retriggers = SynthB.get_character_value(card, "retriggers")
					local _, prob_boost = SynthB.get_character_boost(card)
					local retriggers = 0
					for _ = 1, possible_retriggers do if SMODS.pseudorandom_probability(card, "synthb_kaito_retrigger", card.ability.extra.num + prob_boost, card.ability.extra.dem + prob_boost) then retriggers = retriggers + 1 end end
					if retriggers > 0 then
						return {
							repetitions = retriggers
						}
					end
				end
			end
		end
	end,
}