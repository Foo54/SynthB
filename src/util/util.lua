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


function SynthB.is_face(card)
	if card.debuff then return false end
	local id = card.base.id
	local rank = SMODS.Ranks[card.base.value]
	if not id then return false end
	return (id > 0 and rank and rank.face) or next(SMODS.find_card("j_pareidolia"))
end

function SynthB.draw_thermometer()
	G.synthb_thermometer_bottom = UIBox{
		definition = G.UIDEF.synthb_thermometer_bottom(),
		config = {align='bli', offset = {x=-1.425,y=0.5}, major=G.ROOM_ATTACH, type="room", bond = 'Weak', instance_type="NODE"}
	}
	G.synthb_thermometer_top = UIBox{
		definition = G.UIDEF.synthb_thermometer_top(),
		config = {align='bli', offset = {x=-1.425,y=0.5}, major=G.ROOM_ATTACH, type="room", bond = 'Weak', instance_type="UIBOX"}
	}
end

function SynthB.ease_temp(mod)
	SynthB.debug(mod)
	local ret = SMODS.calculate_context({old_temp = G.GAME.synthb_temp or 0, new_temp = (G.GAME.synthb_temp or 0) + mod, mod_temp = mod})
	mod = ret and ret.mod_temp or mod
	G.GAME.synthb_temp = (G.GAME.synthb_temp or 0) + mod
	G.GAME.synthb_temp_c = G.GAME.synthb_temp .. " C"
	if not G.synthb_thermometer_top and G.GAME.synthb_temp > 0 then
		SynthB.draw_thermometer()
	end
	if G.GAME.synthb_temp <= 0 and G.synthb_thermometer_bottom then
		G.synthb_thermometer_bottom:remove()
		G.synthb_thermometer_top:remove()
	end
end