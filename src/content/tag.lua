SynthB.energy_drinks = {}

-- Overthinking Orange
SMODS.Tag{
	key = "drink_orange",
	config = {
		extra = {
			cards = 2
		}
	},
	loc_vars = function(self, info_queue, tag)
		return {vars = {tag.config.cards}}
	end,
	apply = function (self, tag, context)
		if context.
	end,
	in_pool = function(self, args)
		return false
	end
}