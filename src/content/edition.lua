SMODS.Edition{
	key = "cover_miku",
	shader = false,
	in_shop = true,
	weight = 20,
	config = {
		extra = {
			mult_scale = 10
		}
	},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.edition.extra.mult_scale}}
	end,
	valid_card = function(self, card)
		return card:has_attribute("mult") or card.config.center.set == "Default"
	end,
	modify_effect = function(card, key, effect)
		if effect.mult then
			effect.chips = (effect.chips or 0) + card.edition.extra.mult_scale * effect.mult
			effect.mult = nil
			effect.message = "Miku!"
			effect.colour = G.C.BLUE
		end
		if effect.mult_mod then
			effect.chips = (effect.chips or 0) + card.edition.extra.mult_scale * effect.mult_mod
			effect.mult_mod = nil
			effect.message = "Miku!"
			effect.colour = G.C.BLUE
		end
	end
}

SMODS.Edition{
	key = "cover_teto",
	shader = false,
	in_shop = true,
	weight = 20,
	config = {
		extra = {
			chips_scale = 5
		}
	},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.edition.extra.chips_scale}}
	end,
	valid_card = function(self, card)
		return card:has_attribute("chips") or card.config.center.set == "Default"
	end,
	modify_effect = function(card, key, effect)
		if effect.chips then
			effect.mult = (effect.mult or 0) + effect.chips / card.edition.extra.chips_scale
			effect.chips = nil
			effect.message = "Teto!"
			effect.colour = G.C.RED
		end
		if effect.chip_mod then
			effect.mult = (effect.mult or 0) + effect.chip_mod / card.edition.extra.chips_scale
			effect.chip_mod = nil
			effect.message = "Teto!"
			effect.colour = G.C.RED
		end
	end
}

SMODS.Edition{
	key = "cover_kaito",
	shader = false,
	in_shop = true,
	weight = 10,
	config = {
		extra = {
			mult_scale = 3
		}
	},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.edition.extra.mult_scale}}
	end,
	valid_card = function(self, card)
		return card:has_attribute("mult") or card.config.center.set == "Default"
	end,
	modify_effect = function(card, key, effect)
		if effect.mult then
			effect.xchips = (effect.xchips or 1) + effect.mult / card.edition.extra.mult_scale
			effect.mult = nil
			effect.message = "KAITO!"
			effect.colour = G.C.BLUE
		end
		if effect.mult_mod then
			effect.xchips = (effect.xchips or 1) + effect.mult_mod / card.edition.extra.mult_scale
			effect.mult_mod = nil
			effect.message = "KAITO!"
			effect.colour = G.C.BLUE
		end
	end
}

SMODS.Edition{
	key = "cover_meiko",
	shader = false,
	in_shop = true,
	weight = 10,
	config = {
		extra = {
			chips_scale = 50
		}
	},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.edition.extra.chips_scale}}
	end,
	valid_card = function(self, card)
		return card:has_attribute("chips") or card.config.center.set == "Default"
	end,
	modify_effect = function(card, key, effect)
		if effect.chips then
			effect.xmult = (effect.xmult or 1) + effect.chips / card.edition.extra.chips_scale
			effect.chips = nil
			effect.message = "MEIKO!"
			effect.colour = G.C.RED
		end
		if effect.chip_mod then
			effect.xmult = (effect.xmult or 1) + effect.chip_mod / card.edition.extra.chips_scale
			effect.chip_mod = nil
			effect.message = "MEIKO!"
			effect.colour = G.C.RED
		end
	end
}