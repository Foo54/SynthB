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


SMODS.UndiscoveredSprite {
	key = 'synthb_Character',
	atlas = 'characters',
	pos = { x = 0, y = 0 },
	no_overlay = true,
	pixel_size = { h = 66 + 20 },
}
SMODS.UndiscoveredCompat.synthb_Character = true

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
