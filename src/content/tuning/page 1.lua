-- Pitch Bend
SynthB.Tuning{
	key = "tuning_pitch_bend",
	config = {max_highlighted = 3, min_highlighted = 3},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.max_highlighted}}
	end,
	use = function(self, card, area, copier)
		-- totally helpful comment explaining what this does
		pcall(function()assert(SMODS.change_base(G.hand.highlighted[2], nil, ({0, '2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace'})[math.floor((G.hand.highlighted[1].base.id + G.hand.highlighted[3].base.id) / 2)]))end)
	end,
}

-- Velocity
SynthB.Tuning{
	key = "tuning_velocity",
	can_use = function(self, card)
		return G.hand and #G.hand.cards > 0
	end,
	use = function(self, card, area, copier)
		---@type Card
		local _card = pseudorandom_element(G.hand.cards, "synthb_velocity")
		if _card then
			_card.ability.synthb_bonus_chips = (_card.base.nominal + (_card.ability.synthb_bonus_chips or 0)) * 2 - _card.base.nominal
			local excluded_keys = {
				order = true,
				hands_played_at_create = true,
				debuff_sources = true,
				set = true,
				effect = true,
				type = true,
				name = true,
				synthb_bonus_chips = true
			}
			local stupid_annoying_keys = {
				x_chips = true,
				x_mult = true,
				h_x_chips = true,
				h_x_mult = true
			}
			for key, value in pairs(_card.ability) do
				if not excluded_keys[key] then
					if not stupid_annoying_keys[key] or value ~= 1 then
						_card.ability[key] = value * 2
					end
				end
			end
			_card:juice_up()
		end
	end,
}

-- Attack
SynthB.Tuning{
	key = "tuning_attack",
	config = {max_highlighted = 3, mult_gain = 1, mult_duration = 5},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.max_highlighted, card.ability.mult_gain, card.ability.mult_duration}}
	end,
	use = function(self, card, area, copier)
		for _, _card in ipairs(G.hand.highlighted) do
			_card.ability.synthb_mult_gain = card.ability.mult_gain
			_card.ability.synthb_mult_duration = (_card.ability.synthb_mult_duration or 0) + card.ability.mult_duration
			_card:juice_up()
		end
		G.hand:unhighlight_all()
	end,
}

-- Decay
SynthB.Tuning{
	key = "tuning_decay",
	config = {max_highlighted = 3, chips_start = 60, chips_gain = -10, chips_duration = 5},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.max_highlighted, card.ability.chips_start, -card.ability.chips_gain, card.ability.chips_duration}}
	end,
	use = function(self, card, area, copier)
		for _, _card in ipairs(G.hand.highlighted) do
			_card.ability.perma_bonus = _card.ability.perma_bonus + card.ability.chips_start
			_card.ability.synthb_chips_gain = card.ability.chips_gain
			_card.ability.synthb_chips_duration = (_card.ability.synthb_chips_duration or 0) + card.ability.chips_duration
			_card:juice_up()
		end
		G.hand:unhighlight_all()
	end,
}