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

SynthB.custom_colors = {
	LIGHT_GREEN = HEX("99e550"),
	
}