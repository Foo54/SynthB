-- the treasure hunter
SMODS.Consumable{
	key = "tarot_treasure_hunter",
	atlas = "placeholder",
	pos = {x = 0, y = 1},
	set = "Tarot",
	synthb_song = "song_synthb_approve_please_genie",
	synthb_count = 0,
	synthb_timer = 0,
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "approve_please_genie")
		return {vars = {elements = {
			{n = G.UIT.C, config = {align = "m", colour = G.GAME.synthb_last_used_consumable_type and SMODS.ConsumableTypes[G.GAME.synthb_last_used_consumable_type].secondary_colour or G.C.UI.TEXT_INACTIVE, r = 0.05, padding = 0.1 }, nodes = {
				{ n = G.UIT.T, config = { text = G.GAME.synthb_last_used_consumable_type and localize("k_" .. G.GAME.synthb_last_used_consumable_type:lower()) or "None", colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true } },
			}}
		}}}
	end,
	can_use = function (self, card)
		return G.GAME.synthb_last_used_consumable_type and #G.consumeables.cards + G.GAME.consumeable_buffer <= G.consumeables.config.card_limit
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