-- Voicebank
SMODS.Consumable{
	key = "spectral_voicebank",
	atlas = "spectral",
	pos = {x = 1, y = 0},
	synthb_credits = {
		Artist = "Foo54"
	},
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
	atlas = "spectral",
	pos = {x = 0, y = 0},
	synthb_credits = {
		Artist = "Foo54"
	},
	set = "Spectral",
	synthb_song = "song_synthb_approve_please_genie",
	synthb_count = 0,
	synthb_timer = 0,
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, card, "approve_please_genie")
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

SynthB.cover_editions = {
	"e_synthb_cover_miku",
	"e_synthb_cover_teto",
	"e_synthb_cover_kaito",
	"e_synthb_cover_meiko"
}

-- Utaite
SMODS.Consumable{
	key = "spectral_utaite",
	atlas = "placeholder",
	pos = {x = 1, y = 1},
	-- synthb_credits = {
	-- 	Artist = "Foo54"
	-- },
	set = "Spectral",
	loc_vars = function(self, info_queue, card)
		for _, edition in ipairs(SynthB.cover_editions) do
			info_queue[#info_queue+1] = G.P_CENTERS[edition]
		end
	end,
	can_use = function (self, card)
		local joker_select = #G.jokers.highlighted == 1
		local card_select = #G.hand.highlighted == 1
		local safe = #G.hand.highlighted < 2 and #G.jokers.highlighted < 2
		if safe then
			if (joker_select or card_select) and not (joker_select and card_select) then
				local target = G.jokers.highlighted[1] or G.cards.highlighted[1]
				if not target.edition then
					for _, edition in ipairs(SynthB.cover_editions) do
						if G.P_CENTERS[edition]:valid_vard(target) then
							return true
						end
					end
				end
			end
		end
	end,
	use = function (self, card, area, copier)
		---@type Card
		local target = G.jokers.highlighted[1] or G.cards.highlighted[1]
		local pool = {}
		for _, edition in ipairs(SynthB.cover_editions) do
			if G.P_CENTERS[edition]:valid_card(target) then
				pool[#pool+1] = edition
			end
		end
		local edition = pseudorandom_element(pool, "synthb_utaite")
		target:set_edition(edition)
		target:juice_up()
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

if SynthB.mod.config.experimental_features then
	-- Training
	SMODS.Consumable{
		key = "spectral_training",
		atlas = "spectral",
		pos = {x = 2, y = 0},
		synthb_credits = {
			Artist = "Foo54"
		},
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
end