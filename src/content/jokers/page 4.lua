--- Page 4



-- Brain Implosion Energy
SynthB.Joker{
	key = "brain_implosion_energy",
	pos = {x = 1, y = 0},
	rarity = 2,
	cost = 6,
	attributes = {"generation", "tags", "song", "vocaloid song", "Teto", "Forte"},
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "brain_implosion_energy")
		SynthB.energy_drink_info(info_queue)
	end,
	calculate = function(self, card, context)
		if context.starting_shop or context.forcetrigger then
			G.E_MANAGER:add_event(Event({
				func = (function()
					G.E_MANAGER:add_event(Event({
						func = function()
							add_tag(Tag(SynthB.random_energy_drink("synthb_brain_implosion_energy")))
							play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
							return true
						end
					}))
					SMODS.calculate_effect({ message = localize('k_plus_energy_drink'), colour = G.C.RED }, context.blueprint_card or card)
					return true
				end)
			}))
			return nil, true
		end
	end,
}