
---@diagnostic disable-next-line: missing-fields
SynthB.Credits.Contributor{
	key = "credits_inky",
	synthb_role = {artists2 = true},
	colour = HEX("189bcc"),
	mini_atlas = 'inky_mini_credits',
	atlas = "inky_full_credits",
	soul_pos = {x = 1, y = 0}
}

function G.FUNCS.synthb_pjsk_credits_inky_kofi(e)
	love.system.openURL("https://ko-fi.com/inkystanderson")
end