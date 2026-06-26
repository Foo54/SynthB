G.P_CENTER_POOLS.synthb_Character = G.P_CENTER_POOLS.synthb_Character or {}

--- @class SynthB.Character: SMODS.Center
SynthB.Character = SMODS.Center:extend {
	unlocked = true,
	discovered = false,
	pos = { x = 2, y = 0 },
	atlas = "synthb_characters",
	cost = 8,
	set = 'synthb_Character',
	config = {},
	class_prefix = 'char',
	required_params = {
		'key',
	},
	synthb_major = {},
	synthb_minor = {},
	set_card_type_badge = function(self, card, badges)
		badges[#badges + 1] = create_badge(localize("k_synthb_character"), SynthB.custom_colors.CHARACTER, G.C.WHITE, 1.2)
	end,
	inject = function(self)
		self.config = self.config or {}
		self.config.extra = self.config.extra or {}
		self.config.extra.minor_boost = self.config.extra.minor_boost or 1.25
		self.config.extra.major_boost = self.config.extra.major_boost or 1.5
		self.config.immutable = self.config.immutable or {}
		local set_ability_ref = self.set_ability or function() end
		function self.set_ability (self, card, initial, delay_sprites)
			if initial then
				card.T.h = G.CARD_W
				card.ability.immutable.level = pseudorandom("synthb_character_level", 1, 60) >= 50
				if card.ability.immutable.level and card.config.center.discovered then
					card.children.center:set_sprite_pos({x = self.pos.x, y = self.pos.y + 1})
				end
			end
			set_ability_ref(self, card, initial, delay_sprites)
		end
		local calculate_ref = self.calculate or function() end
		function self.calculate (self, card, context)
			card.synthb_triggered = false
			local ret = calculate_ref(self, card, context)
			if not context.synthb_character_triggered and (card.synthb_triggered or (ret and card.synthb_triggered ~= nil)) then -- override to force no activation
				SMODS.calculate_context({synthb_character_triggered = card})
			end
			return ret
		end
		SMODS.Center.inject(self)
	end,
	load = function(self, card, card_table, other_card)
		card.T.h = card.T.w
	end,
}
G.C.SET.synthb_Character = SynthB.custom_colors.CHARACTER
G.C.SECONDARY_SET.synthb_Character = SynthB.custom_colors.CHARACTER

local card_set_card_area_ref = Card.set_card_area
---@diagnostic disable-next-line: duplicate-set-field
function Card:set_card_area(area)
	if self.config.center.set == "synthb_Character" and area == G.synthb_character_area then
		self.T.h = SynthB.CHAR_H
		self.T.w = SynthB.CHAR_W
	end
	card_set_card_area_ref(self, area)
end

function SynthB.mod.custom_card_areas(game)
	local h = SynthB.CHAR_W * 5
	local w = SynthB.CHAR_H * 1.2
	game.synthb_character_area = CardArea(
		game.consumeables.T.x + game.consumeables.T.w + 0.1, game.consumeables.T.y,
		w, h,
		{
			card_limit = 5,
			type = "characters",
			card_count = true,
			highlight_limit = 1,
			highlighted_limit = 1,
			align_buttons = true,
		}
	)

	game.synthb_ghost_area = CardArea(
		game.ROOM.T.x + game.ROOM.T.w, 0,
		SynthB.GHOST_W, SynthB.GHOST_H,
		{
			card_limit = 2,
			type = "joker",
			highlight_limit = 1,
			highlighted_limit = 1,
		}
	)
	function game.synthb_ghost_area:align_cards (...)
		for k, card in ipairs(self.cards or {}) do
			if not card.states.drag.is and not card.disable_align then
				if card.ability.immutable.possessed then
					card.T.w = SynthB.GHOST_W
					card.T.h = SynthB.GHOST_H
				end
				local parent
				for _, _card in ipairs(G.jokers.cards) do
					if card.ability.immutable.possessed == _card.ability.synthb_pink_possess then
						parent = _card
						card.T.x = parent.VT.x - G.ROOM.T.x / 2 + 0.05 + parent.VT.w / 2 - 0.9 * (parent.VT.w / 2 + SynthB.GHOST_W + 0.1) * math.sin(card.synthb_orbit_timer or 0)
						if ((card.synthb_orbit_timer or 0) + math.pi / 2) % (math.pi * 2) <= math.pi then
							card.synthb_infront = true
						else
							card.synthb_infront = false
						end
						card.T.y = parent.VT.y - G.ROOM.T.y + parent.VT.h / 2 + (parent.VT.h / 4) * math.sin((card.synthb_orbit_timer or 0))
						card.T.r = math.max(-0.1, math.min(0.1, math.atan(card.T.y - card.VT.y, card.T.x - card.VT.x)))
						break
					end
				end
				if not parent then
					card.synthb_infront = true
				end
			end
		end
	end
	function game.synthb_ghost_area:draw(behind, ...)
		if not self.states.visible then return end 
		if G.VIEWING_DECK and (self==G.deck or self==G.hand or self==G.play) then return end

		local state = G.TAROT_INTERRUPT or G.STATE
		if behind then
			self.ARGS.invisible_area_types = self.ARGS.invisible_area_types or {discard=1, voucher=1, play=1, consumeable=1, title = 1, title_2 = 1}
			if self.ARGS.invisible_area_types[self.config.type] or
					(self.config.type == 'hand' and ({[G.STATES.SHOP]=1, [G.STATES.TAROT_PACK]=1, [G.STATES.SPECTRAL_PACK]=1, [G.STATES.STANDARD_PACK]=1,[G.STATES.BUFFOON_PACK]=1,[G.STATES.PLANET_PACK]=1, [G.STATES.ROUND_EVAL]=1, [G.STATES.BLIND_SELECT]=1})[state]) or
					(self.config.type == 'hand' and state == G.STATES.SMODS_BOOSTER_OPENED) or
					(self.config.type == 'deck' and self ~= G.deck and not self.draw_uibox) or
					(self.config.type == 'shop' and self ~= G.shop_vouchers) then
			else
					if not self.children.area_uibox then 
									local card_count = not self.config.no_card_count and self ~= G.shop_vouchers and {n=G.UIT.R, config={align = self == G.jokers and 'cl' or self == G.hand and 'cm' or 'cr', padding = 0.03, no_fill = true}, nodes={
											{n=G.UIT.B, config={w = 0.1,h=0.1}},
											{n=G.UIT.T, config={ref_table = self.config, ref_value = 'card_count', scale = 0.3, colour = G.C.WHITE}},
											{n=G.UIT.T, config={text = '/', scale = 0.3, colour = G.C.WHITE}},
											{n=G.UIT.T, config={ref_table = self.config.card_limits, ref_value = 'total_slots', scale = 0.3, colour = G.C.WHITE}},
											{n=G.UIT.B, config={w = 0.1,h=0.1}}
									}} or nil

									self.children.area_uibox = UIBox{
											definition = 
													{n=G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR}, nodes={
															{n=G.UIT.R, config={minw = self.T.w,minh = self.T.h,align = "cm", padding = 0.1, mid = true, r = 0.1, colour = self.config.bg_colour or self ~= G.shop_vouchers and {0,0,0,0.1} or nil, ref_table = self}, nodes={
																	self == G.shop_vouchers and 
																	{n=G.UIT.C, config={align = "cm", paddin = 0.1, func = 'shop_voucher_empty', visible = false}, nodes={
																			{n=G.UIT.R, config={align = "cm"}, nodes={
																					{n=G.UIT.T, config={text = 'DEFEAT', scale = 0.6, colour = G.C.WHITE}}
																			}},
																			{n=G.UIT.R, config={align = "cm"}, nodes={
																					{n=G.UIT.T, config={text = 'BOSS BLIND', scale = 0.4, colour = G.C.WHITE}}
																			}},
																			{n=G.UIT.R, config={align = "cm"}, nodes={
																					{n=G.UIT.T, config={text = 'TO RESTOCK', scale = 0.4, colour = G.C.WHITE}}
																			}},
																	}} or nil,
															}},
															card_count
													}},
											config = { align = 'cm', offset = {x=0,y=0}, major = self, parent = self}
									}
							end
					self.children.area_uibox:draw()
			end

			self:draw_boundingrect()
			add_to_drawhash(self)

			self.ARGS.draw_layers = self.ARGS.draw_layers or self.config.draw_layers or {'shadow', 'card'}
			for k, v in ipairs(self.ARGS.draw_layers) do
					for i = 1, #self.cards do 
							if self.cards[i] ~= G.CONTROLLER.focused.target then
									if not self.cards[i].highlighted and not self.cards[i].synthb_infront then
											if G.CONTROLLER.dragging.target ~= self.cards[i] then self.cards[i]:draw(v) end
									end
							end
					end
			end
		else
			self.ARGS.draw_layers = self.ARGS.draw_layers or self.config.draw_layers or {'shadow', 'card'}
			for k, v in ipairs(self.ARGS.draw_layers) do
					for i = 1, #self.cards do 
							if self.cards[i] ~= G.CONTROLLER.focused.target then
									if not self.cards[i].highlighted and self.cards[i].synthb_infront then
											if G.CONTROLLER.dragging.target ~= self.cards[i] then self.cards[i]:draw(v) end
									end
							end
					end
					for i = 1, #self.cards do  
							if self.cards[i] ~= G.CONTROLLER.focused.target then
									if self.cards[i].highlighted then
											if G.CONTROLLER.dragging.target ~= self.cards[i] then self.cards[i]:draw(v) end
									end
							end
					end
			end
		end
	end
end

local card_area_can_highlight_ref = CardArea.can_highlight
---@diagnostic disable: duplicate-set-field
function CardArea:can_highlight(card)
	if self.config.type == "characters" then return true end
	return card_area_can_highlight_ref(self, card)
end

local card_area_align_cards_ref = CardArea.align_cards
---@diagnostic disable-next-line: duplicate-set-field
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
---@diagnostic disable-next-line: duplicate-set-field
function Card:can_sell_card()
	if (G.SETTINGS.tutorial_complete or G.GAME.pseudorandom.seed ~= 'TUTORIAL' or G.GAME.round_resets.ante > 1) and self.area and self.area.config.type == "characters" then
		return true
	end
	return card_can_sell_card_ref(self)
end

SMODS.UndiscoveredSprite {
	key = 'synthb_Character',
	atlas = 'characters',
	pos = { x = 0, y = 0 },
	no_overlay = true,
	pixel_size = { h = 66 + 20 },
}
SMODS.UndiscoveredCompat.synthb_Character = true

function SynthB.mod.custom_collection_tabs()
	local tally = 0
	for _, v in pairs(G.P_CENTER_POOLS.synthb_Character) do
		tally = tally + (v.discovered and 1 or 0)
	end
	return { UIBox_button {
		button = "synthb_your_collection_characters",
		label = { localize("b_synthb_characters") },
		count = { tally = tally, of = #G.P_CENTER_POOLS.synthb_Character },
		minw = 5,
		id = "synthb_your_collection_characters"
	} }
end

function G.UIDEF.create_UIBox_your_collection_characters()
	local pool = {}
	for k, v in pairs(G.P_CENTER_POOLS.synthb_Character) do
		if not v.no_collection then pool[#pool + 1] = v end
	end
	return SMODS.card_collection_UIBox(pool, { 5, 5 }, {
		no_materialize = true,
		h_mod = 0.95,
	})
end

function G.FUNCS.synthb_your_collection_characters(e)
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu {
		definition = G.UIDEF.create_UIBox_your_collection_characters(),
	}
end

local cfbshook = G.FUNCS.check_for_buy_space
---@diagnostic disable-next-line: duplicate-set-field
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
---@diagnostic disable-next-line: duplicate-set-field
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
