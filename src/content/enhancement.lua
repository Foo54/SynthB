SMODS.Enhancement{
	key = "purple",
	atlas = "enhancements",
	config = {
		score = 100,
		xscore = 1.5
	},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, card, "empurple")
		return {vars = {card.ability.score, card.ability.xscore}}
	end,
	calculate = function(self, card, context)
		if context.main_scoring and context.cardarea == G.play then
			local i
			for index, _card in ipairs(context.full_hand) do
				if _card == card then
					i = index
					break
				end
			end
			local center = #context.full_hand / 2 + 0.5
			if i < center then
				return {
					xscore = card.ability.xscore
				}
			elseif i > center then
				return {
					score = card.ability.score
				}
			end
		end
	end,
}