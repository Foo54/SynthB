--- Page 5



-- Fear Garden (code held together by hopes and dreams)
SynthB.Joker{
	key = "feargarden",
	pos = {x = 5, y = 1},
	atlas = "joker_placeholders",
	rarity = 3,
	cost = 7,
	synthb_credits = {
		Artist = "FurretWalk",
        Code = "FurretWalk"
	},
    config = {
        extra = {
			kills = 0,
            reap = 3,
            hands = 0,
            handmod = 1,
        },
        immutable = {
            scaled = false
        }
    },
    blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	demicolon_compat = true,
    attributes = {"hands", "song", "vocaloid song", "Chaa", "Rin"},
    	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, card, "feargarden")
        return {vars = { card.ability.extra.kills, card.ability.extra.reap, card.ability.extra.handmod, card.ability.extra.hands}}
	end,

    calculate = function(self,card,context)
        if context.end_of_round and context.main_eval and not context.blueprint then
            card.ability.immutable.scaled = false
        end
        if context.setting_blind or context.forcetrigger then 
            if card.ability.extra.hands > 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        ease_hands_played(card.ability.extra.hands)
                        SMODS.calculate_effect(
                            { message = localize { type = 'variable', key = 'a_hands', vars = { card.ability.extra.hands } } },
                            context.blueprint_card or card)
                        return true
                    end
                }))
            end
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
            if my_pos and G.jokers.cards[my_pos + 1] and not SMODS.is_eternal(G.jokers.cards[my_pos + 1], card) and not G.jokers.cards[my_pos + 1].getting_sliced then
                if context.blueprint then
                    if not card.ability.immutable.scaled then
                        if card.ability.extra.kills + 1 == card.ability.extra.reap then
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    ease_hands_played(card.ability.extra.hands)
                                    SMODS.calculate_effect(
                                        { message = localize { type = 'variable', key = 'a_hands', vars = { card.ability.extra.hands} } },
                                        context.blueprint_card or card)
                                    return true
                                end
                            }))
                        end
                    end
                else
                    card.ability.immutable.scaled = true
                    local sliced_card = G.jokers.cards[my_pos + 1]
                    sliced_card.getting_sliced = true 
                    G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                    if card.ability.extra.kills < card.ability.extra.reap - 1 then
                        card.ability.extra.kills = card.ability.extra.kills + 1
                    else
                        card.ability.extra.hands = card.ability.extra.hands + card.ability.extra.handmod
                        card.ability.extra.kills = 0
                    end
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.joker_buffer = 0
                            card:juice_up(0.8, 0.8)
                            SMODS.destroy_cards(sliced_card, {destroy_func = function(_card, args)
                                _card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
                                play_sound('slice1', 0.96 + math.random() * 0.08)
                            end})
                            return true
                        end
                    }))
                    if card.ability.extra.kills >= card.ability.extra.reap - 1 then
                        return {
                            message = localize { type = 'variable', key = 'a_hands', vars = { card.ability.extra.handmod } },
                            colour = G.C.BLUE,
                            no_juice = true,
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    ease_hands_played(card.ability.extra.handmod)
                                    return true
                                end
                            }))
                        }
                    end
                    if card.ability.extra.kills < card.ability.extra.reap - 1 then
                        return {
                            message = "SLICE!",
                            colour = G.C.RED,
                            no_juice = true
                        }
                    end
                end
            end
        end
    end,
    joker_display_def = function(JokerDisplay)
        ---@type JDJokerDefinition
        return {
            
        }
    end
}

-- furret why
-- this entire file uses 4 space tabs :sob:

-- Planet Webstar
SynthB.Joker{
    key = "planet_webstar",
    pos = {x = 7, y = 1},
    atlas = "joker_placeholders",
    synthb_credits = {
        Artist = "Foo54",
    },
    rarity = 2,
    cost = 7,
    perishable_compat = true,
    eternal_compat = true,
    blueprint_compat = true,
    demicolon_compat = true,
    attributes = {"song", "vocaloid song", "atena", "Merli", "Lapis"},
    loc_vars = function(self, info_queue, card)
        SynthB.song_info(info_queue, card, "planet_webstar")
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint and not card.synthb_target then
            card.synthb_target = context.other_card
        end
        if (context.final_scoring_step or context.forcetrigger) and card.synthb_target then
            local _context = SMODS.shallow_copy(context)
            _context.cardarea = G.play
            _context.final_scoring_step = nil
            _context.forcetrigger = nil
            SMODS.score_card(card.synthb_target, _context)
        end
        if context.after then
            card.synthb_target = nil
        end
    end,
}

-- Setsuna Trip
SynthB.Joker{
    key = "setsuna_trip",
    pos = {x = 2, y = 3},
    atlas = "joker_placeholders",
    synthb_credits = {
        Artist = "Foo54",
    },
    rarity = 2,
    cost = 6,
    perishable_compat = true,
    eternal_compat = true,
    blueprint_compat = false,
    demicolon_compat = true,
    config = {immutable = {prep = false}},
    attributes = {"discard", "passive", "song", "vocaloid song", "Last Note", "GUMI"},
    loc_vars = function(self, info_queue, card)
        SynthB.song_info(info_queue, card, "setsuna_trip")
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            card.ability.immutable.prep = true
        end
        if context.before and card.ability.immutable.prep then
            card.ability.immutable.prep = false
            for _, _card in ipairs(G.playing_cards) do
                _card.ability.synthb_setsuna = nil
            end
        end
        if context.pre_discard and not context.hook and G.GAME.current_round.discards_left == 1 then
            for _, _card in ipairs(context.full_hand) do
                _card.ability.synthb_setsuna = true
            end
        end
        if context.forcetrigger then
            for _, _card in ipairs(G.playing_cards) do
                if _card.ability.synthb_setsuna then
                    draw_card(_card.area, G.hand, 0.1, "up", true, _card)
                end
            end
        end
    end,
}

-- Hontono
SynthB.Joker{
    key = "hontono",
    pos = {x = 3, y = 3},
    atlas = "joker_placeholders",
    synthb_credits = {
        Artist = "Foo54",
    },
    cost = 4,
    perishable_compat = true,
    eternal_compat = false,
    blueprint_compat = false,
    demicolon_compat = true,
    config = {
        extra = {
            hands = 1
        }
    },
    attributes = {"hands", "stickers", "prevents_death", "song", "vocaloid song", "Haraguchi", "Teto"},
    loc_vars = function(self, info_queue, card)
        SynthB.song_info(info_queue, card, "hontono")
		info_queue[#info_queue + 1] = {set = "Other", key = "synthb_fake"}
        return {vars = {card.ability.extra.hands}}
    end,
    calculate = function(self, card, context)
		if (context.after and G.GAME.current_round.hands_left == 0) or context.forcetrigger then
			if G.GAME.chips + SMODS.calculate_round_score() < G.GAME.blind.chips or context.forcetrigger then
				ease_hands_played(card.ability.extra.hands)
                local targets = SMODS.shallow_copy(context.full_hand or G.play.cards)
                SMODS.destroy_cards(card)
                return {
                    message = localize("ph_synthb_stupid"),
                    font = 5,
                    func = function()
                        G.E_MANAGER:add_event(Event{
                            func = function()
                                for _, _card in ipairs(context.full_hand or G.play.cards) do
                                    _card:add_sticker("synthb_fake", true)
                                    _card:juice_up()
                                end
                                return true
                            end
                        })
                        return true
                    end
                }
            end
        end
    end,
}

-- Phony
SynthB.Joker{
    key = "phony",
    pos = {x = 4, y = 3},
    atlas = "joker_placeholders",
    synthb_credits = {
        Artist = "Foo54",
    },
    cost = 6,
    perishable_compat = true,
    eternal_compat = true,
    blueprint_compat = true,
    demicolon_compat = false,
    config = {
        extra = {
            xmult = 1.5,
            num = 1,
            dem = 2
        }
    },
	in_pool = function (self, args)
		for _, card in ipairs(G.playing_cards) do
			if card.ability.synthb_fake then
				return true
			end
		end
		return false
	end,
    attributes = {"xmult", "stickers", "song", "vocaloid song", "Tsumiki", "KAFU"},
    loc_vars = function(self, info_queue, card)
        SynthB.song_info(info_queue, card, "phony")
		info_queue[#info_queue + 1] = {set = "Other", key = "synthb_fake"}
        local num, dem = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.dem, "synthb_phony")
        return {vars = {localize{type = "name_text", set = "Other", key = "synthb_fake"}, card.ability.extra.xmult, num, dem}}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == "unscored" then
            if context.other_card.ability.synthb_fake then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
        if context.prevent_destroy_card then
            if context.prevent_destroy_card.ability.synthb_fake then
                if SMODS.pseudorandom_probability(card, "synthb_phony", card.ability.extra.num, card.ability.extra.dem) then
                    return {
                        prevent_destroy = true
                    }
                end
            end
        end
    end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{
					border_nodes = {
						{ text = "X" },
						{ ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
					}
				}
			},
			reminder_text = {
					{ text = "(Fake Cards)" },
			},
			calc_function = function(card)
					local xmult = 1
					local text, _, _ = JokerDisplay.evaluate_hand()
					if text ~= 'Unknown' then
						for _, _card in ipairs(JokerDisplay.current_hand) do
---@diagnostic disable-next-line: undefined-field
							if _card.ability.synthb_fake then
								xmult = xmult * card.ability.extra.xmult
							end
						end
					end
					card.joker_display_values.xmult = xmult
			end,
		}
	end
}

-- Ego Renegade Boy
SynthB.Joker{
    key = "ego_renegade_boy",
    pos = {x = 5, y = 3},
    atlas = "joker_placeholders",
    synthb_credits = {
        Artist = "Foo54",
    },
    cost = 5,
    perishable_compat = true,
    eternal_compat = true,
    blueprint_compat = false,
    demicolon_compat = false,
    attributes = {"king", "queen", "rank", "song", "vocaloid song", "Flavor Foley", "Rin", "Len"},
    loc_vars = function(self, info_queue, card)
        SynthB.song_info(info_queue, card, "ego_renegade_boy")
    end,
}