-- Pitch Bend
SynthB.Tuning{
	key = "tuning_pitch_bend",
	config = {max_highlighted = 3, min_highlighted = 3},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.max_highlighted}}
	end,
	use = function(self, card, area, copier)
		-- totally helpful comment explaining what this does
		pcall(function()assert(SMODS.change_base(G.hand.highlighted[2],nil,({0,'2','3','4','5','6','7','8','9','10','Jack','Queen','King','Ace'})[math.floor((G.hand.highlighted[1].base.id+G.hand.highlighted[3].base.id)/2)]))end)
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

-- Gender
SynthB.Tuning{
	key = "tuning_gender",
	config = {max_highlighted = 3},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.max_highlighted}}
	end,
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
		for i = 1, #G.hand.highlighted do
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					local _card = G.hand.highlighted[i]
					if _card.base.id >= 2 and _card.base.id <= 14 then
						local new_rank = nil
						if _card.base.id == 14 then new_rank = "2"
						elseif _card.base.id == 13 or _card.base.id == 11 then new_rank = "Queen"
						elseif _card.base.id == 12 then new_rank = pseudorandom_element({"King", "Jack"}, "synthb_gender")
						elseif _card.base.id == 2 then new_rank = "Ace"
						elseif _card.base.id % 2 == 0 then new_rank = tostring(_card.base.id - 1)
						elseif _card.base.id % 2 == 1 then new_rank = tostring(_card.base.id + 1)
						end
						assert(SMODS.change_base(_card, nil, new_rank))
					end
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

-- Portamento
SynthB.Tuning{
	key = "tuning_portamento",
	config = {max_highlighted = 2, min_highlighted = 2},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.max_highlighted}}
	end,
	use = function(self, card, area, copier)
		local rank2 = G.hand.highlighted[2].base.value
		local suit2 = G.hand.highlighted[2].base.suit
		local rank1 = G.hand.highlighted[1].base.value
		local suit1 = G.hand.highlighted[1].base.suit
		
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
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.1,
			func = function()
				copy_card(G.hand.highlighted[1], G.hand.highlighted[2])
				assert(SMODS.change_base(G.hand.highlighted[2], suit2, rank2))
				return true
			end
		}))
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.1,
			func = function()
				local dummy_card = SMODS.create_card{set = "Base"}
				copy_card(dummy_card, G.hand.highlighted[1])
				assert(SMODS.change_base(G.hand.highlighted[1], suit1, rank1))
				dummy_card:remove()
				return true
			end
		}))
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

-- Lowpass
SynthB.Tuning{
	key = "tuning_lowpass",
	config = {max_rank = 10, new_rank = 2},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.max_rank, card.ability.new_rank}}
	end,
	can_use = function(self, card)
		if not (G.hand and #G.hand.cards > 0) then return false end
		for _, _card in ipairs(G.hand.cards) do
			if _card:get_id() >= card.ability.max_rank then
				return true
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		local cards = {}
		for _, _card in ipairs(G.hand.cards) do
			if _card:get_id() >= card.ability.max_rank then
				cards[#cards+1] = _card
			end
		end
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.4,
			func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
				return true
			end
		}))
		for i = 1, #cards do
			local percent = 1.15 - (i - 0.999) / (#cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					cards[i]:flip()
					play_sound('card1', percent)
					cards[i]:juice_up(0.3, 0.3)
					return true
				end
			}))
		end
		delay(0.2)
		for _, _card in ipairs(cards) do
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					assert(SMODS.change_base(_card, nil, tostring(card.ability.new_rank)))
					return true
				end
			}))
		end
		for i = 1, #cards do
			local percent = 0.85 + (i - 0.999) / (#cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					cards[i]:flip()
					play_sound('tarot2', percent, 0.6)
					cards[i]:juice_up(0.3, 0.3)
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

-- Normalize
SynthB.Tuning{
	key = "tuning_normalize",
	config = {max_highlighted = 3, rank = "10", suit = "Spades"},
	set_ability = function (self, card, initial, delay_sprites)
		card.ability.rank = pseudorandom_element(SMODS.Ranks, "synthb_normalize_rank").key
		card.ability.suit = pseudorandom_element(SMODS.Suits, "synthb_normalize_suit").key
	end,
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.max_highlighted, localize(card.ability.rank, "ranks"), localize(card.ability.suit, "suits_plural"), colours = {G.C.SUITS[card.ability.suit]}}}
	end,
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
		for i = 1, #G.hand.highlighted do
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					assert(SMODS.change_base(G.hand.highlighted[i], card.ability.suit, card.ability.rank))
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

-- Vibrato
SynthB.Tuning{
	key = "tuning_vibrato",
	config = {max_highlighted = 5, gain = 30},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.max_highlighted, card.ability.gain}}
	end,
	use = function(self, card, area, copier)
		for _, _card in ipairs(G.hand.highlighted) do
			_card.ability.perma_bonus = card.ability.perma_bonus + math.ceil(pseudorandom("synthb_vibrato", -card.ability.gain, card.ability.gain))
			_card:juice_up()
		end
	end,
}

-- Modulation
SynthB.Tuning{
	key = "tuning_modulation",
	config = {max_highlighted = 5, gain = 5},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.max_highlighted, card.ability.gain}}
	end,
	use = function(self, card, area, copier)
		for _, _card in ipairs(G.hand.highlighted) do
			_card.ability.perma_mult = card.ability.perma_mult + math.ceil(pseudorandom("synthb_modulation", -card.ability.gain, card.ability.gain))
			_card:juice_up()
		end
	end,
}

-- Direct
SynthB.Tuning{
	key = "tuning_direct",
	config = {max_highlighted = 5},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.max_highlighted}}
	end,
	use = function(self, card, area, copier)
		local modifications_removed = 0
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
					---@type Card
					local _card = G.hand.highlighted[i]
					if _card.edition then
						modifications_removed = modifications_removed + 1
						_card:set_edition()
					end
					if _card.ability.effect ~= "Base" then
						modifications_removed = modifications_removed + 1
						_card:set_ability("c_base")
					end
					if _card.seal then
						modifications_removed = modifications_removed + 1
						_card:set_seal()
					end
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
				for _ = 1, modifications_removed, 5 do
					if SMODS.pseudorandom_probability(card, "synthb_direct", 1, 4, nil, true) then
						SMODS.add_card{set = "Joker", edition = "e_negative"}
					else
						SMODS.add_card{set = "Consumeables", edition = 'e_negative'}
					end
				end
				return true
			end
		}))
		delay(0.5)
	end,
}

-- Tone Shift
SynthB.Tuning{
	key = "tuning_tone_shift",
	config = {max_highlighted = 3},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.max_highlighted}}
	end,
	use = function(self, card, area, copier)
		local suit_map = {
			Spades = "Hearts",
			Hearts = "Clubs",
			Clubs = "Diamonds",
			Diamonds = "Spades"
		}
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
					assert(SMODS.change_base(G.hand.highlighted[i], suit_map[G.hand.highlighted[i].base.suit], nil))
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