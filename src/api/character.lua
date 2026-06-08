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
		-- call the parent function to ensure all pools are set
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
				if card.ability.immutable.level then
					card.children.center:set_sprite_pos({x = self.pos.x, y = self.pos.y + 1})
				end
			end
			set_ability_ref(self, card, initial, delay_sprites)
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
	return SMODS.card_collection_UIBox(pool, { 5, 5, 5 }, {
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
		if not a then alert_no_space(card, G.synthb_character_area) end
		for _, _card in ipairs(G.synthb_character_area.cards) do
			if _card.config.center.synthb_character == card.config.center.synthb_character then
				SynthB.alert_character_copy(card, G.synthb_character_area)
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
	if self == G.consumeables and card.ability.set == 'synthb_characters' then
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
