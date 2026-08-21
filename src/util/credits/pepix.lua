SynthB.Credits.Contributor{
    key = "credits_pepix",
		name = "Pepix",
    mini_atlas = "credits_pepix_mini",
    synthb_role = {
        artists = true
    },
    colour = HEX("5CE207"),
    pos = {
        x = 0,
        y = 0
    },
    cost = 2763,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,

    atlas = 'pepix_credits',

		loc_vars = function(self, info_queue, card)
			if card.synthb_in_credits then return {key = "j_synthb_credits_pepix_2"}
			else
				info_queue[#info_queue+1] = G.P_CENTERS.j_synthb_machine_love
				info_queue[#info_queue+1] = G.P_CENTERS.e_negative
			end
		end,

		click = function (self)
			love.system.openURL("https://github.com/ImPepix-prog/Balatro-Refreshed-Full")
		end,
    
    set_ability = function(self, card, initial)
        card:set_eternal(true)
    end,
    
    calculate = function(self, card, context)
        if context.setting_blind  then
            return {
                func = function()
                    
                    local created_joker = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local joker_card = SMODS.add_card({key = 'j_synthb_machine_love' })
                            if joker_card then
                                joker_card:set_edition("e_negative", true)
                                
                            end
                            
                            return true
                        end
                    }))
                    
                    if created_joker then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Machine love!", colour = G.C.BLUE})
                    end
                    return true
                end
            }
        end
    end
}