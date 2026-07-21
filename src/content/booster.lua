SMODS.Booster{
	key = "diva_normal_1",
	weight = 3,
	kind = "synthb_diva",
	cost = 4,
	pos = {x=0, y=1},
	atlas = "booster",
	group_key = "k_worm_diva_pack",
	config = {extra = 2, choose = 1},
	synthb_credits = {
		Artist = "Foo54",
	},
	loc_vars = function(self, info_queue, card)
		local cfg = (card and card.ability) or self.config
		return {
---@diagnostic disable-next-line: need-check-nil
			vars = { cfg.choose, cfg.extra, "" },
			key = self.key:sub(1, -10)
		}
	end,
	ease_background_colour = SynthB.ease_background_colour_diva_pack,
	particles = SynthB.diva_pack_particles,
	create_card = function(self, card, i)
		return {
			attributes = {"vocaloid song"},
			area = G.pack_cards,
			skip_materialize = true,
			--soulable = true,
		}
	end,
}

SMODS.Booster{
	key = "diva_normal_2",
	weight = 3,
	kind = "synthb_diva",
	cost = 4,
	pos = {x=1, y=1},
	atlas = "booster",
	group_key = "k_worm_diva_pack",
	config = {extra = 2, choose = 1},
	synthb_credits = {
		Artist = "Foo54",
	},
	loc_vars = function(self, info_queue, card)
		local cfg = (card and card.ability) or self.config
		return {
---@diagnostic disable-next-line: need-check-nil
			vars = { cfg.choose, cfg.extra, "" },
			key = self.key:sub(1, -10)
		}
	end,
	ease_background_colour = SynthB.ease_background_colour_diva_pack,
	particles = SynthB.diva_pack_particles,
	create_card = function(self, card, i)
		return {
			attributes = {"vocaloid song"},
			area = G.pack_cards,
			skip_materialize = true,
			--soulable = true,
		}
	end,
}

SMODS.Booster{
	key = "diva_normal_3",
	weight = 3,
	kind = "synthb_diva",
	cost = 4,
	pos = {x=2, y=1},
	atlas = "booster",
	group_key = "k_worm_diva_pack",
	config = {extra = 2, choose = 1},
	synthb_credits = {
		Artist = "Pepix",
	},
	loc_vars = function(self, info_queue, card)
		local cfg = (card and card.ability) or self.config
		return {
---@diagnostic disable-next-line: need-check-nil
			vars = { cfg.choose, cfg.extra, "" },
			key = self.key:sub(1, -10)
		}
	end,
	ease_background_colour = SynthB.ease_background_colour_diva_pack,
	particles = SynthB.diva_pack_particles,
	create_card = function(self, card, i)
		return {
			attributes = {"vocaloid song"},
			area = G.pack_cards,
			skip_materialize = true,
			--soulable = true,
		}
	end,
}