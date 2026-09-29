SMODS.Back{
	key = "utau",
	config = {consumable_slots = 1},
	--synthb_credits = {
	--	Artist = "Foo54"
	--},
	set_card_type_badge = function (self, card, badges)
		badges[#badges+1] = create_badge(localize("k_synthb_deck"), nil, nil, 1.2)
	end,
	loc_vars = function(self, info_queue)
		info_queue[#info_queue+1] = {set = "Other", key = "eternal"}
		return {vars = {self.config.consumable_slots}}
	end,
	apply = function (self)
		G.E_MANAGER:add_event(Event{
			func = function()
				G.E_MANAGER:add_event(Event{
					func = function()
						G.consumeables.config.card_limit = G.consumeables.config.card_limit + self.config.consumable_slots
						return true
					end
				})
				return true
			end
		})
	end,
	calculate = function(self, back, context)
		if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
					if G.consumeables.config.card_limit > #G.consumeables.cards then
						play_sound('timpani')
						SMODS.add_card({ set = "Tuning", force_stickers = {"eternal"} });
						(G.deck.cards[1] or G.deck):juice_up(0.3, 0.5)
						SMODS.calculate_effect({message = localize("k_synthb_plus_tuning")}, G.deck.cards[1] or G.deck)
					end
					return true
				end
			}))
			delay(0.6)
			return nil, true
		end
	end,
}