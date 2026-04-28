---@diagnostic disable: duplicate-set-field
function SynthB.mod.config_tab()
	return {n = G.UIT.ROOT, config = { r = 0.1, minw = 8, align = "tm", padding = 0.2, colour = G.C.BLACK }, nodes = {
		{n = G.UIT.R, config = { padding = 0.2 }, nodes = {
			{n = G.UIT.C, config = { align = "cr" }, nodes = {
				{n = G.UIT.R, config = { align = "cr", padding = 0.01 }, nodes = {
					create_toggle({
						label = "Enable Song Info",
						ref_table = SynthB.mod.config,
						ref_value = 'display_song_info'
					})
				}}
			}}
		}}
	}}
end

function SynthB.mod.calculate(self, context)
	-- Remove prevent debuff from cards undebuffed by regret rock
	if context.round_eval then
		for _, card in ipairs(G.playing_cards) do
			SMODS.debuff_card(card, nil, "regret_rock")
		end
	end

	-- Remove permamult from cards boosted by machine love
	if context.discard then
		if context.other_card.ability.SynthB_machine_love_mult then
			context.other_card.ability.perma_mult = context.other_card.ability.perma_mult - context.other_card.ability.SynthB_machine_love_mult
			context.other_card.ability.SynthB_machine_love_mult = nil
		end
	end

	-- Keep track of if the last blind was one shot
	if context.after and G.GAME.blind then
		if SMODS.last_hand_oneshot then
			G.GAME.SynthB_oneshot_last_boss = true
		else
			G.GAME.SynthB_oneshot_last_boss = false
		end
	end
end

function SynthB.mod.extra_tabs()
	return {
		{
			label = "Credits",
			tab_definition_function = function()
				return {n = G.UIT.ROOT, config = { r = 0.1, minw = 8, align = "tl", padding = 0.2, colour = G.C.BLACK }, nodes = {
					{n = G.UIT.R, config = { padding = 0.2, align = "cl" }, nodes = {
						{n = G.UIT.C, config = { align = "cl" }, nodes = {
							{n = G.UIT.R, config = { align = "cl", padding = 0.01 }, nodes = {
								{n = G.UIT.T, config = {text = "Mod Name - mariofan", scale = 0.3, colour = G.C.UI.TEXT_LIGHT}}
							}}
						}}
					}}
				}}
			end
		}
	}
end