SMODS.Enhancement:take_ownership('glass', {
	calculate = function(self, card, context)
		if context.destroy_card and context.cardarea == G.play and context.destroy_card == card and SMODS.pseudorandom_probability(card, 'glass', 1, card.ability.extra) then
			if SynthB.effect.parry() then
				card:set_ability("m_gold", nil, true)
			else
				card.glass_trigger = true
				return { remove = true }
			end
		end
	end,
}, true)