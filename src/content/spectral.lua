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
				local target = G.jokers.highlighted[1] or G.hand.highlighted[1]
				if not target.edition then
					for _, edition in ipairs(SynthB.cover_editions) do
						if G.P_CENTERS[edition]:valid_card(target) then
							return true
						end
					end
				end
			end
		end
	end,
	use = function (self, card, area, copier)
		---@type Card
		local target = G.jokers.highlighted[1] or G.hand.highlighted[1]
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

-- Excorism
SMODS.Consumable{
	key = "spectral_exorcism",
	atlas = "placeholder",
	pos = {x = 1, y = 1},
	synthb_credits = {
		Artist = "FurretWalk, eventually"
	},
	synthb_song = "song_synthb_exorcist",
	synthb_count = 0,
	synthb_timer = 0,
	set = "Spectral",
	config = {effects = 2},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {set = 'Other', key = "synthb_negative_effects"}
		SynthB.song_info(info_queue, card, "exorcist")
		return {vars = {card.ability.effects}}
	end,
	can_use = function (self, card)
		local selected = 0
		for _, _card in ipairs(G.I.CARD) do
			if _card.highlighted and _card ~= card then
				selected = selected + 1
				if selected > 1 then
					return false
				end
			end
		end
		return selected == 1
	end,
	use = function(self, card, area, copier)
		---@type Card
		local target
		for _, _card in ipairs(G.I.CARD) do
			if _card.highlighted and _card ~= card then
				target = _card
				break
			end
		end
		if not target then SynthB.debug("No target somehow?"); return end
		local bad = {"eternal", "perishable", "rental", "pinned", "synthb_pinned_right", "synthb_fake", "synthb_not_safe"}
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.4,
			func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
				return true
			end
		}))
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.15,
			func = function()
				target:flip()
				play_sound('card1')
				target:juice_up(0.3, 0.3)
				return true
			end
		}))
		delay(0.2)
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.1,
			func = function()
				local has_negative = false
				for _, sticker in ipairs(bad) do
					if target.ability[sticker] then
						has_negative = true
						target:remove_sticker(sticker)
					end
				end
				if target.pinned then
					target.pinned = nil
					has_negative = true
				end
				if target.debuff then
					for source, val in pairs(target.ability.debuff_sources) do
						if val ~= "prevent_debuff" then
							SMODS.debuff_card(target, nil, source)
						end
					end
					target:set_debuff(false)
					SMODS.debuff_card(target, "prevent_debuff", "synthb_exorcised")
					has_negative = true
				end
				if not has_negative then
					if target.area ~= G.hand then
						bad[#bad] = nil
						bad[#bad] = nil
					else
						table.remove(bad, 1)
						table.remove(bad, 1)
						table.remove(bad, 1)
					end
					for i = 1, card.ability.effects do
						if not bad[1] then break end
						local effect, index = pseudorandom_element(bad, "synthb_exorcism_failed")
						table.remove(bad, index)
						if effect == "eternal" or effect == "perishable" then
							table.remove(bad, 1)
						end
						target:add_sticker(effect, true)
					end
				end
				return true
			end
		}))
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.15,
			func = function()
				target:flip()
				play_sound('tarot2', nil, 0.6)
				target:juice_up(0.3, 0.3)
				return true
			end
		}))
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.2,
			func = function()
				target.area:unhighlight_all()
				return true
			end
		}))
		delay(0.5)
	end,
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