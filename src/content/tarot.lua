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
		return G.GAME.synthb_last_used_consumable_type and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
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
	atlas = "tarot",
	pos = {x = 1, y = 0},
	set = "Tarot",
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
