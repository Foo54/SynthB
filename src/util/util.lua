--- Injects the SongInfo info_queue for a card,
--- respecting the set config value
--- @param info_queue table the info_queue to add the ui to
---@param key string the key found within descriptions.SongInfo
---@param vars? table any vars needed for the ui
function SynthB.song_info(info_queue, key, vars)
	if SynthB.mod.config.display_song_info then
		info_queue[#info_queue+1] = {set = "SongInfo", key = key, type="descriptions", vars = vars}
	end
end

--- Injects credits info_queue for a card,
--- respecting the set config value
--- @param info_queue table the info_queue to add the ui to
--- @param key string the key found within descriptions.MiscInfoQueue
--- @param vars? table any vars needed for the ui
function SynthB.card_credits(info_queue, key, vars)
	if SynthB.mod.config.display_card_credits then
		info_queue[#info_queue+1] = {set = "MiscInfoQueue", key = key, type = "descriptions", vars = vars}
	end
end

--- Injects Temperature info_queue for a card,
--- respecting the set config value
--- @param info_queue table the info_queue to add the ui to
function SynthB.heat_info(info_queue)
	if SynthB.mod.config.display_heat_info then
		info_queue[#info_queue+1] = {set = "MiscInfoQueue", key = "heat_explanation", type = "descriptions"}
	end
end

function SynthB.is_face(card)
	if card.debuff then return false end
	local id = card.base.id
	local rank = SMODS.Ranks[card.base.value]
	if not id then return false end
	return (id > 0 and rank and rank.face) or next(SMODS.find_card("j_pareidolia"))
end

function SynthB.draw_thermometer()
	local x = -1.425
	local y = 0.5
	--[[G.synthb_thermometer_bottom = UIBox{
		definition = G.UIDEF.synthb_thermometer_bottom(),
		config = {align='bli', offset = {x=x,y=y}, major=G.ROOM_ATTACH, type="room", bond = 'Weak', instance_type="NODE"}
	}]]
	G.synthb_thermometer_middle = UIBox{
		definition = G.UIDEF.synthb_thermometer_middle(),
		config = {align='bli', offset = {x=x,y=y}, major=G.ROOM_ATTACH, type="room", bond = 'Weak', instance_type="NODE"}
	}
	G.synthb_thermometer_top = UIBox{
		definition = G.UIDEF.synthb_thermometer_top(),
		config = {align='bli', offset = {x=x,y=y}, major=G.ROOM_ATTACH, type="room", bond = 'Weak', instance_type="UIBOX"}
	}
end

function SynthB.ease_temp(mod)
	local ret = SMODS.calculate_context({old_temp = G.GAME.synthb_temp or 0, new_temp = (G.GAME.synthb_temp or 0) + mod, mod_temp = mod})
	mod = ret and ret.mod_temp or mod
	G.GAME.synthb_temp = (G.GAME.synthb_temp or 0) + mod
	return function()
		G.E_MANAGER:add_event(Event{
			func = function()
				G.GAME.synthb_temp_c = G.GAME.synthb_temp .. " C"
				G.GAME.synthb_temp_thermo = 100 - math.min(100, G.GAME.synthb_temp)
				if (not G.synthb_thermometer_top or G.synthb_thermometer_top.REMOVED) and G.GAME.synthb_temp > 0 then
					SynthB.draw_thermometer()
				end
				if G.GAME.synthb_temp <= 0 and G.synthb_thermometer_top and not G.synthb_thermometer_top.REMOVED then
					G.synthb_thermometer_middle:remove()
					G.synthb_thermometer_top:remove()
				end
				if G.GAME.synthb_temp > 0 then
					G.synthb_thermometer_top:juice_up(0.4, 0.4*0.6)
					G.synthb_thermometer_middle:juice_up(0.4, 0.4*0.6)
				end
				return true
			end
		})
	end
end

function SynthB.heat_modify_effect(card, key, effect)
	local mod = 1 - SynthB.heat_mod()

	if effect.chip_mod then effect.chip_mod = effect.chip_mod * mod end
	if effect.chips then effect.chips = effect.chips * mod end
	if effect.h_chips then effect.h_chips = effect.h_chips * mod end

	if effect.mult_mod then effect.mult_mod = effect.mult_mod * mod end
	if effect.mult then effect.mult = effect.mult * mod end
	if effect.h_mult then effect.h_mult = effect.h_mult * mod end

	if effect.x_chips or 1 ~= 1 then effect.x_chips = effect.x_chips * mod end
	if effect.xchips or 1 ~= 1 then effect.xchips = effect.xchips * mod end
	if effect.Xchip_mod or 1 ~= 1 then effect.Xchip_mod = effect.Xchip_mod * mod end

	if effect.x_mult or 1 ~= 1 then effect.x_mult = effect.x_mult * mod end
	if effect.Xmult or 1 ~= 1 then effect.Xmult = effect.Xmult * mod end
	if effect.xmult or 1 ~= 1 then effect.xmult = effect.xmult * mod end
	if effect.x_mult_mod or 1 ~= 1 then effect.x_mult_mod = effect.x_mult_mod * mod end
	if effect.Xmult_mod or 1 ~= 1 then effect.Xmult_mod = effect.Xmult_mod * mod end
end

function SynthB.too_hot()
	return (G.GAME.synthb_temp or 0) > 100
end

function SynthB.heat_mod()
	return 1 - math.min(math.max((200 - G.GAME.synthb_temp) / 100, 0.01), 1)
end