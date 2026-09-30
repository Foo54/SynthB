
---@diagnostic disable-next-line: missing-fields
SynthB.Credits.Contributor{
	key = "credits_incognito",
	colour = HEX("d0d0d0"),
	synthb_role = {artists2 = true},
	atlas = 'credits_incognito_full',
	mini_atlas = 'credits_incognito_mini',
	credit_vars = function (self)
		return {elements = {SMODS.create_sprite(0, 0, 5, 5, "synthb_incognito_corobo")}}
	end
}



---@diagnostic disable-next-line: missing-fields
SynthB.Credits.Contributor{
	key = "credits_stwuart",
	colour = HEX("643893"),
	synthb_role = {artists2 = true},
	--atlas = 'ghostsalt_full_credits',
	mini_atlas = 'credits_stwuart_mini',
}

---@diagnostic disable-next-line: missing-fields
SynthB.Credits.Contributor{
	key = "credits_guarana",
	synthb_role = {artists2 = true},
	mini_atlas = 'pjsk_placeholder_mini_icon'
}