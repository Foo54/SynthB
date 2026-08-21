
---@diagnostic disable-next-line: missing-fields
SynthB.Credits.Contributor{
	key = "credits_aiko",
	colour = HEX("FF00FF"),
	synthb_role = {artists = true},
	mini_atlas = 'credits_aiko_mini'
}


---@diagnostic disable-next-line: missing-fields
SynthB.Credits.Contributor{
	key = "credits_furret",
	colour = HEX("acbddf"),
	synthb_role = {artists = true, coders = true},
	atlas = 'furret_full_credits',
	mini_atlas = 'furret_mini_credits',
	credit_vars = function (self)
		return {elements = {SMODS.create_sprite(0, 0, 3, 3 / 296 * 256, "synthb_furret_tenma_credits")}}
	end
}

function G.FUNCS.synthb_walkies_shill(e)
	print("insert walkies link")
end

---@diagnostic disable-next-line: missing-fields
SynthB.Credits.Contributor{
	key = "credits_guarana",
	synthb_role = {artists2 = true},
	mini_atlas = 'pjsk_placeholder_mini_icon'
}
---@diagnostic disable-next-line: missing-fields
SynthB.Credits.Contributor{
	key = "credits_missingno",
	colour = HEX("ff7800"),
	synthb_role = {artists = true},
	atlas = "missingno_full_credits",
	mini_atlas = 'missingno_mini_credits',
	credit_vars = function (self)
		return {elements = {SMODS.create_sprite(0, 0, 8, 8 / 494 * 109, "synthb_missingno_oma_credits")}}
	end
}

function G.FUNCS.synthb_finity_shill (e)
	love.system.openURL("https://github.com/frangnosquest/Finity")
end

function G.FUNCS.synthb_0error_shill (e)
	love.system.openURL("https://github.com/notmario/0-ERROR")
end

function G.FUNCS.synthb_open_locaf (e)
	love.system.openURL("https://www.youtube.com/watch?v=GEMepvdruCo")
end

SMODS.Gradient{
	key = "rainbow",
	colours = {
		{1, 0, 0, 1},
		{1, 1, 0, 1},
		{0, 1, 0, 1},
		{0, 1, 1, 1},
		{0, 0, 1, 1},
		{1, 0, 1, 1}
	},
	cycle = 10
}

SMODS.Gradient{
	key = "marvin",
	colours = {
		HEX("0E12E6"),
		HEX("15E642"),
		HEX("D4E60E"),
	},
	cycle = 3
}