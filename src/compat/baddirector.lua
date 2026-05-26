if not SynthB.is_mod_loaded("baddirector") then return end

SynthB.debug("BadDirector loaded successfully")


-- Smokey Love
SynthB.Joker{
	dependencies = {"baddirector"},
	key = "smokey_love",
	pos = {x = 1, y = 0},
	rarity = 2,
	cost = 7,
	eternal_compat = true,
	perishable_compat = true,
	blueprint_compat = false,
	demicolon_compat = false,
	attributes = {"suit", "hearts", "destroy_card", "song", "vocaloid song", "MEIKO", "Tonbi"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "smokey_love")
	end,
	calculate = function(self, card, context)
		if context.destroying_card and not context.blueprint then
			if not context.destroying_card:is_suit("Hearts") then
				local hearts = 0
				local enclosed = true
				local found = false
				for _, _card in ipairs(context.scoring_hand) do
					if _card:is_suit("Hearts") then
						if found then enclosed = true; break end
						hearts = hearts + 1
						enclosed = not enclosed
					end
					if _card == context.destroying_card then
						found = true
						if hearts % 2 == 0 then enclosed = false; break end
					end
				end
				return {
					remove = enclosed and true or nil
				}
			end
		end
	end,
}

SynthB.inject_song_data{link = "https://www.youtube.com/watch?v=6_Fci4Y8CUk", key = "smokey_love", pos = {x = 2, y = 9}}

--#region COLOURS

SMODS.Gradient{
	key = "mistuning",
	colours = {
		HEX("dff5fc"),
		HEX("aaf7fd"),
		HEX("55fbfe"),
		HEX("00FFFF"),
	},
	cycle = 2,
}

SMODS.Gradient{
	key = "mistuning_dark",
	colours = {
		darken(HEX("dff5fc"), 0.1),
		darken(HEX("aaf7fd"), 0.1),
		darken(HEX("55fbfe"), 0.1),
		darken(HEX("00FFFF"), 0.1),
	},
	cycle = 2,
}

G.ARGS.LOC_COLOURS.synthb_mistuning_dark = SMODS.Gradients.synthb_mistuning_dark

--#endregion

--#region ATLI

SMODS.Atlas{
	key = "mistuning",
	path = "mistuning.png",
	px = 71,
	py = 95
}

--#endregion

--#region SEAL

SMODS.Seal{
	key = "misutau",
	atlas = "placeholder",
	pos = {x = 1, y = 2},
	badge_colour = SMODS.Gradients.synthb_mistuning,
	calculate = function(self, card, context)
		if context.before and SMODS.in_scoring(card, context.scoring_hand) then
			local added = 0
			for _, _card in ipairs(context.full_hand) do
				if not SMODS.in_scoring(_card, context.scoring_hand) and _card.seal ~= "synthb_misutau" then
					print(0)
					added = added + 1
					G.E_MANAGER:add_event(Event({
						trigger = 'before',
						delay = 0.0,
						func = function()
							SMODS.add_card({ set = 'misTuning' })
							return true
						end
					}))
				end
			end
			if added > 0 then
				return { message = localize{type = "variable", key = 'k_synthb_plus_mistuning', vars = {added, added > 1 and "s" or ""}}, colour = SMODS.Gradients.synthb_mistuning}
			end
		end
	end,
}

--#endregion

--#region OWNERSHIP
local bd_heat_loc_vars_ref = SMODS.Consumable.obj_table.c_bd_heat.loc_vars
local bd_heat_use_ref = SMODS.Consumable.obj_table.c_bd_heat.use
SMODS.Spectral:take_ownership("bd_heat", {
	prefix_config = {
		atlas = false
	},
	atlas = "bd_spectrals_ghost",
	loc_vars = function(self, info_queue, card)
	---@diagnostic disable-next-line: need-check-nil
		local ret = bd_heat_loc_vars_ref(self, info_queue, card)
		SynthB.heat_info(info_queue)
		ret.key = "c_synthb_bd_heat"
		return ret
	end,
	use = function (self, card, area, copier)
		bd_heat_use_ref(self, card, area, copier)
		SynthB.ease_temp(30)()
	end
})
--#endregion

--#region CONSUMABLES

SMODS.ConsumableType{
	key = "misTuning",
	primary_colour = HEX("FF0000"),
	secondary_colour = SMODS.Gradients.synthb_mistuning,
	collection_rows = {6, 6},
	shop_rate = 2,
	default = "c_synthb_mistuning_pitch_bend"
}

---@class SynthB.MisTuning: SMODS.Consumable
SynthB.MisTuning = SMODS.Consumable:extend{
	dependencies = {"baddirector"},
	atlas = "synthb_mistuning",
	set = 'misTuning',
	soul_set = "Tuning",
	soul_rate = 0.01,
	in_pool = function (self, args)
		return true
	end,
}

--- Pitch Bend
SynthB.MisTuning{
	key = "mistuning_pitch_bend",
	can_use = function(self, card)
		return G.hand and G.hand.cards and #G.hand.cards >= 2
	end,
	use = function(self, card, area, copier)
		local memory = {}
		for i, _card in ipairs(G.hand.cards) do
			memory[i] = _card.base.id
		end
		for i, _card in ipairs(G.hand.cards) do
			local avg = 0
			for ii, id in ipairs(memory) do
				if ii ~= i then
					avg = avg + id
				end
			end
			avg = math.floor(avg / (#memory - 1))
			-- go go gadget horrible code
			_card:juice_up()
			pcall(function()assert(SMODS.change_base(_card,nil,({0,'2','3','4','5','6','7','8','9','10','Jack','Queen','King','Ace'})[avg]))end)
		end
	end,
}

--- Velocity
SynthB.MisTuning{
	key = "mistuning_velocity",
	pos = {x = 1, y = 0},
	config = {
		manip = 2
	},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.manip}}
	end,
	can_use = function(self, card)
		if G.jokers and G.jokers.cards then
			for _, _card in ipairs(G.jokers.cards) do
				if not _card.ability.synthb_mis_velocity then
					return true
				end
			end
		end
		return false
	end,
	use = function (self, card, area, copier)
		local cards = {}
		for _, _card in ipairs(G.jokers.cards) do
			if not _card.ability.synthb_mis_velocity then
				cards[#cards+1] =  _card
			end
		end
		local _card = pseudorandom_element(cards, "synthb_mistuning_velocity")
		_card.ability.synthb_mis_velocity = true
		SynthB.manip_card(_card, function (key, val) return val * card.ability.manip end)
		_card:juice_up()
	end
}

--- Attack
SynthB.MisTuning{
	key = "mistuning_attack",
	pos = {x = 2, y = 0},
	config = {max_highlighted = 3, xmult_loss = 0.5, xmult_gain = 0.2, xmult_duration = 5},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.max_highlighted, card.ability.xmult_loss, card.ability.xmult_gain, card.ability.xmult_duration}}
	end,
	use = function(self, card, area, copier)
		for _, _card in ipairs(G.hand.highlighted) do
			_card.ability.perma_x_mult = _card.ability.perma_x_mult - card.ability.xmult_loss
			_card.ability.synthb_xmult_gain = card.ability.xmult_gain
			_card.ability.synthb_xmult_duration = (_card.ability.synthb_xmult_duration or 0) + card.ability.xmult_duration
			_card:juice_up()
		end
		G.hand:unhighlight_all()
	end,
}


--- Decay
SynthB.MisTuning{
	key = "mistuning_decay",
	pos = {x = 3, y = 0},
	config = {max_highlighted = 3, xchips_gain = 2, xchips_loss = 0.5, xchips_duration = 5},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.max_highlighted, card.ability.xchips_gain, card.ability.xchips_loss, card.ability.xchips_duration}}
	end,
	use = function(self, card, area, copier)
		for _, _card in ipairs(G.hand.highlighted) do
			_card.ability.perma_x_chips = _card.ability.perma_x_chips + card.ability.xchips_gain
			_card.ability.synthb_xchips_gain = -card.ability.xchips_loss
			_card.ability.synthb_xchips_duration = (_card.ability.synthb_xchips_duration or 0) + card.ability.xchips_duration
			_card:juice_up()
		end
		G.hand:unhighlight_all()
	end,
}

--- Gender
SynthB.MisTuning{
	key = "mistuning_gender",
	pos = {x = 4, y = 0},
	can_use = function (self, card)
		if G.hand and G.hand.cards then
			for _, _card in ipairs(G.hand.cards) do
				if _card:get_id() ~= 12 then
					return true
				end
			end
		end
		return false
	end,
	use = function (self, card, area, copier)
		local destroy = {}
		for _, _card in ipairs(G.hand.cards) do
			if _card:get_id() ~= 12 then
				if pseudorandom("synthb_mis_gender", 1, 2) == 1 then
					assert(SMODS.change_base(_card, nil, "Queen"))
					_card:juice_up()
				else
					destroy[#destroy+1] = _card
				end
			end
		end
		SMODS.destroy_cards(destroy)
	end
}

--- Portamento
SynthB.MisTuning{
	key = "mistuning_portamento",
	pos = {x = 5, y = 0},
	can_use = function (self, card)
		return G.hand and G.hand.cards and #G.hand.cards >= 2
	end,
	use = function (self, card, area, copier)
		local memory = {}
		for index, _card in ipairs(G.hand.cards) do
			memory[index] = copy_table(_card.ability)
		end
		for index, _card in ipairs(G.hand.cards) do
			local excluded_keys = {
				order = true,
				hands_played_at_create = true,
				played_this_ante = true,
				debuff_sources = true,
				set = true,
				effect = true,
				type = true,
				name = true,
				delay_seal = true,
				seal = true
			}
			local stupid_annoying_keys = {
				x_chips = true,
				x_mult = true,
				h_x_chips = true,
				h_x_mult = true
			}
			for key, value in pairs(memory[index]) do
				if not excluded_keys[key] then
					if not stupid_annoying_keys[key] and value ~= 0 then
						pcall(function() G.hand.cards[index - 1].ability[key] = (G.hand.cards[index - 1].ability[key] or 0) + (value / 2) end) -- pcall for table stuff
						pcall(function() G.hand.cards[index + 1].ability[key] = (G.hand.cards[index + 1].ability[key] or 0) + (value / 2) end) -- pcall for table stuff
						pcall(function() _card.ability[key] = _card.ability[key] - value end)
						_card:juice_up()
					elseif stupid_annoying_keys[key] and value ~= 1 then
						pcall(function() G.hand.cards[index - 1].ability[key] = (G.hand.cards[index - 1].ability[key] or 1) + ((value - 1) / 2) end) -- pcall for table stuff
						pcall(function() G.hand.cards[index + 1].ability[key] = (G.hand.cards[index + 1].ability[key] or 1) + ((value - 1) / 2) end) -- pcall for table stuff
						pcall(function() _card.ability[key] = _card.ability[key] - value + 1 end)
						_card:juice_up()
					end
				end
			end
		end
	end
}

--- Low Pass
SynthB.MisTuning{
	key = "mistuning_lowpass",
	pos = {x = 0, y = 1},
	config = {max_rank = 10},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.max_rank}}
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
		SMODS.destroy_cards(cards)
	end
}

--- Normalize
SynthB.MisTuning{
	key = "mistuning_normalize",
	pos = {x = 1, y = 1},
	config = {max_highlighted = 3, seal = "[Seal]", enhancement = "[Enhancement]"},
	set_ability = function (self, card, initial, delay_sprites)
		_, card.ability.seal = pseudorandom_element(SMODS.Seals, "synthb_mis_normalize_seal")
		card.ability.enhancement = pseudorandom_element(G.P_CENTER_POOLS.Enhanced, "synthb_mis_normalize_enhancement")
		card.ability.enhancement = card.ability.enhancement.key
	end,
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.max_highlighted, card.area.config.collection and "[Seal]" or localize{type = "name_text", set = "Other", key = (card.ability.seal .. "_seal"):lower()}, card.area.config.collection and "[Enhancement]" or localize{type = "name_text", set = "Enhanced", key = card.ability.enhancement}, colours = {card.area.config.collection and G.ARGS.LOC_COLOURS.attention or SMODS.Seals[card.ability.seal].badge_colour}}}
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
					---@type Card
					local _card = G.hand.highlighted[i]
					_card:set_seal(card.ability.seal)
					_card:set_ability(card.ability.enhancement)
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
SynthB.MisTuning{
	key = "mistuning_vibrato",
	pos = {x = 2, y = 1},
	config = {max_highlighted = 5, gain = 2},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.max_highlighted, card.ability.gain, card.ability.gain/4}}
	end,
	use = function(self, card, area, copier)
		for _, _card in ipairs(G.hand.highlighted) do
			_card.ability.perma_x_chips = _card.ability.perma_x_chips + math.ceil(pseudorandom("synthb_vibrato", -card.ability.gain/4, card.ability.gain))
			_card:juice_up()
		end
		G.hand:unhighlight_all()
	end,
}

-- Modulation
SynthB.MisTuning{
	key = "mistuning_modulation",
	pos = {x = 3, y = 1},
	config = {max_highlighted = 5, gain = 2},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.max_highlighted, card.ability.gain, card.ability.gain / 4}}
	end,
	use = function(self, card, area, copier)
		for _, _card in ipairs(G.hand.highlighted) do
			_card.ability.perma_x_mult = _card.ability.perma_x_mult + math.ceil(pseudorandom("synthb_modulation", -card.ability.gain/4, card.ability.gain))
			_card:juice_up()
		end
		G.hand:unhighlight_all()
	end,
}

-- Direct
SynthB.MisTuning{
	key = "mistuning_direct",
	pos = {x = 4, y = 1},
	can_use = function (self, card)
		return G.hand and G.hand.cards and #G.hand.cards > 0
	end,
	use = function (self, card, area, copier)
		local destroy = {}
		local dummy_card = SMODS.create_card{set = "Base"}
		local stupid_fricking_keys_that_i_hate = {
			hands_played_at_create = true,
			order = true,
			played_this_ante = true
		}
		for _, _card in ipairs(G.hand.cards) do
			if _card.edition or _card.ability.effect ~= "Base" or _card.seal then
				destroy[#destroy+1] = _card
			else
				for key, value in pairs(_card.ability) do
					if SynthB.is_number(value) and value ~= dummy_card.ability[key] and not stupid_fricking_keys_that_i_hate[key] then
						destroy[#destroy + 1] = _card
						break
					end
				end
			end
		end
		SMODS.destroy_cards(destroy)
		dummy_card:remove()
		G.hand:unhighlight_all()
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.2,
			func = function()
				for _ = 1, #destroy do
					if SMODS.pseudorandom_probability(card, "synthb_mis_direct", 1, 4, nil, true) then
						SMODS.add_card{set = "Joker", edition = "e_negative"}
					else
						SMODS.add_card{set = "Consumeables", edition = 'e_negative'}
					end
				end
				return true
			end
		}))
	end
}

--- Tone Shift
SynthB.MisTuning{
	key = "mistuning_tone_shift",
	pos = {x = 5, y = 1},
	can_use = function (self, card)
		return G.hand and G.hand.cards and #G.hand.cards > 0
	end,
	use = function (self, card, area, copier)
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.4,
			func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
				return true
			end
		}))
		for i = 1, #G.hand.cards do
			local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					G.hand.cards[i]:flip()
					play_sound('card1', percent)
					G.hand.cards[i]:juice_up(0.3, 0.3)
					return true
				end
			}))
		end
		delay(0.2)
		for i = 1, #G.hand.cards do
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					assert(SMODS.change_base(G.hand.cards[i], pseudorandom_element({"Spades", "Hearts", "Clubs", "Diamonds"}, "synthb_mis_tone_shift"), nil, nil))
					return true
				end
			}))
		end
		for i = 1, #G.hand.cards do
			local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					G.hand.cards[i]:flip()
					play_sound('tarot2', percent, 0.6)
					G.hand.cards[i]:juice_up(0.3, 0.3)
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
}

--#endregion

--#region MISPRINT SPECTRAL

BadDirector.MisSpect{
	key = "misspectral_voicebank",
	atlas = "placeholder",
	misprint_original = "c_synthb_spectral_voicebank",
	pos = {x = 2, y = 2},
	config = {extra = {seal = "synthb_utau", seal_m = "synthb_misutau"}, dem = 6},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
		info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal_m]
		local num, dem = SMODS.get_probability_vars(card, 1, card.ability.dem, "synthb_mis_voicebank")
		return {vars = {num, dem}}
	end,
	can_use = function(self, card)
		return G.hand and #G.hand.cards > 0
	end,
	use = function(self, card, area, copier)
		play_sound('bd_inapmit')
		for i = 1, #G.hand.cards do
			local woah = G.hand.cards[i]
			if SMODS.pseudorandom_probability(card, "synthb_mis_voicebank", 1, card.ability.dem) then
				G.E_MANAGER:add_event(Event({
					func = function()
						woah:juice_up(0.3, 0.5)
						return true
					end
				}))
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.1,
					func = function()
						if SMODS.pseudorandom_probability(card,"goodboy",1,5,nil,true) then
							woah:set_seal(card.ability.extra.seal_m, nil, true)
						else
							woah:set_seal(card.ability.extra.seal, nil, true)
						end
						return true
					end
				}))
				delay(0.5)
			else
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.6,
					func = function()
						attention_text({
							text = localize('k_nope_ex'),
							scale = 1,
							hold = 1,
							major = woah,
							backdrop_colour = G.C.SECONDARY_SET.Tarot,
							align = 'cm',
							offset = { x = 0 + ((G.hand.cards[(math.floor(#G.hand.cards / 2))].T.x - woah.T.x) / -50), y = -2 },
							silent = true,
						})
						play_sound('generic1')
						woah:juice_up(0.3, 0.5)
						return true
					end
				}))
			end
		end
	end
}

--#endregion
