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

SMODS.Consumable:take_ownership("world", {
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.4,
			func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
				return true
			end
		}))
		for i = 1, #G.hand.highlighted do
			local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					G.hand.highlighted[i]:flip()
					play_sound('card1', percent)
					G.hand.highlighted[i]:juice_up(0.3, 0.3)
					return true
				end
			}))
		end
		delay(0.2)
		local tyw = SynthB.tyw()
		if tyw then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					SynthB.link_cards(G.hand.highlighted, tyw.ability.extra.rounds)
					return true
				end
			}))
		end
		for i = 1, #G.hand.highlighted do
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					assert(SMODS.change_base(G.hand.highlighted[i], card.ability.suit_conv))
					return true
				end
			}))
		end
		for i = 1, #G.hand.highlighted do
			local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					G.hand.highlighted[i]:flip()
					play_sound('tarot2', percent, 0.6)
					G.hand.highlighted[i]:juice_up(0.3, 0.3)
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
}, true)