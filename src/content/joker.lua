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