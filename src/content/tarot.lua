-- the treasure hunter
SMODS.Consumable{
	key = "tarot_treasure_hunter",
	atlas = "tarot",
	synthb_credits = {
		Artist = "Foo54"
	},
	pos = {x = 0, y = 0},
	set = "Tarot",
	synthb_song = "song_synthb_approve_please_genie",
	synthb_count = 0,
	synthb_timer = 0,
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, card, "approve_please_genie")
		return {vars = {elements = {
			{n = G.UIT.C, config = {align = "m", colour = G.GAME.synthb_last_used_consumable_type and SMODS.ConsumableTypes[G.GAME.synthb_last_used_consumable_type].secondary_colour or G.C.UI.TEXT_INACTIVE, r = 0.05, padding = 0.1 }, nodes = {
				{ n = G.UIT.T, config = { text = G.GAME.synthb_last_used_consumable_type and localize("k_" .. G.GAME.synthb_last_used_consumable_type:lower()) or "None", colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true } },
			}}
		}}}
	end,
	can_use = function (self, card)
		return G.GAME.synthb_last_used_consumable_type and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit + (card.area == G.consumeables and 1 or 0)
	end,
	use = function (self, card, area, copier)
		local mem_set = G.GAME.synthb_last_used_consumable_type
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.4,
			func = function()
				if G.consumeables.config.card_limit > #G.consumeables.cards then
					play_sound('timpani')
					SMODS.add_card({ set = mem_set })
					card:juice_up(0.3, 0.5)
				end
				return true
			end
		}))
		delay(0.6)
	end
}

-- empurple tarot I don't know what to call this
SMODS.Tarot{
	key = "tarot_empurple",
	atlas = "placeholder",
	pos = {x = 0, y = 1},
	synthb_song = "song_synthb_empurple",
	synthb_count = 0,
	synthb_timer = 0,
	config = {max_highlighted = 2, mod_conv = 'm_synthb_purple'},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, card, "empurple")
		info_queue[#info_queue+1] = G.P_CENTERS.m_synthb_purple
		return {vars = {card.ability.max_highlighted, localize{type = "name_text", set = "Enhanced", key = card.ability.mod_conv}}}
	end,
}


-- shogi tarot
SMODS.Consumable{
	key = "tarot_master",
	set = "Tarot",
	atlas = "tarot",
	synthb_credits = {
		Artist = "Foo54"
	},
	pos = {x = 1, y = 0},
	synthb_song = "song_synthb_shogi",
	synthb_count = 0,
	synthb_timer = 0,
	config = {hands = 1},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, card, "shogi")
		return {vars = {card.ability.hands}}
	end,
	can_use = function (self, card)
		return #G.GAME.synthb_destroyed > 0
	end,
	use = function(self, card, area, copier)
		G.FUNCS.overlay_menu{
			definition = G.UIDEF.synthb_shogi_full_menu(),
			config = {
				no_esc = true
			}
		}
	end,
}

-- the maiden
SMODS.Tarot{
	key = "tarot_maiden",
	atlas = "tarot",
	synthb_credits = {
		Artist = "Foo54"
	},
	pos = {x = 3, y = 0},
	synthb_song = "song_synthb_dissection",
	synthb_count = 0,
	synthb_timer = 0,
	config = {max_highlighted = 1, cards = 2},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, card, "otome_dissection")
		return {vars = {card.ability.cards}}
	end,
	use = function(self, card, area)
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
		local new_cards = {}
		for i = 1, #G.hand.highlighted do
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					local _first_dissolve = nil
					for _ = 1, card.ability.cards - 1 do
							---@type Card
							local _card = SMODS.copy_card(G.hand.highlighted[i])

							if _card.config.center.key ~= "c_base" then
								if pseudorandom(pseudoseed("synthb_maiden_enhancement")) < 0.5 then
									_card:set_ability("c_base")
								else
									G.hand.highlighted[i]:set_ability("c_base")
								end
							end

							if _card.seal then
								if pseudorandom(pseudoseed("synthb_maiden_seal")) < 0.5 then
									_card:set_seal()
								else
									G.hand.highlighted[i]:set_seal()
								end
							end

							if _card.edition then
								if pseudorandom(pseudoseed("synthb_maiden_edition")) < 0.5 then
									_card:set_edition()
								else
									G.hand.highlighted[i]:set_edition()
								end
							end

							local rank = math.max(1, math.floor(_card.base.nominal * pseudorandom(pseudoseed("synthb_maiden_rank"))))
							if _card.base.nominal > 3 then rank = math.max(3, rank)
							local rank2 = _card.base.nominal - rank
---@diagnostic disable-next-line: cast-local-type
							rank = rank == 1 and "Ace" or tostring(rank)
---@diagnostic disable-next-line: cast-local-type
							rank2 = rank2 == 1 and "Ace" or tostring(rank2)

							assert(SMODS.change_base(_card, nil, rank))
							assert(SMODS.change_base(G.hand.highlighted[i], nil, rank2))

							_card:start_materialize(nil, _first_dissolve)
							_first_dissolve = true
							new_cards[#new_cards + 1] = _card
					end
				end
				return true
			end
			}))
		end
		G.E_MANAGER:add_event(Event{
			func = function()
				SMODS.calculate_context({ playing_card_added = true, cards = new_cards })
				return true
			end
		})
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
}
