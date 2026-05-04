SMODS.Shader({
	key = "mod_badge",
	path = "mod_badge.fs",
	send_vars = function (self, sprite, card)
		return {
			mask = SMODS.Atlases.synthb_mod_badge_mask.image
		}
	end
})

SMODS.Shader{
	key = "thermo",
	path = "thermo.fs",
	send_vars = function(self, sprite, card)
		return {
			temp = math.min(1, (G.GAME.synthb_temp or 0) / 100)
		}
	end
}

SMODS.ScreenShader{
	key = "heatwaves",
	path = "heatwaves.fs",
	order = 10000,
	should_apply = function (self)
		return SynthB.too_hot()
	end,
	send_vars = function(self)
		return {
			time = G.TIMERS.REAL,
			temp = SynthB.heat_mod()
		}
	end
}

SMODS.Shader({
	key = "miku",
	path = "covers/miku.fs"
})

SMODS.Shader({
	key = "teto",
	path = "covers/teto.fs"
})

SMODS.Shader({
	key = "kaito",
	path = "covers/kaito.fs"
})

SMODS.Shader({
	key = "meiko",
	path = "covers/meiko.fs"
})