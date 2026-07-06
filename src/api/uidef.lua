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
		if joker.rarity == 1 or joker.rarity == 2 then
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

-- Credits UI
function G.UIDEF.synthb_create_credits_page(index)
	local key = SynthB.Credits.index_to_key[index]
	local data = SynthB.Credits.data[key]
	if data.custom_ui then return data:custom_ui() end
	local area = data:create_area()
	data:create_sprite(area)
	local nodes = {}
	localize{type = "other", key = "synthb_" .. key, nodes = nodes}
	for i, node in ipairs(nodes) do
		nodes[i] = {n = G.UIT.R, nodes = node}
	end
	return {n = G.UIT.ROOT, config = {padding = 0.5, r = 0.2, colour = G.C.CLEAR, align = "cm"}, nodes = {
		{n = G.UIT.C, config = {align = "cm"}, nodes = {
			{n = G.UIT.O, config = {id = "synthb_credit_card", object = area}}
		}},
		{n = G.UIT.C, config = {align = "tm", colour = G.C.WHITE, r = 0.2, padding = 0.2}, nodes = nodes}
	}}
end

-- Gacha Banner UI
function G.UIDEF.synthb_create_gacha_banner()
	local data = SynthB.banners[G.GAME.synthb_current_banner_key]
	local banner = Card(G.ROOM.T.x, G.ROOM.T.y, 2.5, 4, nil, G.P_CENTERS.c_base)
	banner.children.center:remove()
	banner.children.center = SMODS.create_sprite(0, 0, 2.5, 4, "synthb_banners", data.pos)
	banner.children.center.states.hover = banner.states.hover
	banner.children.center.states.click = banner.states.click
	banner.children.center.states.drag.can = false
	banner.children.center.states.collide.can = true
	banner.children.center:set_role({major = banner, role_type = 'Glued', draw_major = banner})
	banner.synthb_key = data.key
	banner.ambient_tilt = 0
	banner.no_shadow = true
	function banner:click ()
		if G.GAME.dollars >= 10 then
			ease_dollars(-10)
			G.GAME.PACK_INTERRUPT = G.STATE
			G.STATE = G.STATES.SYNTHB_GACHA_BANNER
			G.STATE_COMPLETE = false
		else
			play_sound("timpani")
		end
	end
	function banner:hover()
		local desc_nodes = {}
		localize{type = "other", key = self.synthb_key, nodes = desc_nodes}
		for i, node in ipairs(desc_nodes) do
			desc_nodes[i] = {n = G.UIT.R, config = {align = "cm"}, nodes = node}
		end
		local t = {n=G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR}, nodes={
			{n=G.UIT.C, config={align = "cm", func = 'show_infotip',object = Moveable()}, nodes={
				{n=G.UIT.R, config={padding = 0.05, r = 0.12, colour = lighten(G.C.JOKER_GREY, 0.5), emboss = 0.07}, nodes={
					{n=G.UIT.R, config={align = "cm", padding = 0.07, r = 0.1, colour = adjust_alpha(darken(G.C.JOKER_GREY, 0.3), 0.8)}, nodes={
						{n = G.UIT.R, config ={align = "cm"}, nodes = {
							(localize{type = "name", set = "Other", key = self.synthb_key})[1]
						}},
						{n = G.UIT.R, config = {colour = G.C.WHITE, padding = 0.2, r = 0.2, align = "cm"}, nodes = {
							{n = G.UIT.R, config = {align = "cm"}, nodes = desc_nodes}
						}}
					}}
				}}
			}},
		}}
		self.popup = UIBox{
			definition = t,
			config = {
				align = "tm",
				offset = {x = 0, y = -0.5},
				major = self,
				instance_type = "POPUP"
			}
		}
	end
	function banner:stop_hover()
		if self.popup then
			self.popup:remove()
			self.popup = nil
		end
	end
	local cardarea = CardArea(G.ROOM.T.x, G.ROOM.T.y, 2.5, 4, {type = 'title_2', card_limit = 1, highlight_limit = 0})
	function cardarea:draw()
		if not self.states.visible then return end 
    if G.VIEWING_DECK and (self==G.deck or self==G.hand or self==G.play) then return end

    self:draw_boundingrect()
    add_to_drawhash(self)

    self.ARGS.draw_layers = self.ARGS.draw_layers or self.config.draw_layers or {'shadow', 'card'}
		local mem_settings = G.SETTINGS.reduced_motion
		G.SETTINGS.reduced_motion = true
		self.cards[1].VT.r = 0
		self.cards[1].VT.scale = 1
		self.cards[1].T.r = 0
		self.cards[1].T.scale = 1
		self.cards[1].velocity.r = 0
		if math.abs(self.cards[1].velocity.x) > math.abs(self.cards[1].VT.x - self.cards[1].T.x) then self.cards[1].velocity.x = self.cards[1].T.x - self.cards[1].VT.x end
		if math.abs(self.cards[1].velocity.y) > math.abs(self.cards[1].VT.y - self.cards[1].T.y) then self.cards[1].velocity.y = self.cards[1].T.y - self.cards[1].VT.y end
    for k, v in ipairs(self.ARGS.draw_layers) do
        for i = 1, #self.cards do 
						if self.cards[i] ~= G.CONTROLLER.focused.target then
								if not self.cards[i].highlighted then
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
		G.SETTINGS.reduced_motion = mem_settings
	end
	cardarea:emplace(banner)
	banner.states.drag.can = false
  return {n=G.UIT.ROOT, config = {align = 'cl', colour = G.C.CLEAR}, nodes={
		{n=G.UIT.R, config={align = "cm", r = 0.3, minw = 2.6, maxw=2.6, minh = 4, maxh = 4, colour = G.C.DYN_UI.MAIN, emboss = 0.1}, nodes={
			{n = G.UIT.C, nodes = {
				{n = G.UIT.B, config = {w = 0.25, h = 4}}
			}},
			{n = G.UIT.C, config = {padding = 0.05}, nodes = {
				{n=G.UIT.R, config={align = "cm", minh = 1,r = 0.2, padding = 0.1, minw = 1, colour = G.C.DYN_UI.DARK}, nodes={
					{n=G.UIT.C, config={align = "cm",padding = 0.1, colour = G.C.L_BLACK, minh = 4, maxh = 4, minw = 2.5, maxw = 2.5}, nodes={
						{n = G.UIT.O, config = {id = "synthb_shop_banner", object = cardarea}}
					}}
				}}
			}}
		}}
	}}
end

function G.UIDEF.synthb_create_UIBox_gacha_banner (key)
	local _size = 1
	G.pack_cards = CardArea(
		G.ROOM.T.x + 9 + G.hand.T.x, G.hand.T.y,
		math.max(1,math.min(_size,5))*G.CARD_W*1.1,
		1.05*G.CARD_W,
		{card_limit = _size, type = 'consumeable', highlight_limit = 1, negative_info = true})

	local t = {n=G.UIT.ROOT, config = {align = 'tm', r = 0.15, colour = G.C.CLEAR, padding = 0.15}, nodes={
			{n=G.UIT.R, config={align = "cl", colour = G.C.CLEAR,r=0.15, padding = 0.1, minh = 2, shadow = true}, nodes={
					{n=G.UIT.R, config={align = "cm"}, nodes={
					{n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
							{n=G.UIT.C, config={align = "cm", r=0.2, colour = G.C.CLEAR, shadow = true}, nodes={
									{n=G.UIT.O, config={object = G.pack_cards}},}}}}}},
			{n=G.UIT.R, config={align = "cm"}, nodes={}},
			{n=G.UIT.R, config={align = "tm"}, nodes={
					Cartomancer and {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes= (not Cartomancer.show_peek_shop()) and {} or {
						{n=G.UIT.R,config={minh =0.2}, nodes={}},
						{n=G.UIT.R,config={align = "tm",padding = 0.2, minh = 1.2, minw = 1.8, r=0.15,colour = G.C.GREY, button = 'carto_peek_shop', hover = true,
						hover_offset = {x = 3.5, y = 1},
						hover_ease_to = {x = 3.5, y = -3.8},
						hover_align = 'tm',
						cart_hover_func = Cartomancer.get_hover_tab,
						shadow = true, }, nodes = {
							{n=G.UIT.C, config={align = "tm"}, nodes= {
								{n=G.UIT.R, config={align = "tm"}, nodes = {
									{n=G.UIT.T, config={text = localize('carto_peek_shop_1'), scale = 0.5, colour = G.C.WHITE, shadow = true, }},
								}},
								{n=G.UIT.R, config={align = "tm"}, nodes = {
									{n=G.UIT.T, config={text = localize('carto_peek_shop_2'), scale = 0.5, colour = G.C.WHITE, shadow = true, }}
								}},
							}}
						}}
					}} or nil,
					{n=G.UIT.C,config={align = "tm", padding = 0.05}, nodes={
							UIBox_dyn_container({
									{n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 4}, nodes={
											{n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
													{n=G.UIT.O, config={object = DynaText({string = localize('k_gacha_banner_synthb_gacha_'..key), colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.7, maxw = 4, pop_in = 0.5})}}}},}}
							}),}},
					{n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes={
							{n=G.UIT.R,config={minh =0.2}, nodes={}},
							{n=G.UIT.R,config={align = "tm",padding = 0.2, minh = 1.2, minw = 1.8, r=0.15,colour = G.C.GREY, one_press = true, button = 'skip_booster', hover = true,shadow = true, func = 'can_skip_booster'}, nodes = {
									{n=G.UIT.T, config={text = localize('b_skip'), scale = 0.5, colour = G.C.WHITE, shadow = true, focus_args = {button = 'y', orientation = 'bm'}, func = 'set_button_pip'}}}}}}}}}}}}
	return t
end