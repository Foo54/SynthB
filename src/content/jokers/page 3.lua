--- Page 3


-- Spot Late
SynthB.Joker{
	key = "spot_late",
	pos = {x = 1, y = 0},
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			gain = 2,
			mult = 0
		}
	},
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	attributes = {"mult", "scaling", "song", "vocaloid song", "inabakumori", "yuki"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "spot_late")
		return {vars = {card.ability.extra.gain, card.ability.extra.mult}}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.gain
			return {
				mult = card.ability.extra.mult
			}
		end
		if context.before then
			if G.jokers.cards[1] == card then
				card.ability.extra.mult = math.max(0, card.ability.extra.mult - card.ability.extra.gain)
			else
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.gain
			end
		end
		if context.joker_main and G.jokers.cards[1] == card then
			return {
				mult = card.ability.extra.mult
			}
		end
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{ text = "+" },
				{ ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
			},
			text_config = { colour = G.C.MULT },
			calc_function = function (card)
				card.joker_display_values.mult = G.jokers.cards[1] == card and card.ability.extra.mult or 0
			end
		}
	end
}

-- Heat Abnormal
SynthB.Joker{
	key = "heat_abnormal",
	pos = {x = 2, y = 0},
	rarity = 3,
	cost = 8,
	config = {
		extra = {
			raise = 1,
			gain = 8,
			limit = 100
		}
	},
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	attributes = {"chips", "scaling", "modify_card", "temperature", "song", "vocaloid song", "Iyowa", "Rei"},
	loc_vars = function(self, info_queue, card)
		SynthB.heat_info(info_queue)
		SynthB.song_info(info_queue, "heat_abnormal")
		return {vars = {card.ability.extra.gain, card.ability.extra.limit, card.ability.extra.gain * math.floor((G.GAME or {}).synthb_temp or 0), card.ability.extra.raise}}
	end,
	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
			return {
				chips = card.ability.extra.gain * math.floor(G.GAME.synthb_temp or 0)
			}
		end
		if context.individual and context.cardarea == G.play then
			SynthB.ease_temp(1)
		end
	end,
	can_use = function(self, card)
		return (G.GAME.synthb_temp or 0) >= card.ability.extra.limit and G.hand and G.hand.cards and #G.hand.cards > 0
	end,
	use = function(self, card)
		SynthB.ease_temp(-card.ability.extra.limit)
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.4,
			func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
				return true
			end
		}))
		for i = 1, #G.hand.cards do
			local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					G.hand.cards[i]:flip()
					play_sound('card1', percent)
					G.hand.cards[i]:juice_up(0.3, 0.3)
					return true
				end
			}))
		end
		delay(0.2)
		for i = 1, #G.hand.cards do
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					G.hand.cards[i]:set_ability(SMODS.poll_enhancement{guaranteed = true}, true, true)
					return true
				end
			}))
		end
		for i = 1, #G.hand.cards do
			local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					G.hand.cards[i]:flip()
					play_sound('tarot2', percent, 0.6)
					G.hand.cards[i]:juice_up(0.3, 0.3)
					return true
				end
			}))
		end
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.2,
			func = function()
				G.hand:unhighlight_all()
				return true
			end
		}))
		delay(0.5)
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{ text = "+", colour = G.C.CHIPS },
				{ ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult", colour = G.C.CHIPS },
				{ text = " "},
				{
					border_nodes = {
						{text = "+"},
						{ref_table = "card.joker_display_values", ref_value = "heat", retrigger_type = "mult"}
					},
					border_colour = G.C.ORANGE
				}
			},
			calc_function = function (card)
				local heat = 0
				local text, _, scoring_hand = JokerDisplay.evaluate_hand()
				if text ~= 'Unknown' then
					for _, scoring_card in pairs(scoring_hand) do
						heat = heat + card.ability.extra.raise * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
					end
				end
				card.joker_display_values.heat = heat
				card.joker_display_values.chips = card.ability.extra.gain * ((G.GAME.synthb_temp or 0) + (G.play and G.play.cards and #G.play.cards == 0 and heat or 0))
			end
		}
	end
}

-- Spoken For
SynthB.Joker{
	key = "spoken_for",
	cost = 5,
	config = {
		extra = {
			mult = 30
		}
	},
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	demicolon_compat = true,
	attributes = {"mult", "chance", "song", "vocaloid song", "Teto", "Flavor Foley"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "spoken_for")
		return {vars = {card.ability.extra.mult}}
	end,
	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
			return {
				mult = card.ability.extra.mult * (SMODS.pseudorandom_probability(card, "synthb_spoken_for", 1, 2, nil, true) and 1 or -1)
			}
		end
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{ text = "+/- " },
				{ ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" }
			},
			text_config = {colour = G.C.MULT}
		}
	end
}

-- Hello, World!
SynthB.Joker{
	key = "hello_world",
	pos = {x = 1, y = 0},
	rarity = 2,
	cost = 7,
	config = {
		immutable = {
			active = true
		}
	},
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	demicolon_compat = false,
	attributes = {"passive", "song", "vocaloid song", "Motoo Fujiwara", "Miku"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "hello_world")
		local cardarea = CardArea(G.ROOM.T.x, G.ROOM.T.y, G.CARD_W * 0.7, G.CARD_H * 0.7, {
			type = 'title_2', card_limit = 1, highlight_limit = 0
		})
		if G.deck and G.deck.cards and #G.deck.cards > 0 and not (card.area and card.area.config.collection) then
			cardarea:emplace(copy_card(G.deck.cards[#G.deck.cards], nil, 0.7))
		end
		return {vars = {elements = {cardarea}}}
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval then
			card.ability.immutable.active = true
		end
	end,
	can_use = function(self, card)
		return G.deck and #G.deck.cards > 1 and card.ability.immutable.active
	end,
	use = function(self, card)
		card.ability.immutable.active = false
		local card = G.deck.cards[#G.deck.cards]
		G.deck.cards[#G.deck.cards] = nil
		table.insert(G.deck.cards, 1, card)
	end
}

