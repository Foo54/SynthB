if not SynthB.is_mod_loaded("baddirector") then return end

SynthB.debug("BadDirector loaded successfully")

SynthB.Joker{
	dependencies = {"baddirector"},
	key = "smokey_love",
	pos = {x = 1, y = 0},
	rarity = 2,
	cost = 7,
	eternal_compat = true,
	perishable_compat = true,
	blueprint_compat = false,
	demicolon_compat = false,
	attributes = {"suit", "hearts", "destroy_card", "song", "vocaloid song", "MEIKO", "Tonbi"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "smokey_love")
	end,
	calculate = function(self, card, context)
		if context.destroying_card and not context.blueprint then
			if not context.destroying_card:is_suit("Hearts") then
				local hearts = 0
				local enclosed = true
				local found = false
				for _, _card in ipairs(context.scoring_hand) do
					if _card:is_suit("Hearts") then
						if found then enclosed = true; break end
						hearts = hearts + 1
						enclosed = not enclosed
					end
					if _card == context.destroying_card then
						found = true
						if hearts % 2 == 0 then enclosed = false; break end
					end
				end
				return {
					remove = enclosed and true or nil
				}
			end
		end
	end,
}

SynthB.inject_song_data{link = "https://www.youtube.com/watch?v=6_Fci4Y8CUk", key = "smokey_love", pos = {x = 2, y = 9}}