loc_colour("red")
G.ARGS.LOC_COLOURS.temperature = G.C.ORANGE
G.ARGS.LOC_COLOURS.synthb_tuning = SynthB.custom_colors.TUNING
G.ARGS.LOC_COLOURS.synthb_tuning_dark = SynthB.custom_colors.TUNING_DARK
G.ARGS.LOC_COLOURS.garfields_thanksgiving = SynthB.custom_colors.TETO
G.ARGS.LOC_COLOURS.synthb_drink = SynthB.custom_colors.ENERGY_DRINK

G.ARGS.LOC_COLOURS.synthb_orange = SynthB.custom_colors.energy_drink.ORANGE
G.ARGS.LOC_COLOURS.synthb_strawberry = SynthB.custom_colors.energy_drink.STRAWBERRY
G.ARGS.LOC_COLOURS.synthb_banana = SynthB.custom_colors.energy_drink.BANANA
G.ARGS.LOC_COLOURS.synthb_raspberry = SynthB.custom_colors.energy_drink.RASPBERRY
G.ARGS.LOC_COLOURS.synthb_grape = SynthB.custom_colors.energy_drink.GRAPE
G.ARGS.LOC_COLOURS.synthb_melon = SynthB.custom_colors.energy_drink.MELON
G.ARGS.LOC_COLOURS.synthb_tritip = SynthB.custom_colors.energy_drink.TRITIP
G.ARGS.LOC_COLOURS.synthb_durian = SynthB.custom_colors.energy_drink.DURIAN

G.STATES.SYNTHB_GACHA_BANNER = 20080401

function G:update_synthb_gacha_banner(dt)
	local banner_data = SynthB.banners[G.GAME.synthb_current_banner_key]
	if G.buttons then self.buttons:remove(); self.buttons = nil end
	if G.shop then G.shop.alignment.offset.y = G.ROOM.T.y+11 end
	G.SYNTHB_PREV_STATE = 200
	if not G.STATE_COMPLETE then
		G.STATE_COMPLETE = true
		G.GAME.pack_choices = 1
		
		G.CONTROLLER.interrupt.focus = true
		G.E_MANAGER:add_event(Event({
			trigger = 'immediate',
			func = function()
				G.booster_pack_sparkles = Particles(1, 1, 0,0, {
					timer = 0.015,
					scale = 0.2,
					initialize = true,
					lifespan = 1,
					speed = 1.1,
					padding = -1,
					attach = G.ROOM_ATTACH,
					colours = copy_table(banner_data.colours.particles),
					fill = true
				})
				G.booster_pack_sparkles.fade_alpha = 1
				G.booster_pack_sparkles:fade(1, 0)
				G.booster_pack = UIBox{
					definition = G.UIDEF.synthb_create_UIBox_gacha_banner(G.GAME.synthb_current_banner_key),
					config = {align="tmi", offset = {x=0,y=G.ROOM.T.y + 9},major = G.hand, bond = 'Weak'}
				}
				G.booster_pack.alignment.offset.y = -2.2
				G.ROOM.jiggle = G.ROOM.jiggle + 3
        ease_colour(G.C.DYN_UI.MAIN, banner_data.colours.ui)
        ease_background_colour{new_colour = banner_data.colours.background1, special_colour = banner_data.colours.background2, contrast = 1.5}
				G.E_MANAGER:add_event(Event({
					trigger = 'immediate',
					func = function()
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 1.3*math.sqrt(G.SETTINGS.GAMESPEED),
							blockable = false,
							blocking = false,
							func = function()
                local card = SMODS.create_card{key = banner_data.pool(), area = G.pack_cards}
								G.pack_cards:emplace(card)
								return true
							end
						}))
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.5,
							func = function()
								G.CONTROLLER:recall_cardarea_focus('pack_cards')
								return true
							end}))
						return true
					end
				}))
				return true
			end
		}))
	end
end