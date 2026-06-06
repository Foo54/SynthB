SynthB.Character{
	key = "miku1",
	config = {
		extra = {
			min_chips = 1.25,
			max_chips = 2,
			count = 10
		},
		immutable = {
			counted = 0
		}
	},
	loc_vars = function(self, info_queue, card)
		return {vars = {(card.fake_card or (card.area and card.area.config.collection)) and (card.ability.extra.min_chips .. "-" .. card.ability.extra.max_chips) or card.ability.extra.chips, card.ability.extra.count}}
	end,
	calculate = function(self, card, context)
		if context.press_play then
			card.ability.immutable.counted = 0
		end
		if context.synthb_mod_scoring then
			if card.ability.immutable.counted <= card.ability.extra.count then
				local mod = false
				if context.synthb_mod_scoring.chips then
					context.synthb_mod_scoring.chips = context.synthb_mod_scoring.chips * card.ability.extra.chips
					card.ability.immutable.counted = card.ability.immutable.counted + 1
					mod = true
				end
				if context.synthb_mod_scoring.mod_chips then
					context.synthb_mod_scoring.mod_chips = context.synthb_mod_scoring.mod_chips * card.ability.extra.chips
					card.ability.immutable.counted = card.ability.immutable.counted + 1
					mod = true
				end
				if mod then
					return {
						message = "X" .. number_format(card.ability.extra.chips),
						colour = G.C.CHIPS
					}
				end
			end
		end
	end,
	set_ability = function (self, card, initial, delay_sprites)
		card.ability.extra.chips = math.floor(SynthB.lerp(card.ability.extra.min_chips, card.ability.extra.max_chips, card.ability.immutable.level / 60 ) * 100) / 100
	end
}

SynthB.Character{
	key = "miku_ln",
	config = {
		extra = {

		}
	},
}