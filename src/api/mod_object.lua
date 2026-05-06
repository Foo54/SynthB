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
				}},
				{n = G.UIT.R, config = { align = "cr", padding = 0.01 }, nodes = {
					create_toggle({
						label = "Display Additional Card Credits",
						ref_table = SynthB.mod.config,
						ref_value = 'display_card_credits'
					})
				}},
				{n = G.UIT.R, config = { align = "cr", padding = 0.01 }, nodes = {
					create_toggle({
						label = "Display Temperature Information",
						ref_table = SynthB.mod.config,
						ref_value = 'display_heat_info'
					})
				}},
				{n = G.UIT.R, config = { align = "cr", padding = 0.01 }, nodes = {
					create_toggle({
						label = "Triple Click to View Song",
						ref_table = SynthB.mod.config,
						ref_value = 'triple_click_for_song'
					})
				}},
				{n = G.UIT.R, config = { align = "cr", padding = 0.01 }, nodes = {
					create_toggle({
						label = "Allow Covers on Any Card",
						ref_table = SynthB.mod.config,
						ref_value = 'allow_covers_on_any_card'
					})
				}},
				{n = G.UIT.R, config = { align = "cr", padding = 0.01 }, nodes = {
					create_toggle({
						label = "Debug Mode",
						ref_table = SynthB.mod.config,
						ref_value = 'DEBUG'
					})
				}}
			}}
		}}
	}}
end

function SynthB.mod.calculate(self, context)
	
	if context.individual and context.cardarea == G.play then
		-- upgrade cards that have perma mult gain
		if context.other_card.ability.synthb_mult_gain then
			SMODS.scale_card(context.other_card, {
				ref_table = context.other_card.ability,
				ref_value = "perma_mult",
				scalar_value = "synthb_mult_gain"
			})
			context.other_card.ability.synthb_mult_duration = context.other_card.ability.synthb_mult_duration - 1
			if context.other_card.ability.synthb_mult_duration == 0 then
				context.other_card.ability.synthb_mult_duration = nil
				context.other_card.ability.synthb_mult_gain = nil
			end
		end

		-- downgrade cards that have perma chips loss
		if context.other_card.ability.synthb_chips_gain then
			SMODS.scale_card(context.other_card, {
				ref_table = context.other_card.ability,
				ref_value = "perma_bonus",
				scalar_value = "synthb_chips_gain"
			})
			context.other_card.ability.synthb_chips_duration = context.other_card.ability.synthb_chips_duration - 1
			if context.other_card.ability.synthb_chips_duration == 0 then
				context.other_card.ability.synthb_chips_duration = nil
				context.other_card.ability.synthb_chips_gain = nil
			end
		end
	end

	-- heat debuff card
	if context.debuff_card then
		if SynthB.too_hot() then
			if context.debuff_card.config.center.set == "Default" then
				if SMODS.pseudorandom_probability(nil, "synthb_heat_debuff_card", SynthB.get_temp() - 100, 100, nil, true) then
					return {
						debuff = true
					}
				end
			end
		end
	end

	-- heat money loss
	if context.end_of_round and context.main_eval then
		if SynthB.too_hot() then
			return {
				dollars = -math.ceil(G.GAME.dollars * SynthB.heat_mod())
			}
		end
	end

	-- heat debuff hand
	if context.debuff_hand and not context.check then
		if SynthB.too_hot() then
			if SMODS.pseudorandom_probability(nil, "synthb_heat_debuff_hand", SynthB.get_temp() - 100, 100, nil, true) then
				return {
					debuff = true
				}
			end
		end
	end

	-- lower heat
	if context.starting_shop  and SynthB.get_temp() > 1 then
		return {
			func = SynthB.ease_temp(-1)
		}
	end

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

function SynthB.mod.reset_game_globals(run_start)
	if run_start then
		G.GAME.synthb_temp = 0
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
											}},
											{n = G.UIT.R, nodes = {
												{n = G.UIT.T, config = {text = "Vocaloid Lyrics Wiki", scale = 0.3, colour = G.C.UI.TEXT_DARK}},
											}},
											{n = G.UIT.R, nodes = {
												{n = G.UIT.T, config = {text = "chigago", scale = 0.3, colour = G.C.UI.TEXT_DARK}},
											}}
										}}
									}}
								}}
							}},
						}},
					}}
				}}
			end
		},
		{
			label = "Songs",
			tab_definition_function = function()
				local buttons_per_row = 3
				local song_buttons = {
					{n = G.UIT.R, nodes = {}}
				}
				for i, data in pairs(SynthB.songs) do
					if #song_buttons[#song_buttons].nodes == buttons_per_row * 2 then
						song_buttons[#song_buttons].nodes[#song_buttons[#song_buttons].nodes] = nil
						song_buttons[#song_buttons+1] = {n = G.UIT.R, nodes = {{n = G.UIT.B, config = {w=0.1, h=0.1}}}}
						song_buttons[#song_buttons+1] = {n = G.UIT.R, nodes = {}}
					end
					song_buttons[#song_buttons].nodes[#song_buttons[#song_buttons].nodes+1] = SynthB.generate_song_button(data.key, i)
					song_buttons[#song_buttons].nodes[#song_buttons[#song_buttons].nodes+1] = {n = G.UIT.C, nodes = {{n = G.UIT.B, config = {w=0.1, h=0.1}}}}
				end
				local scrollbox = SMODS.UIScrollBox{
					content = {
						definition = {n = G.UIT.ROOT, config = {colour = G.C.CLEAR}, nodes = {
							{n = G.UIT.C, config = {}, nodes = song_buttons}
						}},
						config = {align = "cm"}
					},
					overflow = {
						node_config = {
							maxh = 9,
							r = 0.1,
						},
					},
				}
				return {n = G.UIT.ROOT, config = { r = 0.1, minw = 8, align = "tm", padding = 0.2, colour = G.C.BLACK }, nodes = {
					{n = G.UIT.C, config = { align = "cm"}, nodes = {
						{n = G.UIT.O, config = {align = "cm", object = scrollbox}}
					}},
					{n = G.UIT.C, nodes = {
						SMODS.GUI.scrollbar({
							h = 9,
							w = 0.2,
							min = 0,
							max = 1,
							bg_colour = { 0, 0, 0, 0.15 },
							scroll_collision_obj = scrollbox,
							knob_h = 0.6,
							scroll_mult = 3
						})
					}}
				}}
			end
		}
	}
end

function G.FUNCS.go_to_synthb_discord(e)
	love.system.openURL("https://discord.gg/G7xRjTV43h")
end

SynthB.mod.ui_config = {
	tab_button_colour = SynthB.custom_colors.LIGHT_GREEN,
	back_colour = darken(SynthB.custom_colors.LIGHT_GREEN, 0.2),
	collection_option_cycle_colour = darken(SynthB.custom_colors.LIGHT_GREEN, 0.3)
}

function SynthB.mod.custom_ui (mod_nodes)
  mod_nodes = EMPTY(mod_nodes)
  local node1 = {n = G.UIT.C, config = { w = 8, align = "tm", r = 0.1 , h = 6, padding = 0.2}, nodes = {
		{n = G.UIT.R, config = { align = "tm" }, nodes = {
			{ n = G.UIT.O, config = {object = SMODS.create_sprite(0, 0, 10, 4, "synthb_logo")}}
		}},
		{n = G.UIT.R, config = { align = "tm" }, nodes = {
			{n = G.UIT.C, config = {padding = 0.2}, nodes = {
				{n = G.UIT.R, config = {}, nodes = {
					{ n = G.UIT.T, config = { text = "Created by:", scale = 0.5, colour = G.C.WHITE } }
				}},
				{n = G.UIT.R, config = {}, nodes = {
					{ n = G.UIT.T, config = { text = "Foo54", scale = 0.75, colour = G.C.WHITE } }
				}},
				{n = G.UIT.R, config = {}, nodes = {
					UIBox_button({
						colour = HEX('5865F2'), minw = 3.5, minh = 1, padding = 0.1, emboss = 0.2, button = "go_to_synthb_discord", label = {"Join the Discord!"}
					})
				}},
			}},
		}},
  }}
  table.insert(mod_nodes, node1)
end