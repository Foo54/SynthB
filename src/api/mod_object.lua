
local function create_toggle_backwards(args)
  args = args or {}
  args.active_colour = args.active_colour or G.C.RED
  args.inactive_colour = args.inactive_colour or G.C.BLACK
  args.w = args.w or 3
  args.h = args.h or 0.5
  args.scale = args.scale or 1
  args.label = args.label or 'TEST?'
  args.label_scale = args.label_scale or 0.4
  args.ref_table = args.ref_table or {}
  args.ref_value = args.ref_value or 'test'

  local check = Sprite(0,0,0.5*args.scale,0.5*args.scale,G.ASSET_ATLAS["icons"], {x=1, y=0})
  check.states.drag.can = false
  check.states.visible = false

  local info = nil
  if args.info then 
    info = {}
    for k, v in ipairs(args.info) do 
      table.insert(info, {n=G.UIT.R, config={align = "cm", minh = 0.05}, nodes={
        {n=G.UIT.T, config={text = v, scale = 0.25, colour = G.C.UI.TEXT_LIGHT}}
      }})
    end
    info =  {n=G.UIT.R, config={align = "cm", minh = 0.05}, nodes=info}
  end

  local t = 
        {n=args.col and G.UIT.C or G.UIT.R, config={align = "cm", padding = 0.1, r = 0.1, colour = G.C.CLEAR, focus_args = {funnel_from = true}}, nodes={
          {n=G.UIT.C, config={align = "cl", minw = 0.4*args.scale + 0.1}, nodes={
            {n=G.UIT.C, config={align = "cm", r = 0.1, colour = G.C.BLACK}, nodes={
              {n=G.UIT.C, config={align = "cm", r = 0.1, padding = 0.03, minw = 0.4*args.scale, minh = 0.4*args.scale, outline_colour = G.C.WHITE, outline = 1.2*args.scale, line_emboss = 0.5*args.scale, ref_table = args,
                  colour = args.inactive_colour,
                  button = 'toggle_button', button_dist = 0.2, hover = true, toggle_callback = args.callback, func = 'toggle', focus_args = {funnel_to = true}}, nodes={
                  {n=G.UIT.O, config={object = check}
								},
              }},
            }}
          }},
          {n=G.UIT.C, config={align = "cl", minw = args.w}, nodes={
						{n = G.UIT.B, config = {w = 0.1, h = 0.1}},
            {n=G.UIT.T, config={text = args.label, scale = args.label_scale, colour = G.C.UI.TEXT_LIGHT}},
          }},
        }}
   if args.hide_label then 
       local t2 = {}
       for i = 1, #t.nodes do
           if i ~= 1 then table.insert(t2, t.nodes[i]) end
       end
       t.nodes = t2
   end
   if args.info then 
     t = {n=args.col and G.UIT.C or G.UIT.R, config={align = "cm"}, nodes={
       t,
       info,
     }}
   end
  return t
end

---@diagnostic disable: duplicate-set-field
function SynthB.mod.config_tab()
	return {n = G.UIT.ROOT, config = { r = 0.1, minw = 8, align = "tm", padding = 0.2, colour = G.C.BLACK }, nodes = {
		{n = G.UIT.R, config = { padding = 0.2 }, nodes = {
			{n = G.UIT.C, config = { align = "cr" }, nodes = {
				{n = G.UIT.R, config = { align = "cr", padding = 0.01 }, nodes = {
					create_toggle({
						label = "Enable All Info Toggles",
						ref_table = SynthB.mod.config,
						scale = 1.25,
						label_scale = 0.6,
						ref_value = 'display_misc_info'
					})
				}},
				{n = G.UIT.R, config = { align = "cr", padding = 0.01 }, nodes = {
					create_toggle({
						label = "Display Song Info",
						ref_table = SynthB.mod.config,
						ref_value = 'display_song_info'
					})
				}},
				{n = G.UIT.R, config = { align = "cr", padding = 0.01 }, nodes = {
					create_toggle({
						label = "Display Temperature Info",
						ref_table = SynthB.mod.config,
						ref_value = 'display_heat_info'
					})
				}},
				{n = G.UIT.R, config = { align = "cr", padding = 0.01 }, nodes = {
					create_toggle({
						label = "Display Energy Drink Info",
						ref_table = SynthB.mod.config,
						ref_value = 'display_energy_drink_info'
					})
				}},
				{n = G.UIT.R, config = { align = "cr", padding = 0.01 }, nodes = {
					create_toggle({
						label = "Display Blackjack Info",
						ref_table = SynthB.mod.config,
						ref_value = 'display_blackjack_info'
					})
				}},
			}},
			{n = G.UIT.C, config = { align = "cl", r = 0.1, colour = G.C.UI.TRANSPARENT_LIGHT}, nodes = {
				{n = G.UIT.B, config = {w = 0.1, h = 0.1}}
			}},
			{n = G.UIT.C, config = { align = "cl",}, nodes = {
				{n=G.UIT.B, config={w = 0.1, h = 0.1}},
			}},
			{n = G.UIT.C, config = { align = "cl" }, nodes = {
				{n = G.UIT.R, config = { align = "cl", padding = 0.01 }, nodes = {
					create_toggle_backwards({
						label = "Triple Click to View Song",
						ref_table = SynthB.mod.config,
						ref_value = 'triple_click_for_song'
					})
				}},
				{n = G.UIT.R, config = { align = "cl", padding = 0.01 }, nodes = {
					create_toggle_backwards({
						label = "Disable Non-Scoring Character Animations",
						ref_table = SynthB.mod.config,
						ref_value = 'disable_non_scoring_character_animations'
					})
				}},
				{n = G.UIT.R, config = { align = "cl", padding = 0.01 }, nodes = {
					create_toggle_backwards({
						label = "Allow Covers on Any Card",
						ref_table = SynthB.mod.config,
						ref_value = 'allow_covers_on_any_card'
					})
				}},
				{n = G.UIT.R, config = { align = "cl", padding = 0.01 }, nodes = {
					create_toggle_backwards({
						label = "Debug Mode",
						ref_table = SynthB.mod.config,
						ref_value = 'DEBUG'
					})
				}},
				{n = G.UIT.R, config = { align = "cl", padding = 0.01 }, nodes = {
					create_toggle_backwards({
						label = "Give Mizuki Zoomies",
						ref_table = SynthB.mod.config,
						ref_value = 'mizuki_zoomies'
					})
				}},
				{n = G.UIT.R, config = { align = "cl", padding = 0.01 }, nodes = {
					create_toggle_backwards({
						label = "Enable Experimental Features*",
						ref_table = SynthB.mod.config,
						ref_value = 'experimental_features'
					})
				}},
				{n = G.UIT.R, config = { align = "cl", padding = 0.01 }, nodes = {
					create_toggle_backwards({
						label = "Disable Deltarune Spoilers",
						ref_table = SynthB.mod.config.spoilers,
						ref_value = 'deltarune'
					})
				}}
				
			}}
		}},
		{n = G.UIT.R, config = {colour = G.C.UI.TRANSPARENT_LIGHT, r = 0.1}, nodes = {
			{n = G.UIT.B, config = {w = 0.1, h = 0.1}}
		}},
		{n = G.UIT.R, config = {align = "cm"}, nodes = {
			{n = G.UIT.T, config = {scale = 0.4, colour = G.C.UI.TEXT_LIGHT, text = "* Requires Restart"}}
		}}
	}}
end

function SynthB.mod.calculate(self, context)
	-- store destroyed cards
	if context.remove_playing_cards then
		for _, card in ipairs(context.removed) do
			table.insert(G.GAME.synthb_destroyed, 1, card:save())
		end
	end

	-- hand loss at start of round
	if context.setting_blind and (G.GAME.synthb_less_hands or 0) > 0 then
		ease_hands_played(-G.GAME.synthb_less_hands)
		G.GAME.synthb_less_hands = 0
	end
	
	if context.individual and context.cardarea == G.play then
		-- upgrade cards that have perma mult gain
		if context.other_card.ability.synthb_mult_gain then
			SMODS.scale_card(context.other_card, {
				ref_table = context.other_card.ability,
				ref_value = "perma_mult",
				scalar_value = "synthb_mult_gain"
			})
			context.other_card.ability.synthb_mult_duration = context.other_card.ability.synthb_mult_duration - 1
			if context.other_card.ability.synthb_mult_duration <= 0 then
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
			if context.other_card.ability.synthb_chips_duration <= 0 then
				context.other_card.ability.synthb_chips_duration = nil
				context.other_card.ability.synthb_chips_gain = nil
			end
		end
		-- upgrade cards that have perma xmult gain
		if context.other_card.ability.synthb_xmult_gain then
			SMODS.scale_card(context.other_card, {
				ref_table = context.other_card.ability,
				ref_value = "perma_x_mult",
				scalar_value = "synthb_xmult_gain"
			})
			context.other_card.ability.synthb_xmult_duration = context.other_card.ability.synthb_xmult_duration - 1
			if context.other_card.ability.synthb_xmult_duration <= 0 then
				context.other_card.ability.synthb_xmult_duration = nil
				context.other_card.ability.synthb_xmult_gain = nil
			end
		end

		-- downgrade cards that have perma xchips loss
		if context.other_card.ability.synthb_xchips_gain then
			SMODS.scale_card(context.other_card, {
				ref_table = context.other_card.ability,
				ref_value = "perma_x_chips",
				scalar_value = "synthb_xchips_gain"
			})
			context.other_card.ability.synthb_xchips_duration = context.other_card.ability.synthb_xchips_duration - 1
			if context.other_card.ability.synthb_xchips_duration <= 0 then
				context.other_card.ability.synthb_xchips_duration = nil
				context.other_card.ability.synthb_xchips_gain = nil
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

	if context.end_of_round and context.main_eval then
		-- heat money loss
		if SynthB.too_hot() then
			return {
				dollars = -math.ceil(G.GAME.dollars * SynthB.heat_mod())
			}
		end
		
		-- wish consumable slots loss
		if G.GAME.synthb_temp_consumable_duration then
			G.GAME.synthb_temp_consumable_duration = G.GAME.synthb_temp_consumable_duration - 1
			if G.GAME.synthb_temp_consumable_duration <= 0 then
				G.GAME.synthb_temp_consumable_duration = nil
				G.consumeables:change_size(-G.GAME.synthb_temp_consumable_size)
			end
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

	if context.round_eval then
		for _, card in ipairs(G.playing_cards) do
			-- Remove prevent debuff from cards undebuffed by regret rock
			SMODS.debuff_card(card, nil, "regret_rock")

			-- Update temporary linked cards
			if card.ability.synthb_linked and card.ability.synthb_linked.rounds then
				card.ability.synthb_linked.rounds = card.ability.synthb_linked.rounds - 1
				pcall(function() card:juice_up() end)
				if card.ability.synthb_linked.rounds <= 0 then
					card:remove_sticker("synthb_linked")
				end
			end
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

	-- Keep track of last consumable type used
	if context.using_consumeable then
		G.GAME.synthb_last_used_consumable_type = context.consumeable.config.center.set
	end
end

function SynthB.mod.reset_game_globals(run_start)
	if run_start then
		G.GAME.synthb_temp = 0
		G.GAME.synthb_linked_id = 0
		G.GAME.synthb_character_rate = 0
		G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
		G.GAME.synthb_destroyed = {}
	end
	if SynthB.mod.config.experimental_features then
		_, G.GAME.synthb_current_banner_key = pseudorandom_element(SynthB.banners, "synthb_round_banner")
	end
end

function G.FUNCS.synthb_change_credits_page(args)
---@type UIElement
---@diagnostic disable-next-line: undefined-field
	local e = G.OVERLAY_MENU:get_UIE_by_ID("synthb_credits_cycle")
	local box = UIBox{
		definition = G.UIDEF.synthb_create_credits_page(args.to_key),
		config = {parent = e}
	}
	e.config.object:remove()
	e.UIBox.definition.nodes[1].nodes[1].config.object = box
	e.UIBox:recalculate()
	e.config.object = box
end

function SynthB.mod.extra_tabs()
	local column_min_w = 6
	return {
		{
			label = "Credits",
			tab_definition_function = function()
				return {n = G.UIT.ROOT, config = { r = 0.1, minw = 8, align = "tm", padding = 0.2, colour = G.C.BLACK }, nodes = {
					{n = G.UIT.R, nodes = {
						{n = G.UIT.O, config = {id = "synthb_credits_cycle", object = UIBox{
							definition = G.UIDEF.synthb_create_credits_page(1),
							config = {}
						}}}
					}},
					{n = G.UIT.R, config = {align = "cm"}, nodes = {
						create_option_cycle{
							options = SynthB.Credits.list_of_people,
							opt_callback = "synthb_change_credits_page"
						}
					}}
				}}
				--[[return {n = G.UIT.ROOT, config = { r = 0.1, minw = 8, align = "tm", padding = 0.2, colour = G.C.BLACK }, nodes = {
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
												{n = G.UIT.T, config = {text = "Pepix", scale = 0.3, colour = G.C.UI.TEXT_DARK}},
											}},
											{n = G.UIT.R, nodes = {
												{n = G.UIT.T, config = {text = "Guaraná", scale = 0.3, colour = G.C.UI.TEXT_DARK}},
											}}
										}}
									}},
									{n = G.UIT.R, nodes = {
										{n = G.UIT.C, config = {align = "tl", padding = 0.1}, nodes = {
											{n = G.UIT.R, nodes = {
												{n = G.UIT.T, config = {text = "Text Only Placeholder Sprites - ThunderEdge", scale = 0.3, colour = G.C.UI.TEXT_DARK}},
											}},
											{n = G.UIT.R, nodes = {
												{n = G.UIT.T, config = {text = "Basic Art Placeholder Sprites - Foo54", scale = 0.3, colour = G.C.UI.TEXT_DARK}},
											}},
											{n = G.UIT.R, nodes = {
												{n = G.UIT.T, config = {text = "Mod Icon - LasagnaFelidae", scale = 0.3, colour = G.C.UI.TEXT_DARK}},
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
				}}]]
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
					song_buttons[#song_buttons].nodes[#song_buttons[#song_buttons].nodes+1] = SynthB.generate_song_button(data.key, i, data.prefix, data.set, data.spoiler)
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


function SynthB.mod.custom_card_areas(game)
	if SynthB.mod.config.experimental_features then
		local h = SynthB.CHAR_W * 5
		local w = SynthB.CHAR_H * 1.2
		game.synthb_character_area = CardArea(
			game.consumeables.T.x + game.consumeables.T.w + 0.1, game.consumeables.T.y,
			w, h,
			{
				card_limit = 5,
				type = "characters",
				card_count = true,
				highlight_limit = 1,
				highlighted_limit = 1,
				align_buttons = true,
			}
		)
	end

	game.synthb_imposter_area = CardArea(
		game.ROOM.T.x + game.ROOM.T.w + 10, 0,
		G.CARD_W, G.CARD_H,
		{
			card_limit = 2,
			type = "joker",
			highlight_limit = 1,
			highlighted_limit = 1,
		}
	)

	game.synthb_ghost_area = CardArea(
		game.ROOM.T.x + game.ROOM.T.w, 0,
		SynthB.GHOST_W, SynthB.GHOST_H,
		{
			card_limit = 2,
			type = "joker",
			highlight_limit = 1,
			highlighted_limit = 1,
		}
	)
	function game.synthb_ghost_area:align_cards (...)
		for k, card in ipairs(self.cards or {}) do
			if not card.states.drag.is and not card.disable_align then
				if card.ability.immutable.possessed then
					card.T.w = SynthB.GHOST_W
					card.T.h = SynthB.GHOST_H
				end
				local parent
				for _, _card in ipairs(G.jokers.cards) do
					if card.ability.immutable.possessed == _card.ability.synthb_pink_possess then
						parent = _card
						card.T.x = parent.VT.x - G.ROOM.T.x / 2 + 0.05 + parent.VT.w / 2 - 0.9 * (parent.VT.w / 2 + SynthB.GHOST_W + 0.1) * math.sin(card.synthb_orbit_timer or 0)
						if ((card.synthb_orbit_timer or 0) + math.pi / 2) % (math.pi * 2) <= math.pi then
							card.synthb_infront = true
						else
							card.synthb_infront = false
						end
						card.T.y = parent.VT.y - G.ROOM.T.y + parent.VT.h / 2 + (parent.VT.h / 4) * math.sin((card.synthb_orbit_timer or 0))
						card.T.r = math.max(-0.1, math.min(0.1, math.atan(card.T.y - card.VT.y, card.T.x - card.VT.x)))
						break
					end
				end
				if not parent then
					card.synthb_infront = true
				end
			end
		end
	end
	function game.synthb_ghost_area:draw(behind, ...)
		if not self.states.visible then return end 
		if G.VIEWING_DECK and (self==G.deck or self==G.hand or self==G.play) then return end

		local state = G.TAROT_INTERRUPT or G.STATE
		if behind then
			
			self:draw_boundingrect()
			add_to_drawhash(self)

			self.ARGS.draw_layers = self.ARGS.draw_layers or self.config.draw_layers or {'shadow', 'card'}
			for k, v in ipairs(self.ARGS.draw_layers) do
					for i = 1, #self.cards do 
							if self.cards[i] ~= G.CONTROLLER.focused.target then
									if not self.cards[i].highlighted and not self.cards[i].synthb_infront then
											if G.CONTROLLER.dragging.target ~= self.cards[i] then self.cards[i]:draw(v) end
									end
							end
					end
			end
		else
			self.ARGS.draw_layers = self.ARGS.draw_layers or self.config.draw_layers or {'shadow', 'card'}
			for k, v in ipairs(self.ARGS.draw_layers) do
					for i = 1, #self.cards do 
							if self.cards[i] ~= G.CONTROLLER.focused.target then
									if not self.cards[i].highlighted and self.cards[i].synthb_infront then
											if G.CONTROLLER.dragging.target ~= self.cards[i] then self.cards[i]:draw(v) end
									end
							end
					end
					for i = 1, #self.cards do  
							if self.cards[i] ~= G.CONTROLLER.focused.target then
									if self.cards[i].highlighted then
											if G.CONTROLLER.dragging.target ~= self.cards[i] then self.cards[i]:draw(v) end
									end
							end
					end
			end
		end
	end
end

if SynthB.mod.config.experimental_features then
	function SynthB.mod.custom_collection_tabs()
		local tally = 0
		for _, v in pairs(G.P_CENTER_POOLS.synthb_Character) do
			tally = tally + ((v.discovered and v.synthb_character ~= "padding") and 1 or 0)
		end
		return { UIBox_button {
			button = "synthb_your_collection_characters",
			label = { localize("b_synthb_characters") },
			count = { tally = tally, of = #G.P_CENTER_POOLS.synthb_Character - 4 },
			minw = 5,
			id = "synthb_your_collection_characters"
		} }
	end
end