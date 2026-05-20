SMODS.Sticker{
	key = "fake",
	--atlas = "stickers",
	pos = {x = 0, y = 0},
	badge_colour = HEX("6E6E6E"),
	rate = 0,
	never_scores = true
}

SMODS.Sticker{
	key = "linked",
	--atlas = "stickers",
	pos = {x = 1, y = 0},
	badge_colour = HEX("51EE61"),
	config = {
		id = 0
	},
	rate = 0,
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.synthb_linked.id, card.ability.synthb_linked.rounds, (card.ability.synthb_linked.rounds or 0) > 1 and "s" or ""}, key = self.key .. (card.ability.synthb_linked.rounds and "_temp" or "")}
	end,
	calculate = function (self, card, context)
		if context.press_play then
			for _, _card in ipairs(G.hand.highlighted) do
				if _card == card then
					for _, __card in ipairs(G.playing_cards) do
						if __card ~= card and __card.ability.synthb_linked and __card.ability.synthb_linked.id == card.ability.synthb_linked.id then
							draw_card(__card.area, G.play, 1, "front", nil, __card)
						end
					end
					break
				end
			end
		end
	end
}