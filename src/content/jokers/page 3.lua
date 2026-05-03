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
					G.hand.cards[i]:set_ability(SMODS.poll_enhancement{guaranteed = true}, nil, true)
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
	end
}

