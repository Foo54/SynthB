
-- I'm Talking to You!!!
SMODS.Joker{
	key = "antani_itten_no",
	atlas = "placeholder",
	pos = {x = 0, y = 0},
	attributes = {"mult", "suit", "clubs", "Teto", "song", "ぴーなた"},
	config = {
		extra = {
			suit = "Clubs",
			mult = 6
		}
	},
	cost = 4,
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "antani_itten_no")
		return {vars = {card.ability.extra.suit, card.ability.extra.mult}}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.hand then
			if context.other_card:is_suit(card.ability.extra.suit) then
				return {
					mult = card.ability.extra.mult
				}
			end
		end
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{ text = "+" },
				{ ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" },
			},
			text_config = { colour = G.C.MULT },
			calc_function = function(card)
				local playing_hand = next(G.play.cards)
				local mult = 0
				for _, playing_card in ipairs(G.hand.cards) do
					if playing_hand or not playing_card.highlighted then
						if playing_card.facing and not (playing_card.facing == 'back') and not playing_card.debuff and playing_card:is_suit(card.ability.extra.suit) then
							mult = mult + card.ability.extra.mult * JokerDisplay.calculate_card_triggers(playing_card, nil, true)
						end
					end
				end
				card.joker_display_values.mult = mult
			end
		}
	end
}

-- Cadmium Colors
SMODS.Joker{
	key = "cadmium_colors",
	atlas = "placeholder",
	pos = {x = 0, y = 0},
	attributes = {"suit", "hearts", "diamonds", "economy", "song", "Jamie Paige", "Teto"},
	config = {
		extra = {
			suits = {"Hearts", "Diamonds"},
			earnings = 1
		}
	},
	cost = 5,
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "cadmium_colors")
		return {vars = {card.ability.extra.suits[1], card.ability.extra.suits[2], card.ability.extra.earnings}}
	end,
	calculate = function(self, card, context)
		if context.individual and (context.cardarea == G.play or context.cardarea == G.hand) and not context.end_of_round then
			if context.other_card:is_suit(card.ability.extra.suits[1]) or context.other_card:is_suit(card.ability.extra.suits[2]) then
				if context.cardarea == G.play then
					return {
						dollars = card.ability.extra.earnings
					}
				else
					return {
						dollars = -card.ability.extra.earnings
					}
				end
			end
		end
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{ ref_table = "card.joker_display_values", ref_value = "sign"},
				{ text = "$" },
				{ ref_table = "card.joker_display_values", ref_value = "money", retrigger_type = "mult" },
			},
			text_config = { colour = G.C.MONEY },
			calc_function = function(card)
				local playing_hand = next(G.play.cards)
				local money = 0
				local text, _, scoring_hand = JokerDisplay.evaluate_hand()
				if text ~= "Unknown" then
					for _, playing_card in ipairs(scoring_hand) do
						if not playing_card.debuff and (playing_card:is_suit(card.ability.extra.suits[1]) or playing_card:is_suit(card.ability.extra.suits[2])) then
							money = money + card.ability.extra.earnings * JokerDisplay.calculate_card_triggers(playing_card, scoring_hand)
						end
					end
				end
				for _, playing_card in ipairs(G.hand.cards) do
					if playing_hand or not playing_card.highlighted then
						if playing_card.facing and not (playing_card.facing == 'back') and not playing_card.debuff and (playing_card:is_suit(card.ability.extra.suits[1]) or playing_card:is_suit(card.ability.extra.suits[2])) then
							money = money - card.ability.extra.earnings * JokerDisplay.calculate_card_triggers(playing_card, nil, true)
						end
					end
				end
				card.joker_display_values.money = math.abs(money)
				card.joker_display_values.sign = money >= 0 and "+" or "-"
			end
		}
	end
}