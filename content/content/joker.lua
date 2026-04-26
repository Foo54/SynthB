SMODS.Joker{
	key = "anataniiteno",
	config = {
		extra = {
			suit = "Clubs",
			mult = 6
		}
	},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.suit, card.ability.extra.mult}}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.hand then
			if context.other_card:is_suit(card.ability.extra.suit) then
				return {
					mult = card.ability.extra.mult
				}
			end
		end
	end
}