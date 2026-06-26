---@diagnostic disable: duplicate-set-field
local set_edition_ref = Card.set_edition
function Card:set_edition(edition, immediate, silent, delay)
	if type(edition) == "table" then
		if edition.name_of_edition then
			edition = "e_" .. edition.name_of_edition
		elseif edition.key then
			edition = edition.key
		else
			for key, _ in pairs(edition) do
				edition = "e_" .. key
				break
			end
		end
		if type(edition) == "table" then edition = nil end
	end
	-- 500 compatability checks
	if self.config and self.config.center and self.config.center.set ~= "Edition" and not SynthB.mod.config.allow_covers_on_any_card and edition and G.P_CENTERS[edition] and G.P_CENTERS[edition].valid_card and type(G.P_CENTERS[edition].valid_card) == 'function' then
		while type(G.P_CENTERS[edition].valid_card) == 'function' and not G.P_CENTERS[edition]:valid_card(self) do
			edition = SMODS.poll_edition{guaranteed = true}
		end
	end
	return set_edition_ref(self, edition, immediate, silent, delay)
end

local eval_card_ref = eval_card
function eval_card(card, context)
	local effect, post_trig = eval_card_ref(card, context)
	if card.edition and card.edition.key and type(G.P_CENTERS[card.edition.key].modify_effect) == "function" then
		for key, partial_effect in pairs(effect) do
			G.P_CENTERS[card.edition.key].modify_effect(card, key, partial_effect)
		end
	end
	if not context.synthb_no_mod_scoring then -- prevent most cases on infinte recursion
		for key, partial_effect in pairs(effect) do
			SMODS.calculate_context{synthb_mod_scoring = partial_effect, synthb_mod_key = key,  synthb_no_mod_scoring = true}
		end
	end
	if SynthB.too_hot() then
		for key, partial_effect in pairs(effect) do
			SynthB.heat_modify_effect(card, key, partial_effect)
		end
	end
	return effect, post_trig
end

local has_no_rank_ref = SMODS.has_no_rank
function SMODS.has_no_rank (card)
	if has_no_rank_ref(card) then return true end
	if card.debuff then return false end
	local id = card.base.id
	local rank = SMODS.Ranks[card.base.value]
	if not id then return false end
	if (id > 0 and rank and rank.face) or next(SMODS.find_card("j_pareidolia")) then
			return next(SMODS.find_card("j_synthb_medicine"))
	end
end

local cardarea_shuffle_ref = CardArea.shuffle
function CardArea.shuffle (self, _seed)
	local ret = cardarea_shuffle_ref(self, _seed)
	if G.GAME.synthb_monitored then
		for index, card in ipairs(self.cards) do
			if card.ability.synthb_monitored then
				self.cards[index] = self.cards[#self.cards]
				self.cards[#self.cards] = card
			end
		end
		self:set_ranks() --- idk what this does but the original function has it and it seems important
	end
	return ret
end

local card_click_ref = Card.click
function Card:click ()
	if not SynthB.Globals.blackjack_open then
		if self.config.center.synthb_song then
			if SynthB.mod.config.triple_click_for_song then
				if G.TIMERS.REAL - self.config.center.synthb_timer > 1 then
					self.config.center.synthb_timer = G.TIMERS.REAL
					self.config.center.synthb_count = 0
				end
				self.config.center.synthb_count = self.config.center.synthb_count + 1
				if self.config.center.synthb_count >= 3 then
					self.config.center.synthb_count = 0
					self.config.center.synthb_timer = G.TIMERS.REAL
					G.FUNCS.go_to_song({config = {ref_table = SynthB.key_songs[type(self.config.center.synthb_song) == "string" and self.config.center.synthb_song or self.config.center.original_key]}})
				end
			end
		end
		if self.config.center.key == "j_synthb_blackjack" and self.ability.immutable.STATE == self.ability.immutable.STATES.NEEDS_ATTENTION then
			self:hover()
			SynthB.Globals.blackjack_open = self
			self.ability.immutable.STATE = self.ability.immutable.STATES.BETTING
			self.ability.immutable.STATE_COMPLETE = false
		end
		if G.GAME.synthb_choosing_wish then
			if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
				G.GAME.joker_buffer = G.GAME.joker_buffer + 1
				G.E_MANAGER:add_event(Event{
					func = function()
						SMODS.add_card {key = self.config.center.key}
						G.GAME.joker_buffer = 0
						return true
					end
				})
				G.consumeables:change_size(-1)
				G.GAME.synthb_temp_consumable_size = (G.GAME.synthb_temp_consumable_size or 0) - 1
				G.GAME.synthb_temp_consumable_duration = 3
			end
			G.GAME.synthb_choosing_wish = false
			G.FUNCS.exit_overlay_menu()
		end
		card_click_ref(self)
	end
end

local card_hover_ref = Card.hover
function Card:hover()
	if not SynthB.Globals.blackjack_open and not (self.ability.set == "synthb_Character" and self.config.center.synthb_character == "padding") then
		card_hover_ref(self)
	end
end

local card_stop_hover_ref = Card.stop_hover
function Card:stop_hover()
	if not (self.config.center.key == "j_synthb_blackjack" and SynthB.Globals.blackjack_open == self) then
		card_stop_hover_ref(self)
	end
end


local create_run_ref = Game.start_run
function Game:start_run (args)
	local ret = create_run_ref(self, args)
	if SynthB.get_temp() > 0 then
		SynthB.draw_thermometer()
	end
	return ret
end

local chip_bonus_ref = Card.get_chip_bonus
function Card:get_chip_bonus()
    return chip_bonus_ref(self) + (self.ability.synthb_bonus_chips or 0)
end

local perma_bonuses_ref = SMODS.localize_perma_bonuses
function SMODS.localize_perma_bonuses(specific_vars, desc_nodes)
	local ret = perma_bonuses_ref(specific_vars, desc_nodes)
	if specific_vars and specific_vars.synthb_mult_gain and specific_vars.synthb_mult_gain ~= 0 and specific_vars.synthb_mult_duration > 0 then
		localize{type = "other", key = "card_synthb_mult", nodes = desc_nodes, vars = {specific_vars.synthb_mult_gain, specific_vars.synthb_mult_duration, localize(specific_vars.synthb_mult_duration > 1 and "k_synthb_times_plural" or "k_synthb_times_singular")}}
	end
	if specific_vars and specific_vars.synthb_chips_gain and specific_vars.synthb_chips_gain ~= 0 and specific_vars.synthb_chips_duration > 0 then
		localize{type = "other", key = "card_synthb_chips", nodes = desc_nodes, vars = {-specific_vars.synthb_chips_gain, specific_vars.synthb_chips_duration, localize(specific_vars.synthb_chips_duration > 1 and "k_synthb_times_plural" or "k_synthb_times_singular")}}
	end
	if specific_vars and specific_vars.synthb_xmult_gain and specific_vars.synthb_xmult_gain ~= 0 and specific_vars.synthb_xmult_duration > 0 then
		localize{type = "other", key = "card_synthb_xmult", nodes = desc_nodes, vars = {specific_vars.synthb_xmult_gain, specific_vars.synthb_xmult_duration, localize(specific_vars.synthb_xmult_duration > 1 and "k_synthb_times_plural" or "k_synthb_times_singular")}}
	end
	if specific_vars and specific_vars.synthb_xchips_gain and specific_vars.synthb_xchips_gain ~= 0 and specific_vars.synthb_xchips_duration > 0 then
		localize{type = "other", key = "card_synthb_xchips", nodes = desc_nodes, vars = {-specific_vars.synthb_xchips_gain, specific_vars.synthb_xchips_duration, localize(specific_vars.synthb_xchips_duration > 1 and "k_synthb_times_plural" or "k_synthb_times_singular")}}
	end
	return ret
end

local change_base_ref = SMODS.change_base
function SMODS.change_base(card, suit, rank, delay_sprites)
	local _rank = card.base.id
	local ret = change_base_ref(card, suit, rank, delay_sprites)
	if ret ~= nil and _rank ~= card.base.id then
		SMODS.calculate_context({modify_card_rank = card, old_rank = _rank, new_rank = card.base.id})
	end
	return ret
end

local add_tag_ref = add_tag
---@diagnostic disable-next-line: lowercase-global
function add_tag(_tag)
	local from_load = _tag.from_load
	local ret = add_tag_ref(_tag)
	if not from_load and SMODS.Tags[_tag.key] then
		SynthB.temp_data = _tag
		if SMODS.Tags[_tag.key].on_obtain then
			SMODS.Tags[_tag.key]:on_obtain(_tag)
		end
	end
end

local round_score_ref = SMODS.calculate_round_score
function SMODS.calculate_round_score (flames)
	local ret = round_score_ref(flames)
	if SynthB.Globals.ignore_tag_reductions then SynthB.Globals.ignore_tag_reductions = false; return ret end
	for _, v in ipairs(G.GAME.tags) do
		local data = v:apply_to_run({type = 'synthb_decrease_score'})
		if data and data.mult then
			ret = ret * data.mult
		end
	end
	return ret
end

local tag_ui_ref = Tag.generate_UI
function Tag:generate_UI(_size)
	local tag_sprite_tab, tag_sprite = tag_ui_ref(self, _size)
	if tag_sprite then
		local tag_click_ref = tag_sprite.click or function() end
		function tag_sprite:click (...)
---@diagnostic disable-next-line: redundant-parameter
			local ret = tag_click_ref(self, ...)
			if tag_sprite.config.tag.ability then 
				tag_sprite.config.tag:apply_to_run{type = "synthb_tag_clicked"}
			end
			return ret
		end
	end
	return tag_sprite_tab, tag_sprite
end

local ease_dollars_ref = ease_dollars
---@diagnostic disable-next-line: lowercase-global
function ease_dollars(mod, instant)
	local ret = ease_dollars_ref(mod, instant)
	for _, v in ipairs(G.GAME.tags) do
		v:apply_to_run{type = 'synthb_money_changed', amount = mod}
	end
	return ret
end

local is_face_ref = Card.is_face
function Card:is_face(from_boss)
	return is_face_ref(self, from_boss) or (next(SMODS.find_card("j_synthb_human")) and self:is_suit("Diamonds"))
end

local delete_run_ref = G.delete_run
function G:delete_run()
	if G.jokers and G.jokers.cards then
		for _, card in ipairs(G.jokers.cards) do
			for _card, val in ipairs(card.synthb_dd_mod or {}) do
				SynthB.manip_card(card, function (key, _val) return _val / val end)
				card.synthb_dd_mod[_card] = nil
			end
		end
	end
	local ret = delete_run_ref(self)
	SynthB.Globals.blackjacks_to_play = 0
	SynthB.Globals.blackjack_open = nil
	return ret
end

if SynthB.mod.config.dont_fix_infinite_value_manip then
	local card_save_ref = Card.save
	function Card:save()
	---@diagnostic disable-next-line: undefined-field
		if self.synthb_dd_mod then
			local change
	---@diagnostic disable-next-line: undefined-field
			for _, val in pairs(self.synthb_dd_mod) do
				change = true
				break
			end
			if not change then goto skip end
			local ret = card_save_ref(self)
			if self.ability then ret.ability = copy_table(self.ability) end
			if self.ability.extra then ret.ability.extra = copy_table(self.ability.extra) end
	---@diagnostic disable-next-line: undefined-field
			for _, val in pairs(self.synthb_dd_mod) do
				SynthB.manip_card(ret, function (key, _val) return _val / val end)
			end
			return ret
		end
		::skip::
		return card_save_ref(self)
	end
end

local deck_info_ref = G.FUNCS.deck_info
function G.FUNCS.deck_info (args)
	if SynthB.Globals.blackjacks_to_play > 0 then return false end
	return deck_info_ref(args)
end

local options_ref = G.FUNCS.options
function G.FUNCS.options (args)
	if SynthB.Globals.blackjacks_to_play > 0 then return false end
	return options_ref(args)
end


local card_h_popup_ref = G.UIDEF.card_h_popup
function G.UIDEF.card_h_popup (card, ...)
	local ret = card_h_popup_ref(card, ...)
	if card.config and card.config.center and card.config.center.synthb_credits then
		for description, name in pairs(card.config.center.synthb_credits) do
			table.insert(ret.nodes[1].nodes[1].nodes, {n = G.UIT.R, config={align = "cm", padding = 0.03}, nodes = {
				type(name) == "function" and name(card) or {n = G.UIT.T, config = {colour = G.C.UI.TEXT_DARK, scale = 0.3, text = description .. ": " .. name}}
			}})
		end
	end
	return ret
end

local game_main_menu_ref = Game.main_menu
function Game:main_menu(...)
	local ret = game_main_menu_ref(self, ...)
	for _, spoiler in pairs(SynthB.mod.config.seen_spoilers) do
		if not spoiler then
			G.E_MANAGER:add_event(Event{
				func = function()
					G.FUNCS.overlay_menu{
						definition = G.UIDEF.synthb_spoiler_warning(),
						config = {}
					}
					return true
				end
			})
			for _spoiler in pairs(SynthB.mod.config.seen_spoilers) do SynthB.mod.config.seen_spoilers[_spoiler] = true end
			break
		end
	end
	return ret
end

local card_set_card_area_ref = Card.set_card_area
function Card:set_card_area(area)
	if self.config.center.set == "synthb_Character" and area == G.synthb_character_area then
		self.T.h = SynthB.CHAR_H
		self.T.w = SynthB.CHAR_W
	end
	card_set_card_area_ref(self, area)
end


local card_area_align_cards_ref = CardArea.align_cards
function CardArea:align_cards(...)
	if self.config.type == "characters" then
		for k, card in ipairs(self.cards or {}) do
			if not card.states.drag.is and not card.disable_align then
				card.T.r = 0
				card.T.x = self.T.x + self.T.w / 2 - card.T.w / 2 - (card.highlighted and 0.1 or 0) + (G.SETTINGS.reduced_motion and 0 or 1) * 0.03 * math.sin(0.666 * G.TIMERS.REAL + card.T.y)
				card.T.y = self.T.y + (self.T.h / 5) * (k - 1)
				card.T.x = card.T.x + card.shadow_parrallax.x / 30
			end
		end
		table.sort(self.cards, function (a, b) return a.T.y + a.T.h/2 - 100*((a.pinned and not a.ignore_pinned) and a.sort_id or 0) < b.T.y + b.T.h/2 - 100*((b.pinned and not b.ignore_pinned) and b.sort_id or 0) end)
	end
	return card_area_align_cards_ref(self, ...)
end

local card_can_sell_card_ref = Card.can_sell_card
function Card:can_sell_card()
	if (G.SETTINGS.tutorial_complete or G.GAME.pseudorandom.seed ~= 'TUTORIAL' or G.GAME.round_resets.ante > 1) and self.area and self.area.config.type == "characters" then
		return true
	end
	return card_can_sell_card_ref(self)
end



local cfbshook = G.FUNCS.check_for_buy_space
function G.FUNCS.check_for_buy_space(card)
	if card.ability.set == 'synthb_Character' then
		local a = #G.synthb_character_area.cards + (1 + card.ability.extra_slots_used) <=
		G.synthb_character_area.config.card_limit + card.ability.card_limit
		if not a then SynthB.alert_cardarea(card, G.synthb_character_area, 'k_no_space_ex'); return false end
		for _, _card in ipairs(G.synthb_character_area.cards) do
			if _card.config.center.synthb_character == card.config.center.synthb_character then
				SynthB.alert_cardarea(card, G.synthb_character_area, 'k_synthb_no_copies_ex')
				return false
			end
		end
		return a
	end
	return cfbshook(card)
end

local cae = CardArea.emplace
function CardArea:emplace(card, ...)
	if self == G.consumeables and card.ability.set == 'synthb_Character' then
		card:remove_from_area()
		G.synthb_character_area:emplace(card, ...)
		discover_card(card.config.center)
		card.bypass_discovery_center = true
		card.bypass_discovery_ui = true
		card.discovered = true
		return
	end
	if self == G.synthb_character_area then
		card.T.w = SynthB.CHAR_W
		card.T.h = SynthB.CHAR_H
	end

	cae(self, card, ...)
end


local card_area_can_highlight_ref = CardArea.can_highlight
function CardArea:can_highlight(card)
	if self.config.type == "characters" then return true end
	return card_area_can_highlight_ref(self, card)
end