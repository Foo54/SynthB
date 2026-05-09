SMODS.Sticker{
	key = "fake",
	--atlas = "stickers",
	pos = {x = 0, y = 0},
	badge_colour = HEX("6E6E6E"),
	rate = 0,
	never_scores = true
}

SMODS.Sticker{
	key = "linked",
	--atlas = "stickers",
	pos = {x = 1, y = 0},
	badge_colour = HEX("51EE61"),
	config = {
		extra = {
			id = 0
		}
	},
	rate = 0,
	calculate = function (self, card, context)
		if context.press_play then
		end
	end
}