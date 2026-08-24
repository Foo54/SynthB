local function new_colour (card)
	if not card.fake_card then
		card.synthb_changed_at = G.TIMERS.REAL
		card.synthb_old_colour = card.synthb_colour or {0, 0, 0, 1}
		while not card.synthb_colour or (card.synthb_colour[0] == card.synthb_old_colour[0] and card.synthb_colour[1] == card.synthb_old_colour[1] and card.synthb_colour[2] == card.synthb_old_colour[2]) do
			card.synthb_colour = pseudorandom_element(SynthB.custom_colors.streetcat_colours, "synthb_streetcat_colour")
		end
	end
end


SMODS.ConsumableType{
	key = "synthb_Sign",
	primary_colour = HEX("FF0000"),
	secondary_colour = SynthB.custom_colors.SIGN,
	collection_rows = {3, 3, 3},
	shop_rate = 2,
	default = "c_synthb_sign_keep_out",
	inject_card = function (self, center)
		local center_set_ability_ref = center.set_ability or function() end
		center.set_ability = function(_self, card, intial, delay_sprites)
			new_colour(card)
			center_set_ability_ref(_self, card, intial, delay_sprites)
		end
		local center_loc_vars_ref = center.loc_vars or function() end
		center.loc_vars = function(_self, info_queue, card)
			SynthB.song_info(info_queue, card, "streetcat")
			new_colour(card)
			return center_loc_vars_ref(_self, info_queue, card)
		end
	end
}

SMODS.UndiscoveredSprite{
	key = "synthb_Sign",
	atlas = "streetcat",
	pos = {x = 9, y = 0}
}

-- Keep Out
SynthB.Sign{
	key = "sign_keep_out",
	config = {max_highlighted = 1, not_safe = 2},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.max_highlighted, card.ability.not_safe}}
	end,
	use = function(self, card, area, copier)
		local pool = {}
		for _, _card in ipairs(G.hand.cards) do
			for _, __card in ipairs(G.hand.highlighted) do
				if __card == _card then
					goto nope
				end
			end
			pool[#pool+1] = _card
			::nope::
		end

		for _, _card in ipairs(G.hand.highlighted) do
			_card:juice_up()
			_card:add_sticker("synthb_safe", true)
		end
		
		local hit = 0
		while #pool > 0 and hit < card.ability.not_safe do
			local target, i = pseudorandom_element(pool, "synthb_keep_out")
---@diagnostic disable-next-line: param-type-mismatch
			table.remove(pool, i)
			target:juice_up()
			target:add_sticker("synthb_not_safe", true)
			hit = hit + 1
		end

		G.hand:unhighlight_all()

	end,
}

-- No Parking
SynthB.Sign{
	key = "sign_no_parking",
	pos = {x = 1, y = 0},
	config = {money_loss = 1, discards = 2},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.discards, card.ability.money_loss}}
	end,
	can_use = function() return true end,
	use = function (self, card, area, copier)
		G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.discards
		ease_discard(card.ability.discards)
		G.GAME.modifiers.synthb_blind_reward_mod = (G.GAME.modifiers.synthb_blind_reward_mod or 0) - card.ability.money_loss
		G.GAME.blind.dollars = G.GAME.blind.dollars - card.ability.money_loss
---@diagnostic disable-next-line: param-type-mismatch
		G.GAME.current_round.dollars_to_be_earned = G.GAME.blind.dollars > 10 and (localize('$') .. G.GAME.blind.dollars) or (string.rep(localize('$'), G.GAME.blind.dollars)..'')
	end
}

-- No Loitering
SynthB.Sign{
	key = "sign_no_loitering",
	pos = {x = 2, y = 0},
	config = {shop_slots = 1, consumable_slots = 1},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.shop_slots, card.ability.consumable_slots}}
	end,
	can_use = function() return true end,
	use = function (self, card, area, copier)
		change_shop_size(card.ability.shop_slots)
		G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.consumable_slots
	end
}

-- Fragile
SynthB.Sign{
	key = "sign_fragile",
	pos = {x = 3, y = 0},
	config = {mod_conv = "m_glass", max_highlighted = 2, xmult = 3},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_glass
		return {vars = {card.ability.max_highlighted, localize{type = "name_text", set = "Enhanced", key = card.ability.mod_conv}, card.ability.xmult}}
	end,
	use = function(self, card)
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
		for i = 1, #G.hand.highlighted do
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					G.hand.highlighted[i]:set_ability("m_glass")
					G.hand.highlighted[i].ability.extra = 1
					G.hand.highlighted[i].ability.Xmult = card.ability.xmult -- description
					G.hand.highlighted[i].ability.x_mult = card.ability.xmult -- actual x_mult
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
	end,
}

-- Caution
SynthB.Sign{
	key = "sign_caution",
	pos = {x = 4, y = 0},
	config = {consumables = 4},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {set = "Other", key = "eternal"}
		return {vars = {card.ability.consumables}}
	end,
	can_use = function() return true end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event{
			func = function()
				for i = 1, 4 do
					SMODS.add_card({set = "Consumeables"}):add_sticker("eternal", true)
				end
				return true
			end
		})
	end,
}

-- Slow
SynthB.Sign{
	key = "sign_slow",
	pos = {x = 5, y = 0},
	config = {hands = 2, blindsize = 2},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.hands, card.ability.blindsize}}
	end,
	can_use = function() return true end,
	use = function(self, card, area, copier)
		ease_hands_played(G.GAME.current_round.hands_left)
		G.GAME.round_resets.hands = G.GAME.round_resets.hands * 2
		G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * 2
	end,
}

-- Keep Right
SynthB.Sign{
	key = "sign_keep_right",
	pos = {x = 6, y = 0},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
		info_queue[#info_queue+1] = {set = "Other", key = "eternal"}
		info_queue[#info_queue+1] = {set = "Other", key = "synthb_pinned_right"}
		return {vars = {}}
	end,
	can_use = function (self, card)
		for _, _card in ipairs(G.jokers.cards) do
			if not _card.edition then return true end
		end
		return false
	end,
	use = function(self, card, area, copier)
		local pool = {}
		for _, _card in ipairs(G.jokers.cards) do
			if not _card.edition then pool[#pool + 1] = _card end
		end
		local target = pseudorandom_element(pool, "synthb_keep_right")
		target:set_edition("e_polychrome")
		target:add_sticker("eternal", true)
		target:add_sticker("synthb_pinned_right", true)
		target:juice_up()
	end,
}

-- Exit
SynthB.Sign{
	key = "sign_exit",
	pos = {x = 7, y = 0},
	can_use = function (self, card)
		return G.GAME.blind and G.GAME.blind.in_blind and not (G.GAME.blind.config.blind.boss and G.GAME.blind.config.blind.boss.showdown)
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({
			blocking = false,
			func = function()
				if G.STATE == G.STATES.SELECTING_HAND then
					G.GAME.chips = G.GAME.blind.chips
					G.STATE = G.STATES.HAND_PLAYED
					G.STATE_COMPLETE = true
					end_round()
					return true
				end
			end
		}))
	end,
}

-- No Entry
SynthB.Sign{
	key = "sign_no_entry",
	pos = {x = 8, y = 0},
	config = {joker_slots = 1, selection_limit = 2},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.joker_slots, card.ability.selection_limit}}
	end,
	can_use = function (self, card)
		return G.jokers.config.card_limit > 0
	end,
	use = function(self, card, area, copier)
		G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.joker_slots
		G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + card.ability.selection_limit
		G.GAME.starting_params.play_limit = G.GAME.starting_params.play_limit + card.ability.selection_limit
		G.GAME.starting_params.discard_limit = G.GAME.starting_params.discard_limit + card.ability.selection_limit
	end,
}


