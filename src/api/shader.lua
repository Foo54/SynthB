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
			temp = math.min(1, SynthB.get_temp() / 100)
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
	path = "covers/miku.fs",
	send_vars = function (sprite, card)
		return {
			color_ = {0.4254901960784314, 0.707843137254902, 0.696078431372549, 1},
			mask = SMODS.Atlases.synthb_miku_mask.image
		}
	end
})

SMODS.Shader({
	key = "teto",
	path = "covers/teto.fs",
	send_vars = function (sprite, card)
		return {
			color_ = {0.8313725490196079, 0.41568627450980394, 0.5137254901960784, 1},
			mask = SMODS.Atlases.synthb_teto_mask.image
		}
	end
})

SMODS.Shader({
	key = "kaito",
	path = "covers/kaito.fs"
})

SMODS.Shader({
	key = "meiko",
	path = "covers/meiko.fs"
})

SMODS.Shader({
	key = "retry_now",
	path = "retry_now.fs",
	---@param card Card
	send_vars = function(sprite, card)
		return {
			brightness = card and card.ability.immutable.brightness or 1
		}
	end
})

SMODS.Shader{
	key = "streetcat",
	path = "streetcat.fs",
	send_vars = function(sprite, card)
		return {
---@diagnostic disable-next-line: undefined-field
			color = card and card.synthb_colour or {0, 0, 0, 1},
---@diagnostic disable-next-line: undefined-field
			old_color = card and card.synthb_old_colour,
---@diagnostic disable-next-line: undefined-field
			changed_at = card and card.synthb_changed_at,
			_time = G.TIMERS.REAL
		}
	end
}
