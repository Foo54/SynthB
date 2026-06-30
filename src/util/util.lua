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

--- Determine what value should be used based on level (numbers only) with boost
--- @param card Card
--- @param value string card.ability.extra[value]
--- @return number
function SynthB.get_character_boosted_value(card, value)
	local val = SynthB.get_character_value(card, value)
	local bonus = SynthB.get_character_boost(card, value)
	return val * bonus
end

--- Determine what value should be used based on level
--- @param card Card
--- @param value string card.ability.extra[value]
--- @return any
function SynthB.get_character_value(card, value)
	return card.ability.extra[value] or card.ability.extra[(SynthB.get_character_level(card) and "max_" or "min_") .. value]
end

--- Determine a characters level (hooking purposes)
--- @param card Card
--- @return boolean level true for 60, false for 1
function SynthB.get_character_level(card)
	return card.ability.immutable.level
end

--- Determines the current boost a character is getting
--- @param card Card
--- @param key? string
--- @return number multiplier mulitplier for stat-based effects
--- @return integer boost lever of boost, 2 is major, 0 is none
function SynthB.get_character_boost(card, key)
	if not G.jokers or #G.jokers.cards == 0 then return 1, 0 end
	key = key and ("_" .. key) or ""
	for _, song in ipairs(card.config.center.synthb_major) do
		if next(SMODS.find_card(song)) then return card.ability.extra["major_boost" .. key] or card.ability.extra.major_boost, 2 end
	end
	for _, song in ipairs(card.config.center.synthb_minor) do
		if next(SMODS.find_card(song)) then return card.ability.extra["minor_boost" .. key] or card.ability.extra.minor_boost, 1 end
	end
	return 1, 0
end

--- Gets text for displaying min/max level values in collection
--- @param card Card
--- @param value string see SynthB.get_character_boosted_value
--- @param seperator? string defaults to " / " (spaces will not be shown with {X:})
--- @param no_boost? boolean true to not take boosts into account
--- @returns string
function SynthB.get_character_loc_vars(card, value, seperator, no_boost)
---@diagnostic disable-next-line: undefined-field
	return (card.fake_card or (card.area and card.area.config.collection)) and (card.ability.extra[value] or (card.ability.extra["min_" .. value] .. (seperator or " / ") .. card.ability.extra["max_" .. value])) or (no_boost and SynthB.get_character_value or SynthB.get_character_boosted_value)(card, value)
end

function SynthB.alert_cardarea(card, area, msg)
  G.CONTROLLER.locks.no_space = true
  SynthB.attention_text({
		scale = 0.9, text = localize(msg), hold = 0.9, align = 'cm',
		cover = area, cover_padding = 0.1, cover_colour = adjust_alpha(G.C.BLACK, 0.7),
		text_rot = math.pi/2
  })
  card:juice_up(0.3, 0.2)
  for i = 1, #area.cards do
    area.cards[i]:juice_up(0.15)
  end
  G.E_MANAGER:add_event(Event({
		trigger = 'after',
		delay = 0.06*G.SETTINGS.GAMESPEED,
		blockable = false,
		blocking = false,
		func = function()
			play_sound('tarot2', 0.76, 0.4)
			return true
		end
	}))
	play_sound('tarot2', 1, 0.4)

	G.E_MANAGER:add_event(Event({
		trigger = 'after',
		delay = 0.5*G.SETTINGS.GAMESPEED,
		blockable = false,
		blocking = false,
		func = function()
			G.CONTROLLER.locks.no_space = nil
			return true
		end
	}))
end

function SynthB.attention_text(args)
	args = args or {}
	args.text = args.text or 'test'
	args.scale = args.scale or 1
	args.colour = SMODS.shallow_copy(args.colour or G.C.WHITE)
	args.hold = (args.hold or 0) + 0.1*(G.SPEEDFACTOR)
	args.pos = args.pos or {x = 0, y = 0}
	args.align = args.align or 'cm'
	args.emboss = args.emboss or nil

	args.fade = 1

	if args.cover then
		args.cover_colour = SMODS.shallow_copy(args.cover_colour or G.C.RED)
		args.cover_colour_l = SMODS.shallow_copy(lighten(args.cover_colour, 0.2))
		args.cover_colour_d = SMODS.shallow_copy(darken(args.cover_colour, 0.2))
	else
		args.cover_colour = copy_table(G.C.CLEAR)
	end

	args.uibox_config = {
		align = args.align or 'cm',
		offset = args.offset or {x=0,y=0}, 
		major = args.cover or args.major or nil,
	}

	G.E_MANAGER:add_event(Event({
		trigger = 'after',
		delay = 0,
		blockable = false,
		blocking = false,
		func = function()
			args.AT = UIBox{
				T = {args.pos.x,args.pos.y,0,0},
				definition = 
					{n=G.UIT.ROOT, config = {align = args.cover_align or 'cm', minw = (args.cover and args.cover.T.w or 0.001) + (args.cover_padding or 0), maxw = (args.cover and args.cover.T.w or 0.001) + (args.cover_padding or 0), no_overflow = "h", minh = (args.cover and args.cover.T.h or 0.001) + (args.cover_padding or 0), padding = 0.03, r = 0.1, emboss = args.emboss, colour = args.cover_colour}, nodes={
						{n=G.UIT.O, config={draw_layer = 1, object = DynaText({scale = args.scale, text_rot = args.text_rot, string = args.text, maxw = args.maxw, colours = {args.colour},float = true, shadow = true, silent = not args.noisy, args.scale, pop_in = 0, pop_in_rate = 6, rotate = args.rotate or nil, font = args.font})}},
					}}, 
				config = args.uibox_config
			}
			args.AT.attention_text = true

			if type(args.text) == 'string' then
				args.text = args.AT.UIRoot.children[1].config.object
---@diagnostic disable-next-line: undefined-field
				args.text:pulse(0.5)
			end
			
			if args.cover then
				Particles(args.pos.x,args.pos.y, 0,0, {
					timer_type = 'TOTAL',
					timer = 0.01,
					pulse_max = 15,
					max = 0,
					scale = 0.3,
					vel_variation = 0.2,
					padding = 0.1,
					fill=true,
					lifespan = 0.5,
					speed = 2.5,
					attach = args.AT.UIRoot,
					colours = {args.cover_colour, args.cover_colour_l, args.cover_colour_d},
			})
			end
			if args.backdrop_colour then
				args.backdrop_colour = SMODS.shallow_copy(args.backdrop_colour)
				Particles(args.pos.x,args.pos.y,0,0,{
					timer_type = 'TOTAL',
					timer = 5,
					scale = 2.4*(args.backdrop_scale or 1), 
					lifespan = 5,
					speed = 0,
					attach = args.AT,
					colours = {args.backdrop_colour}
				})
			end
			return true
		end
	}))

	G.E_MANAGER:add_event(Event({
		trigger = 'after',
		delay = args.hold,
		blockable = false,
		blocking = false,
		func = function()
			if not args.start_time then
				args.start_time = G.TIMERS.TOTAL
---@diagnostic disable-next-line: undefined-field
				if Object.is(args.text, DynaText) then
---@diagnostic disable-next-line: undefined-field
					args.text:pop_out(3)
				end
			else
				args.fade = math.max(0, 1 - 3*(G.TIMERS.TOTAL - args.start_time))
				if args.cover_colour then args.cover_colour[4] = math.min(args.cover_colour[4], 2*args.fade) end
				if args.cover_colour_l then args.cover_colour_l[4] = math.min(args.cover_colour_l[4], args.fade) end
				if args.cover_colour_d then args.cover_colour_d[4] = math.min(args.cover_colour_d[4], args.fade) end
				if args.backdrop_colour then args.backdrop_colour[4] = math.min(args.backdrop_colour[4], args.fade) end
				args.colour[4] = math.min(args.colour[4], args.fade)
				if args.fade <= 0 then
					args.AT:remove()
					return true
				end
			end
		end
	}))
end

--- Handles config stuff i dunno how to explain it
--- @param card Card
--- @param ret table
--- @return table?
--- @return boolean?
function SynthB.character_optional_return(card, ret)
	if SynthB.mod.config.disable_non_scoring_character_animations then
---@diagnostic disable-next-line: inject-field
		if card.synthb_triggered ~= nil then card.synthb_triggered = true end
		if ret.func then ret.func() end
		if ret.extra then SynthB.character_optional_return(card, ret.extra) end
		return {}, true
	else
		return ret
	end
end


SynthB.safe_return_keys = {
	chips = true, h_chips = true, chip_mod = true,
	mult = true, h_mult = true, mult_mod = true,
	x_chips = true, xchips = true, Xchip_mod = true,
	x_mult = true, Xmult = true, xmult = true, x_mult_mod = true, Xmult_mod = true,
	level_up = true,
	p_dollars = true, dollars = true, h_dollars = true,
	score = true, h_score = true,
	xscore = true, x_score = true, h_x_score = true, h_xscore = true,
	blind_size = true, blindsize = true, h_blind_size = true,  h_blindsize = true,
	xblind_size = true, x_blind_size = true, xblindsize = true, x_blindsize = true, h_x_blind_size = true, h_xblind_size = true,  h_x_blindsize = true, h_xblindsize = true,
	swap = true, balance = true,
}

--- Makes return tables safe to store in G.GAME
--- @param ret table
--- @return table
function SynthB.prune_return_table(ret)
	local out = {}
	for key in pairs(ret) do
		if SynthB.safe_return_keys[key] then out[key] = ret[key] end
	end
	if ret.extra then
		local extra = SynthB.safe_return_keys(ret.extra)
		if next(extra) then
			out.extra = extra
		end
	end
	return out
end


--- Checks if any other versions a character is obtained
--- @param char string
--- @return boolean
function SynthB.has_duplicates(char)
	for _, _card in ipairs(G.synthb_character_area.cards) do
		if _card.config.center.synthb_character == char then
			return true
		end
	end
	return false
end

--- removes child UI box if parent is removed
--- @param parent UIBox
--- @param ... UIBox children
function SynthB.link_UIBox(parent, ...)
	local parent_remove_ref = parent.remove
	local iter = {...}
	function parent:remove()
		parent_remove_ref(self)
		for _, box in ipairs(iter) do
			box:remove()
		end
	end
end