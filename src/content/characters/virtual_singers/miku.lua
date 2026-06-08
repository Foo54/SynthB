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
	synthb_character = "miku",
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
				if context.synthb_mod_scoring.chips_mod and context.synthb_mod_scoring.chips_mod > 0 then
					context.synthb_mod_scoring.chips_mod = context.synthb_mod_scoring.chips_mod * chips
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
			max_boost = 1.75,
		}
	},
	synthb_minor = {
	},
	synthb_major = {
		"j_synthb_needle"
	},
	synthb_character = "miku",
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

SynthB.Character{
	key = "miku_mmj",
	config = {
		extra = {
			min_retrigger = 1,
			max_retrigger = 2,
			cards = 2,
			minor_boost = 1.5,
			major_boost = 2,
		}
	},
	synthb_minor = {

	},
	synthb_major = {

	},
	synthb_character = "miku",
	loc_vars = function(self, info_queue, card)
		return {vars = {SynthB.get_character_loc_vars(card, "cards"), SynthB.get_character_loc_vars(card, "retrigger", nil, true)}}
	end,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			local cards = SynthB.get_character_boosted_value(card, "cards")
			local retriggers = SynthB.get_character_value(card, "retrigger")
			for i, _card in ipairs(context.scoring_hand) do
				if i > cards then break end
				if _card == context.other_card then return {repetitions = retriggers} end
			end
		end
	end,
}

SynthB.Character{
	key = "miku_vbs",
	synthb_character = "miku",
	synthb_minor = {

	},
	synthb_major = {

	},
	config = {
		extra = {
			min_score = 2,
			max_score = 3
		}
	},
	loc_vars = function(self, info_queue, card)
		return {vars = {SynthB.get_character_loc_vars(card, "score")}}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				score = G.GAME.blind.chips * SynthB.get_character_boosted_value(card, "score") / 100
			}
		end
	end,
}

SynthB.Character{
	key = "miku_wxs",
	synthb_character = "miku",
	synthb_minor = {

	},
	synthb_major = {

	},
	config = {
		extra = {
			min_mult = 4,
			max_mult = 8
		}
	},
	loc_vars = function(self, info_queue, card)
		return {vars = {SynthB.get_character_loc_vars(card, "mult")}}
	end,
	calculate = function(self, card, context)
		if context.synthb_mod_scoring then
			local mult = SynthB.get_character_boosted_value(card, "mult")
			local mod = false
			if context.synthb_mod_scoring.mult and context.synthb_mod_scoring.mult > 0 and context.synthb_mod_scoring.mult < mult then
				context.synthb_mod_scoring.mult = mult
				mod = true
			end
			if context.synthb_mod_scoring.mult_mod and context.synthb_mod_scoring.mult_mod > 0 and context.synthb_mod_scoring.mult_mod < mult then
				context.synthb_mod_scoring.mult_mod = mult
				mod = true
			end
			if mod then
				return {
					message = "+!",
					colour = G.C.MULT
				}
			end
		end
	end,
}

SynthB.Character{
	key = "miku_n25",
	synthb_character = "miku",
	synthb_major = {
	},
	synthb_minor = {
		"j_synthb_dna"
	},
	config = {
		extra = {
			min_hands = 1,
			max_hands = 2
		},
		immutable = {
			mem_hands = nil
		}
	},
	loc_vars = function(self, info_queue, card)
		local hands = SynthB.get_character_loc_vars(card, "hands", nil, true)
		if type(hands) == "string" then return {vars = {hands, "s"}} end
		local _, boost = SynthB.get_character_boost(card)
		hands = hands + boost
		return {vars = {hands, hands > 1 and "s" or ""}}
	end,
	add_to_deck = function(self, card, context)
		local hands = SynthB.get_character_value(card, "hands")
		local _, boost = SynthB.get_character_boost(card)
		hands = hands + boost
		G.GAME.round_resets.hands = G.GAME.round_resets.hands + hands
		ease_hands_played(hands)
	end,
	remove_from_deck = function (self, card, from_debuff)
		local hands = SynthB.get_character_value(card, "hands")
		local _, boost = SynthB.get_character_boost(card)
		hands = hands + boost
		G.GAME.round_resets.hands = G.GAME.round_resets.hands - hands
		ease_hands_played(-hands)
	end,
	update = function (self, card, dt)
		-- TODO, maybe
		-- Speed this up, as this is a lot of stuff to do every frame
		-- maybe refactor into a context call
		local hands = SynthB.get_character_value(card, "hands")
		local _, boost = SynthB.get_character_boost(card)
		hands = hands + boost
		if card.ability.immutable.mem_hands ~= nil and card.ability.immutable.mem_hands ~= hands then
			local dif = hands - card.ability.immutable.mem_hands
			G.GAME.round_resets.hands = G.GAME.round_resets.hands + dif
			ease_hands_played(dif)
		end
		card.ability.immutable.mem_hands = hands
	end
}