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
			local loops = 0
			while not char or not next(SMODS.find_card(char)) and loops < 10 do
				loops = loops + 1
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
	},
	ln = {
		key = "synthb_gacha_ln",
		pos = {x = 2, y = 0},
		colours = {
			background1 = SynthB.custom_colors.banners.ln.BACKGROUND,
			background2 = darken(G.C.BLACK, 0.2),
			ui = SynthB.custom_colors.banners.ln.UI,
			particles = {
				G.C.WHITE,
				SynthB.custom_colors.banners.ln.PARTICLES_1,
				SynthB.custom_colors.banners.ln.PARTICLES_2,
				G.C.GOLD,
			}
		},
		pool = function()
			local char
			local loops = 0
			while not char or not next(SMODS.find_card(char)) and loops < 10 do
				loops = loops + 1
				char = pseudorandom_element({
					"char_synthb_miku_ln",
					"char_synthb_luka2",
				}, "synthb_gacha_ln")
			end
			return char
		end
	},
	mmj = {
		key = "synthb_gacha_mmj",
		pos = {x = 3, y = 0},
		colours = {
			background1 = SynthB.custom_colors.banners.mmj.BACKGROUND,
			background2 = darken(G.C.BLACK, 0.2),
			ui = SynthB.custom_colors.banners.mmj.UI,
			particles = {
				G.C.WHITE,
				SynthB.custom_colors.banners.mmj.PARTICLES_1,
				SynthB.custom_colors.banners.mmj.PARTICLES_2,
				G.C.GOLD,
			}
		},
		pool = function()
			local char
			local loops = 0
			while not char or not next(SMODS.find_card(char)) and loops < 10 do
				loops = loops + 1
				char = pseudorandom_element({
					"char_synthb_miku_mmj",
					"char_synthb_rin2",
				}, "synthb_gacha_mmj")
			end
			return char
		end
	},
	vbs = {
		key = "synthb_gacha_vbs",
		pos = {x = 4, y = 0},
		colours = {
			background1 = SynthB.custom_colors.banners.vbs.BACKGROUND,
			background2 = darken(G.C.BLACK, 0.2),
			ui = SynthB.custom_colors.banners.vbs.UI,
			particles = {
				G.C.WHITE,
				SynthB.custom_colors.banners.vbs.PARTICLES_1,
				SynthB.custom_colors.banners.vbs.PARTICLES_2,
				G.C.GOLD,
			}
		},
		pool = function()
			local char
			local loops = 0
			while not char or not next(SMODS.find_card(char)) and loops < 10 do
				loops = loops + 1
				char = pseudorandom_element({
					"char_synthb_miku_vbs",
					"char_synthb_len2",
					"char_synthb_meiko2"
				}, "synthb_gacha_vbs")
			end
			return char
		end
	},
	wxs = {
		key = "synthb_gacha_wxs",
		pos = {x = 5, y = 0},
		colours = {
			background1 = SynthB.custom_colors.banners.wxs.BACKGROUND,
			background2 = darken(G.C.BLACK, 0.2),
			ui = SynthB.custom_colors.banners.wxs.UI,
			particles = {
				G.C.WHITE,
				SynthB.custom_colors.banners.wxs.PARTICLES_1,
				SynthB.custom_colors.banners.wxs.PARTICLES_2,
				G.C.GOLD,
			}
		},
		pool = function()
			local char
			local loops = 0
			while not char or not next(SMODS.find_card(char)) and loops < 10 do
				loops = loops + 1
				char = pseudorandom_element({
					"char_synthb_miku_wxs",
					"char_synthb_kaito2"
				}, "synthb_gacha_wxs")
			end
			return char
		end
	},
}
