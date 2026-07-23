SMODS.Sticker{
	key = "fake",
	atlas = "stickers",
	pos = {x = 0, y = 0},
	badge_colour = HEX("6E6E6E"),
	rate = 0,
	never_scores = true
}


SMODS.Sticker{
	key = "linked",
	atlas = "stickers",
	pos = {x = 0, y = 1},
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
						if __card ~= card and __card.ability.synthb_linked and __card.ability.synthb_linked.id == card.ability.synthb_linked.id and __card.area ~= G.play then
							local found = false
							for _, ___card in ipairs(G.hand.highlighted) do
								if ___card == __card then found = true; break end
							end
							if not found and not __card.synthb_already_found then
								draw_card(__card.area, G.play, 1, "front", nil, __card)
								__card.synthb_already_found = true
							end
						end
					end
					break
				end
			end
		end
		if context.before then
			card.synthb_already_found = nil
		end
	end
}

SMODS.Sticker{
	key = "pinned_right",
	atlas = "stickers",
	pos = {x = 0, y = 2},
	badge_colour = HEX("E13FAB"),
	rate = 0,
}

SMODS.Sticker{
	key = "safe",
	atlas = "stickers",
	pos = {x = 1, y = 2},
	badge_colour = HEX("DAE48B"),
	rate = 0,
	calculate = function(self, card, context)
		if context.debuff_card and context.debuff_card == card then
			if card.ability.synthb_not_safe then
				card:remove_sticker("synthb_not_safe")
			end
			return {
				prevent_debuff = true
			}
		end
	end,
}

SMODS.Sticker{
	key = "not_safe",
	atlas = "stickers",
	pos = {x = 1, y = 1},
	badge_colour = HEX("DAE48B"),
	rate = 0,
	calculate = function(self, card, context)
		if context.debuff_card and context.debuff_card == card then
			return {
				debuff = true
			}
		end
	end,
	apply = function (self, card, val)
		card[self.key] = val
		SMODS.debuff_card(card, val and true or "reset", "synthb_not_safe")
	end,
	
}