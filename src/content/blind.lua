SMODS.Blind{
	key = "hold",
	dollars = 5,
	mult = 2,
	atlas = "blinds",
	boss = {min = 5}, -- same as serpent
	boss_colour = HEX("66bb9f"),
	calculate = function (self, blind, context)
		if blind.disabled then return end
		
		if context.modify_scoring_hand and G.GAME.current_round.hands_left ~= 0 then
			context.other_card.ability[self.key] = true
			return {
				remove_from_hand = true
			}
		end

		if context.press_play and G.GAME.current_round.hands_left == 1 then
			for _, card in ipairs(G.discard.cards) do
				if card.ability[self.key] then
					draw_card(G.discard, G.play, 1, "front", nil, card)
				end
			end
		end
	end
}