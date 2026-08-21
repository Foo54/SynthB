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
            handmod = 1
            }
		},
    blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	demicolon_compat = false,
    attributes = {"hands", "song", "vocaloid song", "Chaa", "Rin"},
    	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, card, "feargarden")
        return {vars = { card.ability.extra.kills, card.ability.extra.reap, card.ability.extra.handmod, card.ability.extra.hands}}
	end,

    
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
    end,

    calculate = function(self,card,context)
            if context.setting_blind then 
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
            if not context.blueprint then
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
            if my_pos and G.jokers.cards[my_pos + 1] and not SMODS.is_eternal(G.jokers.cards[my_pos + 1], card) and not G.jokers.cards[my_pos + 1].getting_sliced then
                local sliced_card = G.jokers.cards[my_pos + 1]
                sliced_card.getting_sliced = true 
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.joker_buffer = 0
                        if card.ability.extra.kills < card.ability.extra.reap - 1 then
                            card.ability.extra.kills = card.ability.extra.kills + 1
                        else
                            card.ability.extra.hands = card.ability.extra.hands + card.ability.extra.handmod
                            card.ability.extra.kills = 0
                         end
                        card:juice_up(0.8, 0.8)
                        sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
                        play_sound('slice1', 0.96 + math.random() * 0.08)
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
                    end}))
                }
            end if card.ability.extra.kills < card.ability.extra.reap - 1 then
                return {
                    message = "SLICE!",
                    colour = G.C.RED,
                    no_juice = true
                }
            end
        end
            end
            end
end
}