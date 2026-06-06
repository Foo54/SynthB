G.P_CENTER_POOLS.synthb_Character = G.P_CENTER_POOLS.synthb_Character or {}

--- @class SynthB.Character: SMODS.Center
SynthB.Character = SMODS.Center:extend {
	unlocked = true,
	discovered = false,
	pos = { x = 2, y = 0 },
	atlas = "synthb_characters",
	cost = 8,
	--pixel_size = {w = 71, h = 71},
	--display_size = {w = 71, h = 71},
	set = 'synthb_Character',
	config = {},
	class_prefix = 'char',
	required_params = {
		'key',
	},
	set_card_type_badge = function(self, card, badges)
		badges[#badges + 1] = create_badge(localize("k_synthb_character"), SynthB.custom_colors.CHARACTER, G.C.WHITE, 1.2)
	end,
	inject = function(self)
		-- call the parent function to ensure all pools are set
		SMODS.Center.inject(self)
	end,
	set_ability = function (self, card, initial, delay_sprites)
		if initial then
			card.T.h = G.CARD_W
		end
	end,
	load = function (self, card, card_table, other_card)
		card.T.h = card.T.w
		-- if in character card area
			card.T.w = SynthB.CHAR_W
			card.T.h = SynthB.CHAR_H
	end
}
G.C.SET.synthb_Character = SynthB.custom_colors.CHARACTER
G.C.SECONDARY_SET.synthb_Character = SynthB.custom_colors.CHARACTER


function SynthB.mod.custom_card_areas(game)
	game.synthb_character_area = CardArea(
		game.jokers.T.x, game.jokers.T.y - SynthB.CHAR_H * 1.2,
		SynthB.CHAR_W * 5, SynthB.CHAR_H * 1.2,
		{
			card_limit = 5,
			type = "joker",
			highlight_limit = 1,
			no_card_count = true,
			align_buttons = true,
		}
	)
end

SMODS.UndiscoveredSprite{
	key = 'synthb_Character',
	atlas = 'characters',
	pos = {x=0,y=0},
	no_overlay = true,
	pixel_size = {h = 66 + 20},
}
SMODS.UndiscoveredCompat.synthb_Character = true

function SynthB.mod.custom_collection_tabs()
	local tally = 0
	for _, v in pairs(G.P_CENTER_POOLS.synthb_Character) do
		tally = tally + (v.discovered and 1 or 0)
	end
	return {UIBox_button{
		button = "synthb_your_collection_characters",
		label = {localize("b_synthb_characters")},
		count = {tally = tally, of = #G.P_CENTER_POOLS.synthb_Character},
		minw = 5,
		id = "synthb_your_collection_characters"
	}}
end

function G.UIDEF.create_UIBox_your_collection_characters()
	local pool = {}
	for k, v in pairs(G.P_CENTER_POOLS.synthb_Character) do
		if not v.no_collection then pool[#pool+1] = v end
	end
	return SMODS.card_collection_UIBox(pool, {5,5,5}, {
		no_materialize = true,
		h_mod = 0.95,
	})
end

function G.FUNCS.synthb_your_collection_characters(e)
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu{
		definition = G.UIDEF.create_UIBox_your_collection_characters(),
	}
end

local cfbshook = G.FUNCS.check_for_buy_space
---@diagnostic disable-next-line: duplicate-set-field
function G.FUNCS.check_for_buy_space(card)
	if card.ability.set == 'synthb_Character' then

		local a = #G.synthb_character_area.cards + (1 + card.ability.extra_slots_used) <= G.synthb_character_area.config.card_limit + card.ability.card_limit
		if not a then alert_no_space(card, G.synthb_character_area) end
		return a
	end
	return cfbshook(card)
end

local cae = CardArea.emplace
---@diagnostic disable-next-line: duplicate-set-field
function CardArea:emplace(card,...)
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
