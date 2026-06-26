local scale = 0.7

--Modifies the slider value if it is being dragged. e contains the 'container' for the bar and
--c contains the 'child' for the bar. either can be dragged. The value is lerped between the size
--of the child bar and the parent bar depending on any min/max values. Also changes the display text for the slider.
--
---@param e {}
--**e** Is the slider UIE that called this function
function G.FUNCS.synthb_slider(e)
  local c = e.children[1]
	c.T.h = (c.config.ref_table.ref_table[c.config.ref_table.ref_value] - c.config.ref_table.min)/(c.config.ref_table.max - c.config.ref_table.min)*c.config.ref_table.h
	c.config.h = c.T.h
end

function G.UIDEF.synthb_thermometer_middle ()
	local w = 1 * scale * 0.8
	local h = 3.81 * scale * 0.9
	return {n = G.UIT.ROOT, config = {colour = G.C.CLEAR}, nodes = {
		{n=G.UIT.C, config={align = "cm", minw = w, min_h = h, padding = 0.1, r = 0.1, colour = G.C.CLEAR}, nodes={
			{n=G.UIT.C, config={align = "cl", minw = w, r = 0.1,min_h = h, colour = G.C.RED,func = 'synthb_slider', refresh_movement = true}, nodes={
				{n=G.UIT.B, config={w=w,h=h, r = 0.1, colour = G.C.WHITE, ref_table = {
					ref_table = G.GAME,
					ref_value = "synthb_temp_thermo",
					min = 1,
					max = 100,
					w = w,
					h = h,
					hide_value = true
				}, refresh_movement = true}},
			}},
		}}
	}}
end


function G.UIDEF.synthb_thermometer_top ()
	return {n = G.UIT.ROOT, config = {colour = G.C.CLEAR}, nodes = {
		{n = G.UIT.R, config = {
			colour = G.C.CLEAR,
			tooltip = {
				title = "Current Temperature",
				text = {{ref_table = G.GAME, ref_value = "synthb_temp_c"}},
				align = "cr"
			}
		}, nodes = {
			{n = G.UIT.O, config = {
				shader = "synthb_thermo",
				object = SMODS.create_sprite(0, 0, 1 * scale, 3.81 * scale, "synthb_thermometer", {x = 0, y = 0})
			}}
		}}
	}}
end

function G.FUNCS.synthb_can_lower(e)
	if e.config.ref_table.ability.immutable.betting >= e.config.ref_table.ability.immutable.raise then
		e.config.colour = G.C.RED
		e.config.button = "synthb_lower"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

function G.FUNCS.synthb_can_raise(e)
	if e.config.ref_table.ability.extra.xmult >= e.config.ref_table.ability.immutable.betting + e.config.ref_table.ability.immutable.raise then
		e.config.colour = G.C.RED
		e.config.button = "synthb_raise"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

function G.FUNCS.synthb_lower (e)
	e.config.ref_table.ability.immutable.betting = e.config.ref_table.ability.immutable.betting - e.config.ref_table.ability.immutable.raise
end
function G.FUNCS.synthb_confirm (e)
	e.config.ref_table.ability.immutable.STATE = e.config.ref_table.ability.immutable.STATES[e.config.ref_table.ability.immutable.betting == 0 and "CONTINUE" or "PLAYING"]
	e.config.ref_table.ability.immutable.STATE_COMPLETE = false
end
function G.FUNCS.synthb_raise (e)
	e.config.ref_table.ability.immutable.betting = e.config.ref_table.ability.immutable.betting + e.config.ref_table.ability.immutable.raise
end

function G.FUNCS.synthb_can_hit (e)
	if SynthB.Globals.blackjack.buttons.middle_button < 21 then
		e.config.colour = G.C.RED
		e.config.button = "synthb_hit"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

function G.FUNCS.synthb_update_stand (e)
	local score = SynthB.blackjack_score(SynthB.Globals.blackjack.hand)
	if score <= 11 and #SynthB.Globals.blackjack.hand.cards == 2 then
		e.config.colour = G.C.BLUE
		if e.config.ref_table.ability.immutable.betting * 2 > e.config.ref_table.ability.extra.xmult then
			e.config.button = "synthb_all_in"
			SynthB.Globals.blackjack.buttons.right_button = "All In"
		else
			e.config.button = "synthb_double_down"
			SynthB.Globals.blackjack.buttons.right_button = "Double Down"
		end
	else
		e.config.colour = G.C.RED
		e.config.button = "synthb_stand"
		SynthB.Globals.blackjack.buttons.right_button = "Stand"
	end
end

function G.FUNCS.synthb_hit (e)
	local _card = SynthB.Globals.blackjack.deck.cards[#SynthB.Globals.blackjack.deck.cards]
	SynthB.Globals.blackjack.deck:remove_card(_card)
	SynthB.Globals.blackjack.hand:emplace(_card)
	SynthB.Globals.blackjack.buttons.middle_button = SynthB.blackjack_score(SynthB.Globals.blackjack.hand)
end

function G.FUNCS.synthb_all_in (e)
	e.config.ref_table.ability.immutable.betting = e.config.ref_table.ability.extra.xmult
	G.FUNCS.synthb_hit(e)
	G.FUNCS.synthb_stand(e)
end

function G.FUNCS.synthb_double_down (e)
	e.config.ref_table.ability.immutable.betting = 2 * e.config.ref_table.ability.immutable.betting
	G.FUNCS.synthb_hit(e)
	G.FUNCS.synthb_stand(e)
end

function G.FUNCS.synthb_stand (e)
	e.config.ref_table.ability.immutable.STATE = e.config.ref_table.ability.immutable.STATES.OPPONENT
	e.config.ref_table.ability.immutable.STATE_COMPLETE = false
end

function G.FUNCS.synthb_continue (e)
	e.config.ref_table.ability.immutable.STATE = e.config.ref_table.ability.immutable.STATES.CONTINUE
	e.config.ref_table.ability.immutable.STATE_COMPLETE = false
end

-- Wish
function G.UIDEF.synthb_wish_full_menu ()
	G.GAME.synthb_wish_options = {}
	G.GAME.synthb_choosing_wish = true
	for _, joker in ipairs(G.P_CENTER_POOLS.Joker) do
		if joker.rarity <= 2 then
			G.GAME.synthb_wish_options[#G.GAME.synthb_wish_options+1] = joker
		end
	end
	return SMODS.card_collection_UIBox(G.GAME.synthb_wish_options, {5,5,5}, {
		no_materialize = true,
		h_mod = 0.95,
	})
end

-- Spolier Warning
function G.UIDEF.synthb_spoiler_warning ()
	return create_UIBox_generic_options{
		back_colour = darken(SynthB.custom_colors.LIGHT_GREEN, 0.2),
		back_label = localize("b_synthb_proceed"),
		contents = {
			{n = G.UIT.R, config = {align = "cm"}, nodes = {
				{n = G.UIT.R, config = {align = "cm"}, nodes = {
					{n = G.UIT.R, config = {align = "cm"}, nodes = {
						{n = G.UIT.T, config = {text = localize("k_synthb_spoiler_warning_ex"), scale = 1, colour = G.C.UI.TEXT_LIGHT}}
					}},
					{n = G.UIT.R, config = {align = "cm"}, nodes = {
						{n = G.UIT.B, config = {w = 8, h = 0.2}}
					}},
					{n = G.UIT.R, config = {align = "cm"}, nodes = {
						{n = G.UIT.B, config = {w = 8, h = 0.1, r = 0.1, colour = G.C.UI.TEXT_DARK}}
					}}
				}},
				{n = G.UIT.R, config = {align = "cm", padding = 0.3}, nodes = {
					{n = G.UIT.C, config = {align = "cm", colour = G.C.UI.BACKGROUND_WHITE, r = 0.2, padding = 0.2}, nodes = {
						{n = G.UIT.R, config = {align = "cm"}, nodes = {
							{n = G.UIT.R, nodes = {
								{n = G.UIT.T, config = {text = "SynthB contains spoilers", scale = 0.5, colour = G.C.UI.TEXT_DARK}}
							}},
							{n = G.UIT.R, nodes = {
								{n = G.UIT.T, config = {text = "for the following games:", scale = 0.5, colour = G.C.UI.TEXT_DARK}}
							}}
						}},
						{n = G.UIT.R, config = {align = "cm", colour = G.C.UI.TRANSPARENT_DARK, r = 0.2, padding = 0.1}, nodes = {
							{n = G.UIT.R, nodes = {
								{n = G.UIT.T, config = {text = localize("k_synthb_deltarune"), scale = 0.5, colour = G.C.UI.TEXT_DARK}}
							}}
						}},
						{n = G.UIT.R, config = {align = "cm"}, nodes = {
							{n = G.UIT.R, config = {align = "cm"}, nodes = {
								{n = G.UIT.T, config = {text = "You may disable related content", scale = 0.5, colour = G.C.UI.TEXT_DARK}}
							}},
							{n = G.UIT.R, config = {align = "cm"}, nodes = {
								{n = G.UIT.T, config = {text = "on the right now,", scale = 0.5, colour = G.C.UI.TEXT_DARK}}
							}},
							{n = G.UIT.R, config = {align = "cm"}, nodes = {
								{n = G.UIT.T, config = {text = "or in the mods config page", scale = 0.5, colour = G.C.UI.TEXT_DARK}}
							}},
							{n = G.UIT.R, config = {align = "cm"}, nodes = {
								{n = G.UIT.T, config = {text = "at any time.", scale = 0.5, colour = G.C.UI.TEXT_DARK}}
							}}
						}},
					}},
					{n = G.UIT.C, config = {align = "cm", colour = G.C.UI.BACKGROUND_INACTIVE, r = 0.2, padding = 0.2}, nodes = {
						{n = G.UIT.R, config = {align = "cm"}, nodes = {
							{n = G.UIT.R, nodes = {
								create_toggle({
									label = "Disable Deltarune Spoilers",
									ref_table = SynthB.mod.config.spoilers,
									ref_value = 'deltarune'
								})
							}},
						}},
					}},
				}}
			}}
		}
	}
end