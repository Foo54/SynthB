SMODS.Shader({
	key = "mod_badge",
	path = "mod_badge.fs",
	send_vars = function (self, sprite, card)
		return {
			mask = SMODS.Atlases.synthb_mod_badge_mask.image
		}
	end
})

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