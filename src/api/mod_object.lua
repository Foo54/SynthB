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
	local column_min_w = 6
	return {
		{
			label = "Credits",
			tab_definition_function = function()
				return {n = G.UIT.ROOT, config = { r = 0.1, minw = 8, align = "tm", padding = 0.2, colour = G.C.BLACK }, nodes = {
					{n = G.UIT.R, config = { padding = 0.2, align = "tm" }, nodes = {
						{n = G.UIT.C, config = {align = "tm"}, nodes = {
							{n = G.UIT.R, nodes = {
								{n = G.UIT.C, config = {align = "tm", padding = 0.2, r = 0.1, minw = column_min_w, colour = G.C.UI.BACKGROUND_LIGHT, outline_colour = G.C.UI.BACKGROUND_DARK, outline = 0.5}, nodes = {
									{n = G.UIT.R, nodes = {
										{n = G.UIT.C, config = {align = "cm", colour = G.C.UI.BACKGROUND_DARK, r = 0.1, padding = 0.1, minw = column_min_w}, nodes = {
											{n = G.UIT.T, config = {text = "Misc Credits", scale = 0.8, colour = G.C.UI.TEXT_LIGHT}}
										}}
									}},
									{n = G.UIT.R, nodes = {
										{n = G.UIT.C, config = {align = "tl", padding = 0.1}, nodes = {
											{n = G.UIT.R, nodes = {
												{n = G.UIT.T, config = {text = "Mod Name - mariofan", scale = 0.3, colour = G.C.UI.TEXT_DARK}},
											}}
										}}
									}}
								}}
							}},
							{n = G.UIT.R, nodes = {
								{n = G.UIT.B, config = {w=0.1, h = 0.2}}
							}},
							{n = G.UIT.R, nodes = {
								{n = G.UIT.C, config = {align = "tm", padding = 0.2, r = 0.1, minw = column_min_w, colour = G.C.UI.BACKGROUND_LIGHT, outline_colour = G.C.UI.BACKGROUND_DARK, outline = 0.5}, nodes = {
									{n = G.UIT.R, nodes = {
										{n = G.UIT.C, config = {align = "cm", colour = G.C.UI.BACKGROUND_DARK, r = 0.1, padding = 0.1, minw = column_min_w}, nodes = {
											{n = G.UIT.T, config = {text = "Art Credits", scale = 0.8, colour = G.C.UI.TEXT_LIGHT}}
										}}
									}},
									{n = G.UIT.R, nodes = {
										{n = G.UIT.C, config = {align = "tl", padding = 0.1}, nodes = {
											{n = G.UIT.R, nodes = {
												{n = G.UIT.T, config = {text = "Placeholder Sprites - ThunderEdge", scale = 0.3, colour = G.C.UI.TEXT_DARK}},
											}}
										}}
									}}
								}}
							}}
						}},
						{n = G.UIT.C, config = {align = "tm"}, nodes = {
							{n = G.UIT.R, nodes = {
								{n = G.UIT.C, config = {align = "tm", padding = 0.2, r = 0.1, minw = column_min_w, colour = G.C.UI.BACKGROUND_LIGHT, outline_colour = G.C.UI.BACKGROUND_DARK, outline = 0.5}, nodes = {
									{n = G.UIT.R, nodes = {
										{n = G.UIT.C, config = {align = "cm", colour = G.C.UI.BACKGROUND_DARK, r = 0.1, padding = 0.1, minw = column_min_w}, nodes = {
											{n = G.UIT.T, config = {text = "Shader Credits", scale = 0.8, colour = G.C.UI.TEXT_LIGHT}}
										}}
									}},
									{n = G.UIT.R, nodes = {
										{n = G.UIT.C, config = {align = "tl", padding = 0.1}, nodes = {
											{n = G.UIT.R, nodes = {
												{n = G.UIT.T, config = {text = "Mod Badge Shader Starting Code - mariofan", scale = 0.3, colour = G.C.UI.TEXT_DARK}},
											}},
											{n = G.UIT.R, nodes = {
												{n = G.UIT.T, config = {text = "Mod Badge Shader Help - SleepyG11", scale = 0.3, colour = G.C.UI.TEXT_DARK}},
											}}
										}}
									}}
								}}
							}},
							{n = G.UIT.R, nodes = {
								{n = G.UIT.B, config = {w=0.1, h = 0.2}}
							}},
							{n = G.UIT.R, nodes = {
								{n = G.UIT.C, config = {align = "tm", padding = 0.2, r = 0.1, minw = column_min_w, colour = G.C.UI.BACKGROUND_LIGHT, outline_colour = G.C.UI.BACKGROUND_DARK, outline = 0.5}, nodes = {
									{n = G.UIT.R, nodes = {
										{n = G.UIT.C, config = {align = "cm", colour = G.C.UI.BACKGROUND_DARK, r = 0.1, padding = 0.1, minw = column_min_w}, nodes = {
											{n = G.UIT.T, config = {text = "Special Thanks", scale = 0.8, colour = G.C.UI.TEXT_LIGHT}}
										}}
									}},
									{n = G.UIT.R, nodes = {
										{n = G.UIT.C, config = {align = "tl", padding = 0.1}, nodes = {
											{n = G.UIT.R, nodes = {
												{n = G.UIT.T, config = {text = "Potato Patch Discord", scale = 0.3, colour = G.C.UI.TEXT_DARK}},
											}},
											{n = G.UIT.R, nodes = {
												{n = G.UIT.T, config = {text = "Balatro Discord", scale = 0.3, colour = G.C.UI.TEXT_DARK}},
											}},
											{n = G.UIT.R, nodes = {
												{n = G.UIT.T, config = {text = "SMODS Wiki", scale = 0.3, colour = G.C.UI.TEXT_DARK}},
											}},
											{n = G.UIT.R, nodes = {
												{n = G.UIT.T, config = {text = "VanillaRemade", scale = 0.3, colour = G.C.UI.TEXT_DARK}},
											}}
										}}
									}}
								}}
							}},
						}},
					}}
				}}
			end
		}
	}
end