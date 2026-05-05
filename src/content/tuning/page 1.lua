-- Pitch Bend
SynthB.Tuning{
	key = "tuning_pitch_bend",
	config = {max_highlighted = 3, min_highlighted = 3},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.max_highlighted}}
	end,
	use = function(self, card, area, copier)
		
	end,
}

