SMODS.Seal{
	key = "utau",
	atlas = "placeholder",
	pos = {x = 0, y = 2},
	badge_colour = SynthB.custom_colors.TUNING,
	calculate = function(self, card, context)
		if context.before and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			local all_sealed = true
			for _, _card in ipairs(G.hand.cards) do
				if _card.seal ~= "synthb_utau" then
					all_sealed = false
					break
				end
			end
			if all_sealed then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				G.E_MANAGER:add_event(Event({
					trigger = 'before',
					delay = 0.0,
					func = function()
						SMODS.add_card({ set = 'Tuning' })
						G.GAME.consumeable_buffer = 0
						return true
					end
				}))
				return { message = localize('k_plus_tuning'), colour = G.C.SECONDARY_SET.Tuning }
			end
		end
	end,
}