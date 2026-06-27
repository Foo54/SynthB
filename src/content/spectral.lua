-- Voicebank
SMODS.Consumable{
	key = "spectral_voicebank",
	atlas = "placeholder",
	pos = {x = 1, y = 1},
	set = "Spectral",
	config = { extra = { seal = 'synthb_utau' }, max_highlighted = 1 },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
		return { vars = { card.ability.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		local conv_card = G.hand.highlighted[1]
		G.E_MANAGER:add_event(Event({
			func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
				return true
			end
		}))
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.1,
			func = function()
				conv_card:set_seal(card.ability.extra.seal, nil, true)
				return true
			end
		}))
		delay(0.5)
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.2,
			func = function()
				G.hand:unhighlight_all()
				return true
			end
		}))
	end,
}

-- Wish
SMODS.Consumable{
	key = "spectral_wish",
	atlas = "placeholder",
	pos = {x = 1, y = 1},
	set = "Spectral",
	synthb_song = "song_synthb_approve_please_genie",
	synthb_count = 0,
	synthb_timer = 0,
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "approve_please_genie")
	end,
	can_use = function (self, card)
		return #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
	end,
	use = function (self, card, area, copier)
		G.FUNCS.overlay_menu{
			definition = G.UIDEF.synthb_wish_full_menu(),
			config = {
				no_esc = true
			}
		}
	end
}

-- Training
SMODS.Consumable{
	key = "spectral_training",
	atlas = "placeholder",
	pos = {x = 1, y = 1},
	set = "Spectral",
	can_use = function (self, card)
		return #G.synthb_character_area.highlighted == 1 and not G.synthb_character_area.highlighted[1].ability.immutable.level
	end,
	in_pool = function (self, args)
		for _, char in ipairs(G.synthb_character_area.cards) do
			if not char.ability.immutable.level then return true end
		end
		return false
	end,
	use = function (self, card, area, copier)
		local char = G.synthb_character_area.highlighted[1]
		G.E_MANAGER:add_event(Event({
			func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
				return true
			end
		}))
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.1,
			func = function()
				char:flip()
				return true
			end
		}))
		delay(0.5)
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.1,
			func = function()
				char.ability.immutable.level = true
				char.children.center:set_sprite_pos({x = char.config.center.pos.x, y = char.config.center.pos.y + 1})
				return true
			end
		}))
		delay(0.5)
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.1,
			func = function()
				char:flip()
				return true
			end
		}))
		delay(0.5)
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.2,
			func = function()
				G.hand:unhighlight_all()
				return true
			end
		}))
	end
}