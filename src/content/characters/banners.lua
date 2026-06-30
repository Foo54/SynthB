SynthB.banners = {
	n25 = {
		key = "synthb_gacha_n25",
		pos = {x = 0, y = 0},
		colours = {
			background1 = SynthB.custom_colors.banners.n25.BACKGROUND,
			background2 = darken(G.C.BLACK, 0.2),
			ui = SynthB.custom_colors.banners.n25.UI,
			particles = {
				G.C.WHITE,
				SynthB.custom_colors.banners.n25.PARTICLES_1,
				SynthB.custom_colors.banners.n25.PARTICLES_2,
				G.C.GOLD,
			}
		},
		pool = function()
			return "char_synthb_miku_n25"
		end
	},
	vs = {
		key = "synthb_gacha_vs",
		pos = {x = 1, y = 0},
		colours = {
			background1 = SynthB.custom_colors.banners.vs.BACKGROUND,
			background2 = darken(G.C.BLACK, 0.2),
			ui = SynthB.custom_colors.banners.vs.UI,
			particles = {
				G.C.WHITE,
				SynthB.custom_colors.banners.vs.PARTICLES_1,
				SynthB.custom_colors.banners.vs.PARTICLES_2,
				G.C.GOLD,
			}
		},
		pool = function()
			local char
			while not char and not next(SMODS.find_card(char)) do
				char = pseudorandom_element({
					"char_synthb_miku1",
					"char_synthb_len1",
					"char_synthb_rin1",
					"char_synthb_luka1",
					"char_synthb_meiko1",
					"char_synthb_kaito1",
				}, "synthb_gacha_vs")
			end
			return char
		end
	}
}
