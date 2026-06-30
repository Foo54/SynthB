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
	}
}