if not SynthB.is_mod_loaded("aikoyorisshenanigans") then return false end

SynthB.debug("AikoShen loaded successfully")

SynthB.Joker{
	dependancies = {"aikoyorisshenanigans"},
	key = "weathergirl",
	pos = {x = 1, y = 0},
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			num = 1
		}
	},
	eternal_compat = true,
	perishable_compat = true,
	blueprint_compat = true,
	demicolon_compat = true,
	attributes = {"modify_card", "chance", "enhancements", "position", "song", "vocaloid song", "Forte", "Flavor Foley"},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_akyrs_droplet_card
		SynthB.song_info(info_queue, "weathergirl")
		local num, _ = SMODS.get_probability_vars(card, card.ability.extra.num, 5, "synthb_aikoshen_weathergirl")
		return {vars = {num, localize{type = "name_text", set = "Enhanced", key = "m_akyrs_droplet_card"}}}
	end,
	calculate = function(self, card, context)
		if context.before or (context.forcetrigger and G.play.cards) then
			for i, _card in ipairs(G.play.cards) do
				if context.forcetrigger or SMODS.pseudorandom_probability(card, "synthb_aikoshen_weathergirl", card.ability.extra.num, i) then
					_card:set_ability("m_akyrs_droplet_card")
					_card:juice_up()
				end
			end
		end
	end,
}

SynthB.inject_song_data{link = "https://www.youtube.com/watch?v=M7VSEZOQIlg", key = "weathergirl", pos = {x = 1, y = 8}}