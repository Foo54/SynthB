--- Injects the SongInfo info_queue for a card,
--- respecting the set config value
--- @param info_queue table the info_queue to add the ui to
---@param key string the key found within descriptions.SongInfo
---@param vars? table any vars needed for the ui
function SynthB.song_info(info_queue, key, vars)
	if SynthB.mod.config.display_misc_info or SynthB.mod.config.display_song_info then
		info_queue[#info_queue+1] = {set = "SongInfo", key = key, type="descriptions", vars = vars}
	end
end

--- Injects credits info_queue for a card,
--- respecting the set config value
--- @param info_queue table the info_queue to add the ui to
--- @param key string the key found within descriptions.MiscInfoQueue
--- @param vars? table any vars needed for the ui
function SynthB.card_credits(info_queue, key, vars)
	if SynthB.mod.config.display_misc_info or SynthB.mod.config.display_card_credits then
		info_queue[#info_queue+1] = {set = "MiscInfoQueue", key = key, type = "descriptions", vars = vars}
	end
end

--- Injects Temperature info_queue for a card,
--- respecting the set config value
--- @param info_queue table the info_queue to add the ui to
function SynthB.heat_info(info_queue)
	if SynthB.mod.config.display_misc_info or SynthB.mod.config.display_heat_info then
		info_queue[#info_queue+1] = {set = "MiscInfoQueue", key = "heat_explanation", type = "descriptions"}
	end
end

function SynthB.is_face(card)
	if card.debuff then return false end
	local id = card.base.id
	local rank = SMODS.Ranks[card.base.value]
	if not id then return false end
	return (id > 0 and rank and rank.face) or next(SMODS.find_card("j_pareidolia")) or (next(SMODS.find_card("j_synthb_human")) and card:is_suit("Diamonds"))
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
	local ret = SMODS.calculate_context({old_temp = SynthB.get_temp(), new_temp = SynthB.get_temp() + mod, mod_temp = mod})
	mod = ret and ret.mod_temp or mod
	G.GAME.synthb_temp = G.GAME.synthb_temp + mod
	return function()
		G.E_MANAGER:add_event(Event{
			func = function()
				G.GAME.synthb_temp_c = SynthB.get_temp() .. " C"
				G.GAME.synthb_temp_thermo = 100 - math.min(100, SynthB.get_temp())
				if (not G.synthb_thermometer_top or G.synthb_thermometer_top.REMOVED) and SynthB.get_temp() > 0 then
					SynthB.draw_thermometer()
				end
				if SynthB.get_temp() <= 0 and G.synthb_thermometer_top and not G.synthb_thermometer_top.REMOVED then
					G.synthb_thermometer_middle:remove()
					G.synthb_thermometer_top:remove()
				end
				if SynthB.get_temp() > 0 then
					G.synthb_thermometer_top:juice_up(0.4, 0.4*0.6)
					G.synthb_thermometer_middle:juice_up(0.4, 0.4*0.6)
				end
				return true
			end
		})
		return true
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

function SynthB.get_temp()
	return (G.GAME or {}).synthb_temp or 0
end

function SynthB.too_hot()
	return SynthB.get_temp() > 100
end

function SynthB.heat_mod()
	return 1 - math.min(math.max((200 - SynthB.get_temp()) / 100, 0.01), 1)
end

--- links 2 cards together
--- @param cards Card[] list of cards to link
--- @param timer? integer how long until the cards unlink
function SynthB.link_cards(cards, timer)
	for _, card in ipairs(cards) do
		card:add_sticker("synthb_linked", true)
		card.ability.synthb_linked.id = G.GAME.synthb_linked_id
		card.ability.synthb_linked.rounds = timer
	end
	G.GAME.synthb_linked_id = G.GAME.synthb_linked_id + 1
end

--- Gets held Tell Your World
--- @returns Card|nil
function SynthB.tyw()
	return SMODS.find_card("j_synthb_tell_your_world")[1]
end

--- Adds energy drink info_queue
--- @param info_queue table
function SynthB.energy_drink_info(info_queue)
	if SynthB.mod.config.display_misc_info or SynthB.mod.config.display_energy_drink_info then
		info_queue[#info_queue+1] = {set = "MiscInfoQueue", key = "energy_drinks", type = "descriptions"}
	end
end

--- Gets a random energy drink key
--- @param seed string
function SynthB.random_energy_drink(seed)
	local pool = {}
	for _, tag_key in ipairs(SynthB.energy_drinks) do
		local good = true
		for _, tag in ipairs(G.GAME.tags) do
			if tag.key == tag_key then
				good = false
				break
			end
		end
		if good then
			pool[#pool+1] = tag_key
		end
	end
	if #pool == 0 then
		pool[1] = "tag_synthb_drink_orange" -- default
	end
	return pseudorandom_element(pool, seed)
end

--- Check if mod is loaded (taken from AikoShen)
function SynthB.is_mod_loaded (var)
	if not var then return false end
	return (SMODS.Mods[var] and SMODS.Mods[var].can_load) and true or false
end

--- Calculate Blackjack Score
--- @param cards CardArea|Card[]
--- @return integer score calculated score
--- @return boolean soft soft score (has an ace scoring 11)
function SynthB.blackjack_score (cards)
	local sum = 0
	if cards.cards then cards = cards.cards end
	local aces = 0
	for _, card in ipairs(cards) do
		sum = sum + card.base.nominal
		if card.base.id == 14 then aces = aces + 1 end
	end
	while sum > 21 and aces > 0 do
		sum = sum - 10
		aces = aces - 1
	end
	return sum, aces > 0
end


--- Adds blackjack rules info_queue
--- @param info_queue table
function SynthB.blackjack_info(info_queue)
	if SynthB.mod.config.display_misc_info or SynthB.mod.config.display_blackjack_info then
		info_queue[#info_queue+1] = {set = "MiscInfoQueue", key = "blackjack_rules", type = "descriptions"}
	end
end


--- Manips card values
--- @param card Card
--- @param func fun(key: any, val: number): number function to manipulate the value with
--- @param filter? fun(key: any, val: any): boolean function to filter what values are passed into func, defaults to only sending numbers
function SynthB.manip_card(card, func, filter)
	filter = filter or SynthB.base_manip_filter
	for key, value in pairs(card.ability) do
		if filter(key, value) then
			card.ability[key] = func(key, value)
		end
	end
	if card.ability.extra and type(card.ability.extra) == "table" then
		for key, value in pairs(card.ability.extra) do
			if filter(key, value) then
				card.ability.extra[key] = func(key, value)
			end
		end
	end
end

--- Base filter for SynthB.manip_card
--- @param key any
--- @param val any
--- @return boolean
function SynthB.base_manip_filter(key, val)
	return SynthB.is_number(val)
end

--- Check if value is number
--- @param value any
--- @return boolean
function SynthB.is_number(value)
	return type(value) == "number" or SynthB.is_big(value)
end

--- Check if value is bignum
--- @param value any
--- @return boolean
function SynthB.is_big(value)
	return is_big and is_big(value) or false
end

--- Lerp from one value to another
--- @param start number
--- @param _end number
--- @param amount number from [0, 1]
--- @return number
function SynthB.lerp(start, _end, amount)
	return start + (_end - start) * amount
end