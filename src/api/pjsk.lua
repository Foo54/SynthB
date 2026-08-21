---@diagnostic disable: redefined-local
if not SynthB.dp_watching then
	SMODS.ScreenShader{
		key = "pjsk_blur",
		path = "pjsk/blur.fs",
		should_apply = function(self)
			return SynthB.PJSK.active
		end,
		draw = function(self, shader, canvas)
			local old_canvas = love.graphics.getCanvas()
			local w, h = love.graphics.getDimensions()
			local scale = G.TILESCALE*G.TILESIZE*G.CANV_SCALE / 15
			local cw = math.ceil(w / scale)
			local ch = math.ceil(h / scale)
			if not SynthB.PJSK.canvas then
				SynthB.PJSK.canvas = love.graphics.newCanvas(w, h)
			end
			love.graphics.push("all")
			love.graphics.setCanvas(SynthB.PJSK.canvas)
			if not SynthB.PJSK.STATE ~= SynthB.PJSK.STATES.CONFIG then
				love.graphics.setShader(shader)
			end
			love.graphics.draw(canvas)
			love.graphics.pop()
			love.graphics.setShader()
			love.graphics.push("all")
			love.graphics.setColor(1, 1, 1, 1)
			love.graphics.draw(SynthB.PJSK.canvas)--, 0, 0, 0, scale)
			love.graphics.pop()
			love.graphics.setCanvas({ old_canvas, depthstencil = SMODS.stencil_canvas })
			SynthB.PJSK:draw()
		end
	}

	SMODS.ScreenShader{
		key = "pjsk_second_blur",
		path = "pjsk/blur.fs",
		should_apply = function(self)
			return SynthB.PJSK.active and SynthB.PJSK.STATE == SynthB.PJSK.STATES.CONFIG
		end,
		draw = function(self, shader, canvas)
			local old_canvas = love.graphics.getCanvas()
			local w, h = love.graphics.getDimensions()
			local scale = G.TILESCALE*G.TILESIZE*G.CANV_SCALE / 15
			local cw = math.ceil(w / scale)
			local ch = math.ceil(h / scale)
			if not SynthB.PJSK.second_canvas then
				SynthB.PJSK.second_canvas = love.graphics.newCanvas(w, h)
			end
			love.graphics.push("all")
			love.graphics.setCanvas(SynthB.PJSK.second_canvas)
			love.graphics.setShader(shader)
			love.graphics.draw(canvas)
			love.graphics.pop()
			love.graphics.setShader()
			love.graphics.push("all")
			love.graphics.setColor(1, 1, 1, 1)
			love.graphics.draw(SynthB.PJSK.second_canvas)--, 0, 0, 0, scale)
			love.graphics.pop()
			love.graphics.setCanvas({ old_canvas, depthstencil = SMODS.stencil_canvas })
			SynthB.PJSK:draw_config()
		end
	}

	SMODS.Shader{
		key = "pjsk_phone_inside",
		path = "pjsk/phone_inside.fs"
	}

	SMODS.Atlas{
		key = "pjsk_music_bars",
		path = "pjsk/music_bars.png",
		px = 38,
		py = 38
	}

	SMODS.Atlas{
		key = "pjsk_button_corners",
		path = "pjsk/button_corners.png",
		px = 38,
		py = 38
	}

	SMODS.Atlas{
		key = "pjsk_button_icons",
		path = "pjsk/button_icons.png",
		px = 38,
		py = 38
	}

	SMODS.Atlas{
		key = "pjsk_back",
		path = "pjsk/back.png",
		px = 72,
		py = 72
	}

	SMODS.Atlas{
		key = "pjsk_dither",
		path = "pjsk/dither.png",
		px = 46,
		py = 83
	}

	SMODS.Atlas{
		key = "pjsk_placeholder_mini_icon",
		path = "pjsk/placeholder_mini_icon.png",
		px = 20,
		py = 80
	}

	SMODS.Atlas{
		key = "pjsk_type_icons",
		path = "pjsk/type_icons.png",
		px = 43,
		py = 43
	}

	SMODS.Shader{
		key = "pjsk_mask_ui",
		path = "pjsk/mask_ui.fs",
		send_vars = function (uielement, card)
			return {
				mask = SMODS.Atlases[uielement.config.pjsk_mask].image
			}
		end
	}

	local uibox_init_ref = UIBox.init
	function UIBox:init(args)
		if SynthB.PJSK.active then
			if SynthB.PJSK.second_layer then
				args.config.instance_type = args.config.instance_type or "PJSK_CONFIG"
			end
			args.config.instance_type = args.config.instance_type or "PJSK"
			if args.config.instance_type == "POPUP" or SynthB.PJSK.force_popup then args.config.instance_type = "PJSK_POPUP" end
		end
		return uibox_init_ref(self, args)
	end

	local g_funcs_exit_overlay_menu_ref = G.FUNCS.exit_overlay_menu
	---@diagnostic disable-next-line: duplicate-set-field
	function G.FUNCS.exit_overlay_menu(...)
		if SynthB.PJSK.active then
			SynthB.PJSK:remove()
		end
		g_funcs_exit_overlay_menu_ref(...)
	end

	local love_resize_ref = love.resize
	function love.resize(w, h)
			love_resize_ref(w, h)
			SynthB.PJSK.canvas = nil
			SynthB.PJSK.second_canvas = nil
	end

	local ds = Sprite.draw_shader
	function Sprite:draw_shader(_shader, _shadow_height, _send, _no_tilt, other_obj, ms, mr, mx, my, custom_shader, tilt_shadow)
		if self.role.major and self.role.major.synthb_quip then _no_tilt = true end
		ds(self, _shader, _shadow_height, _send, _no_tilt, other_obj, ms, mr, mx, my, custom_shader, tilt_shadow)
	end

	local loc_colour_ref = loc_colour
	function loc_colour(_c, _default, ...)
		_default = _default or SynthB.PJSK.text_colour
		return loc_colour_ref(_c, _default, ...)
	end

	local g_funcs_show_infotip_ref = G.FUNCS.show_infotip
	function G.FUNCS.show_infotip(e)
		if e.config.synthb_force_ui then
			SynthB.PJSK.force_popup = true
		end
		g_funcs_show_infotip_ref(e)
		if e.config.synthb_force_ui then
			SynthB.PJSK.force_popup = nil
		end
	end
else
	SynthB.PJSK:remove()
end

SynthB.dp_watching = true

SynthB.PJSK = {
	STATE = nil,
	STATES = {
		MENU = 0,
		CONTENT = 1,
		CREDITS = 2,
		CONFIG = 3,
		SONGS = 4,
		SINGLE_CREDIT = 5,
	},
	last_credit_tab = "coders",
	last_content_tab = "jokers",
	C = {
		PHONE = {
			BORDER = HEX("3b3670"),
			INSIDE_TOP = HEX("7b7c9b"),
			INSIDE_BOTTOM = HEX("5c5d7c"),
			TEXT_OUTLINE = HEX("8b8aa9"),
			MUSIC = HEX("feffff"),
			BUTTONS = {
				CONTENT = HEX("80cccc"),
				CONTENT_OUTLINE = HEX("84d0ce"),
				CREDITS = HEX("d9a2bf"),
				CREDITS_OUTLINE = HEX("e1a9c2"),
				CONFIG = HEX("ceced8"),
				SONGS = HEX("ceced8"),
				CONTENT_TEXT = HEX("dffef8"),
				CREDITS_TEXT = HEX("ffe5f1"),
				BOTTOM_TEXT = HEX("444466"),
			},
			QUIP = HEX("55506e")
		},
		CONFIG = {
			BACKGROUND_DARK = HEX("bbbcd0"),
			BACKGROUND = HEX("ebecf1"),
			TEXT_DARK = HEX("434365"),
			TEXT_LIGHT = HEX("fffffd"),
			BORDER = HEX("a6a7bb"),
			BACK_BORDER = HEX("c8c7cc"),
			BACK_BUTTON = HEX("ffffff"),
			TOGGLE = HEX("a6a7bb"),
			TOGGLE_SPACING = HEX("bbbcd0"),
		},
		CREDITS = {
			SIDEBAR = {
				BACKGROUND = HEX("676887dd"),
				BORDER = HEX("8891aedd"),
				CODERS = HEX("77eddd"),
				ARTISTS = HEX("4455dd"),
				ARTISTS2 = HEX("88dd44"),
				MUSIC = HEX("ee1166"),
				DOTS = HEX("3e4160"),
			},
			SECTION = {
				OUTLINE = HEX("9296af"),
				WHITE = HEX("c9d5e1dd"),
				TEXT_LIGHT = HEX("ffffff"),
				DEFAULT_COLOUR = HEX("77eddd"),
			},
		},
		CONTENT = {
			GREY = {0.8, 0.8, 0.8, 0.5}
		},
		SONGS = {
			BORDER = HEX("6b77a1"),
			TRANS_BLACK = {0, 0, 0, 0.2}
		},
	},
	UI = {},
	active = false,
	canvas = nil,
	second_canvas = nil,
	second_layer = nil,
	safe_click = true,
	safe_to_transition = true,
}

function SynthB.PJSK:init()
	self.UI = {}
	self.active = true
	self.STATE = self.STATES.MENU
	self:gogogadget_ui_blocker()
	self:main_menu()
	self:card_quip()
	self:back_button()
end

function G.FUNCS.synthb_pjsk_phone_align (e)
	if SynthB.PJSK.UI.main_phone then
		SynthB.PJSK.UI.main_phone.T.r = 0.05
	end
end

function SynthB.PJSK:main_menu()
	local extra_h = 0.7
	local full_h = G.ROOM_ATTACH.T.h + extra_h * 2 + 0.5
	local full_w = full_h * 0.7
	local inner_h = full_h - 0.5
	local inner_w = full_w - 0.5
	local top_thingy_h = 0.4
	local top_text_h = 1.7
	local top_text_padding = 0.5
	local rest_of_h = inner_h - top_thingy_h - top_text_h - top_text_padding
	local button_area_w = 7.5
	local button_padding_h = 0.2
	local button_padding_w = 0.2
	local button_w = (button_area_w - button_padding_w) / 2
	local top_button_h = button_w / 1.6
	local bottom_button_h = top_button_h / 1.8
	local button_area_h = top_button_h + button_padding_h + bottom_button_h
	local logo_w = button_area_w
	local logo_h = logo_w / 10 * 4
	local offset = G.ROOM_ATTACH.T.h + extra_h + 2
	local button_corner_s = 0.75
	local button_icon_s = 1

	local content_button_target = Moveable()
	local credits_button_target = Moveable()

	self.UI.main_phone = UIBox{
		definition = {n = G.UIT.ROOT, config = {colour = G.C.CLEAR, func = "synthb_pjsk_phone_align"}, nodes = {
			{n = G.UIT.C, config = {colour = self.C.PHONE.BORDER, r = true, res = 1, minh = full_h, minw = full_w, align = "cm"}, nodes = {
				{n = G.UIT.R, config = {colour = self.C.PHONE.INSIDE_TOP, r = true, res = 1, id = "test", minh = inner_h, minw = inner_w, align = "ct"}, nodes = {
					{n = G.UIT.R, config = {align = "cm"}, nodes = {
						{n = G.UIT.B, config = {w = inner_w / 3, h = top_thingy_h, colour = self.C.PHONE.BORDER, r = true, synthb_no_top_corners = true}},
					}},
					{n = G.UIT.R, config = {align = "cr", minh = top_text_h, minw = inner_w}, nodes = {
						{n = G.UIT.C, config = {minw = 4.5, minh = top_text_h, align = "bl"}, nodes = {
							{n = G.UIT.O, config = {object = SMODS.create_sprite(0, 0, 0.4, 0.4, "synthb_pjsk_music_bars")}},
							{n = G.UIT.B, config = {w = 0.2, h = 0.05}},
							{n = G.UIT.T, config = {text = localize("ph_synthb_card_game"), colour = self.C.PHONE.MUSIC, scale = 0.5}}
						}},
						{n = G.UIT.T, config = {text = localize("ph_synthb_mod_page"), colour = self.C.PHONE.INSIDE_TOP, text_outline = self.C.PHONE.TEXT_OUTLINE, scale = 1.5}},
						{n = G.UIT.B, config = {w = 0.8, h = 1.5}}
					}},
					{n = G.UIT.R, config = {align = "cm", minh = top_text_padding, minw = inner_w}},
					{n = G.UIT.R, config = {align = "tm", minh = rest_of_h, minw = button_area_w}, nodes = {
						{n = G.UIT.R, config = {align = "tm", minh = button_area_h, minw = button_area_w}, nodes = {
							{n = G.UIT.C, config = {minw = button_w, minh = button_area_h}, nodes = {
								{n = G.UIT.R, config = {minw = button_w, minh = top_button_h, align = "cm"}, nodes = {
									{n = G.UIT.O, config = {object = content_button_target}}
								}},
								{n = G.UIT.R, config = {minh = button_padding_h}},
								{n = G.UIT.R, config = {minw = button_w, minh = bottom_button_h, r = true, align = "cm", colour = self.C.PHONE.BUTTONS.CONFIG}, nodes = {
									{n = G.UIT.R, config = {minw = button_w, minh = bottom_button_h, align = "cm", button_dist = 0, button = "synthb_pjsk_transition", ref_table = "config"}, nodes = {
										{n = G.UIT.O, config = {object = SMODS.create_sprite(0, 0, button_icon_s, button_icon_s, "synthb_pjsk_button_icons", {x = 0, y = 1})}},
										{n = G.UIT.C, config = {align = "cm"}, nodes = {
											{n = G.UIT.R, config = {align = "cm"}, nodes = {
												{n = G.UIT.T, config = {text = localize("ph_synthb_config_1"), scale = 0.4, colour = self.C.PHONE.BUTTONS.BOTTOM_TEXT}}
											}},
											{n = G.UIT.R, config = {align = "cm"}, nodes = {
												{n = G.UIT.T, config = {text = localize("ph_synthb_config_2"), scale = 0.4, colour = self.C.PHONE.BUTTONS.BOTTOM_TEXT}}
											}}
										}}
									}}
								}},
							}},
							{n = G.UIT.C, config = {minw = button_padding_w}},
							{n = G.UIT.C, config = {minw = button_w, minh = button_area_h}, nodes = {
								{n = G.UIT.R, config = {minw = button_w, minh = top_button_h, align = "cm"}, nodes = {
									{n = G.UIT.O, config = {object = credits_button_target}}
								}},
								{n = G.UIT.R, config = {minh = button_padding_h}},
								{n = G.UIT.R, config = {minw = button_w, minh = bottom_button_h, r = true, align = "cm", colour = self.C.PHONE.BUTTONS.SONGS}, nodes = {
									{n = G.UIT.R, config = {minw = button_w, minh = bottom_button_h, align = "cm", button_dist = 0, button = "synthb_pjsk_transition", ref_table = "songs"}, nodes = {
										{n = G.UIT.O, config = {object = SMODS.create_sprite(0, 0, button_icon_s, button_icon_s, "synthb_pjsk_button_icons", {x = 1, y = 1})}},
										{n = G.UIT.C, config = {align = "cm"}, nodes = {
											{n = G.UIT.R, config = {align = "cm"}, nodes = {
												{n = G.UIT.T, config = {text = localize("ph_synthb_songs_1"), scale = 0.4, colour = self.C.PHONE.BUTTONS.BOTTOM_TEXT}}
											}},
											{n = G.UIT.R, config = {align = "cm"}, nodes = {
												{n = G.UIT.T, config = {text = localize("ph_synthb_songs_2"), scale = 0.4, colour = self.C.PHONE.BUTTONS.BOTTOM_TEXT}}
											}}
										}}
									}}
								}},
							}}
						}},
						{n = G.UIT.R, config = {minh = 2}},
						{n = G.UIT.R, config = {align = "cm"}, nodes = {
							{n = G.UIT.O, config = {object = SMODS.create_sprite(0, 0, logo_w, logo_h, "synthb_logo")}}
						}}
					}}
				}}
			}},
			{n = G.UIT.C, nodes = {
				{n = G.UIT.R, nodes = {
					{n = G.UIT.B, config = {w = 0.2, h = G.ROOM_ATTACH.T.h / 2 - 3}},
				}},
				{n = G.UIT.R, nodes = {
					{n = G.UIT.B, config = {w = 0.2, h = 2, colour = self.C.PHONE.BORDER}}
				}}
			}}
		}},
		config = {
			align = "cri",
			r_bond = "Weak",
			major = G.ROOM_ATTACH,
			offset = {
				x = 0,
				y = offset
			}
		}
	}

	self.UI.content_button = UIBox{
		definition = {n = G.UIT.ROOT, config = {minw = button_w, minh = top_button_h, r = true, colour = self.C.PHONE.BUTTONS.CONTENT}, nodes = {
			{n = G.UIT.R, nodes = {
				{n = G.UIT.O, config = {object = SMODS.create_sprite(0, 0, button_corner_s, button_corner_s, "synthb_pjsk_button_corners")}}
			}},
			{n = G.UIT.R, config = {minh = top_button_h - button_corner_s - 0.25, minw = button_w, align = "cm"}, nodes = {
				{n = G.UIT.T, config = {text = localize("ph_synthb_additions"), scale = 1, text_outline = self.C.PHONE.BUTTONS.CONTENT_OUTLINE, colour = self.C.PHONE.BUTTONS.CONTENT}}
			}}
		}},
		config = {
			major = content_button_target,
			bond = 'Glued',
			align = "cmi"
		}
	}

	self.UI.content_button_text = UIBox{
		definition = {n = G.UIT.ROOT, config = {minw = button_w, minh = top_button_h, colour = G.C.CLEAR, align = "cm", button_dist = 0, button = "synthb_pjsk_transition", ref_table = "content"}, nodes = {
			{n = G.UIT.R, config = {align = "cm"}, nodes = {
				{n = G.UIT.O, config = {object = SMODS.create_sprite(0, 0, button_icon_s, button_icon_s, "synthb_pjsk_button_icons")}}
			}},
			{n = G.UIT.R, config = {align = "cm"}, nodes = {
				{n = G.UIT.T, config = {text = localize("ph_synthb_additions"), scale = 0.75, colour = self.C.PHONE.BUTTONS.CONTENT_TEXT}}
			}}
		}},
		config = {
			major = self.UI.content_button,
			bond = 'Glued',
			align = "cmi"
		}
	}

	self.UI.credits_button = UIBox{
		definition = {n = G.UIT.ROOT, config = {minw = button_w, minh = top_button_h, r = true, colour = self.C.PHONE.BUTTONS.CREDITS}, nodes = {
			{n = G.UIT.R, nodes = {
				{n = G.UIT.O, config = {object = SMODS.create_sprite(0, 0, button_corner_s, button_corner_s, "synthb_pjsk_button_corners", {x = 1, y = 0})}}
			}},
			{n = G.UIT.R, config = {minh = top_button_h - button_corner_s - 0.25, minw = button_w, align = "cm"}, nodes = {
				{n = G.UIT.T, config = {text = localize("ph_synthb_credits"), scale = 1.1, text_outline = self.C.PHONE.BUTTONS.CREDITS_OUTLINE, colour = self.C.PHONE.BUTTONS.CREDITS}}
			}}
		}},
		config = {
			major = credits_button_target,
			bond = 'Glued',
			align = "cmi"
		}
	}

	self.UI.credits_button_text = UIBox{
		definition = {n = G.UIT.ROOT, config = {minw = button_w, minh = top_button_h, colour = G.C.CLEAR, align = "cm", button_dist = 0, button = "synthb_pjsk_transition", ref_table = "credits"}, nodes = {
			{n = G.UIT.R, config = {align = "cm"}, nodes = {
				{n = G.UIT.O, config = {object = SMODS.create_sprite(0, 0, button_icon_s, button_icon_s, "synthb_pjsk_button_icons", {x = 1, y = 0})}}
			}},
			{n = G.UIT.R, config = {align = "cm"}, nodes = {
				{n = G.UIT.T, config = {text = localize("ph_synthb_credits"), scale = 0.75, colour = self.C.PHONE.BUTTONS.CREDITS_TEXT}}
			}}
		}},
		config = {
			major = self.UI.credits_button,
			bond = 'Glued',
			align = "cmi"
		}
	}

	ease_value(self.UI.main_phone.alignment.offset, "y", -offset, nil, nil, true, 0.1)
end

function SynthB.PJSK:transition(type, extra)
	-- exit
	if self.safe_to_transition then
		self.safe_to_transition = false
		local _delay = false
		local function t_delay(t)
			delay(t)
			G.E_MANAGER:add_event(Event{
				func = function()
					_delay = false
					return true
				end
			})
		end
		local remove_nodes = {}
		if self.STATE == self.STATES.MENU then
			if type ~= "config" then
				remove_nodes = {
					"credits_button_text",
					"card_quip_box",
					"content_button",
					"card_quip_card",
					"main_phone",
					"credits_button",
					"content_button_text"
				}
				local extra_h = 0.7
				local offset = G.ROOM_ATTACH.T.h + extra_h + 2
				local time = 0.1
				if self.UI.main_phone then ease_value(self.UI.main_phone.alignment.offset, "y", offset, nil, nil, true, time) end
				if self.UI.card_quip_card then ease_value(self.UI.card_quip_card.alignment.offset, "y", offset, nil, nil, true, time) end
				t_delay(time)
			end
		elseif self.STATE == self.STATES.CONTENT then
			remove_nodes = {
				"content_sidebar",
				"content_box",
			}
			local time = 0.1
			if self.UI.content_sidebar then ease_value(self.UI.content_sidebar.alignment.offset, "x", -15, nil, nil, true, time) end
			if self.UI.content_box then ease_value(self.UI.content_box.alignment.offset, "y", 15, nil, nil, true, time) end
			t_delay(time)
		elseif self.STATE == self.STATES.CREDITS then
				remove_nodes = {
					"credits_sidebar",
					"credits_text",
				}
				self:remove_credits_section()
				local time = 0.1
				if self.UI.credits_sidebar then ease_value(self.UI.credits_sidebar.alignment.offset, "x", -15, nil, nil, true, time) end
				if self.UI.credits_text then ease_value(self.UI.credits_text.alignment.offset, "y", 15, nil, nil, true, time) end
				t_delay(time)
		elseif self.STATE == self.STATES.CONFIG then
			remove_nodes = {
				"config",
				"ui_blocker_2",
				"current_config",
				"config_scrollbox"
			}
		elseif self.STATE == self.STATES.SONGS then
			self:exit_songs()
			remove_nodes = {
				"song_list",
				"song_sidebar"
			}
			local time = 0.1
			if self.UI.song_list then ease_value(self.UI.song_list.alignment.offset, "y", 15, nil, nil, true, time) end
			if self.UI.song_sidebar then ease_value(self.UI.song_sidebar.alignment.offset, "x", -15, nil, nil, true, time) end
			t_delay(time)
		elseif self.STATE == self.STATES.SINGLE_CREDIT then
			remove_nodes = {
				"credit_card",
				"credit_card_box",
				"credit_book",
			}
			local extra_h = 0.7
			local offset = G.ROOM_ATTACH.T.h + extra_h + 2
			local time = 0.1
			if self.UI.credit_card then ease_value(self.UI.credit_card.alignment.offset, "y", offset, nil, nil, true, time) end
			if self.UI.credit_book then ease_value(self.UI.credit_book.alignment.offset, "x", 15, nil, nil, true, 0.1) end
			t_delay(time)
		else
			SynthB.debug("what am I doing how did this happen")
		end

		-- entrance
		local entrance_func = function() end
		if type == "back" then
			if self.STATE == self.STATES.MENU then
				function entrance_func()
					G.FUNCS.exit_overlay_menu()
					G.FUNCS.mods_button()
				end
			elseif self.STATE == self.STATES.SINGLE_CREDIT then
				self.STATE = self.STATES.CREDITS
				self:credits_sidebar()
				self:credits_text()
			else
				local pstate = self.STATE
				self.STATE = self.STATES.MENU
				if pstate ~= self.STATES.CONFIG then
					self:main_menu()
					self:card_quip()
				end
			end
		elseif type == "content" then
			self.STATE = self.STATES.CONTENT
			self:content_sidebar()
		elseif type == "credits" then
			self.STATE = self.STATES.CREDITS
			self:credits_sidebar()
			self:credits_text()
		elseif type == "config" then
			self.STATE = self.STATES.CONFIG
			self:config()
		elseif type == "songs" then
			self.STATE = self.STATES.SONGS
			self.mem_sfx = G.ARGS.push.sound_settings.game_sounds_volume
			self:song_list()
			self:song_sidebar()
		elseif type == "single_credit" then
			self.STATE = self.STATES.SINGLE_CREDIT
			self:single_credit_left(extra)
			self:single_credit_book(extra)
		end
		G.E_MANAGER:add_event(Event{
			func = function()
				if _delay then return false end
				for _, node in ipairs(remove_nodes) do
					if self.UI[node] then
						self.UI[node]:remove()
						self.UI[node] = nil
					end
				end
				self.safe_to_transition = true
				entrance_func()
				return true
			end
		})
	end
end

function G.FUNCS.synthb_pjsk_transition(e)
	SynthB.debug(e.config.ref_table)
	SynthB.PJSK:transition(e.config.ref_table)
end

function SynthB.PJSK:card_quip(force_card)
	local w = 6
	local h = w / G.CARD_W * G.CARD_H
	local card = Card(0, 0, w, h, nil, "c_base")
	if card.children.front then
		card.children.front:remove()
		card.children.front = nil
	end

	local target = force_card and G.P_CENTERS[force_card] or pseudorandom_element(G.P_CENTERS, "synthb_modmenu_quip", {
		in_pool = function (v, args)
			if not v.discovered then return false end
			if v.mod ~= SynthB.mod then return false end
			if localize(v.synthb_quip_key or v.original_key, "synthb_song_quips") == "ERROR" then return false end
			return true
		end
	}) or G.P_CENTERS.j_synthb_credits_foo54

	card.children.center:remove()
	card.children.center = SMODS.create_sprite(0, 0, w, h, target.atlas, target.pos)
	card.states.collide.can = false
	function card:update()
		card.states.collide.can = false
		card.T.r = 0
	end
	card.synthb_quip = true
	card.children.center.states.collide.can = false
	card.children.center:set_role({major = card, role_type = 'Glued', draw_major = card})

	local cardarea = CardArea(0, 0, w, h, {type = 'title_2', card_limit = 1, highlight_limit = 0})
	cardarea:emplace(card)

	local extra_h = 0.7
	local offset = G.ROOM_ATTACH.T.h + extra_h + 2
	self.UI.card_quip_card = UIBox{
		definition = {n = G.UIT.ROOT, config = {colour = G.C.CLEAR}, nodes = {
			{n = G.UIT.O, config = {object = cardarea}}
		}},
		config = {
			major = G.ROOM_ATTACH,
			align = "cli",
			offset = {
				x = 2,
				y = offset
			}
		}
	}
	ease_value(self.UI.card_quip_card.alignment.offset, "y", -offset, nil, nil, true, 0.1)

	local text = {}
	local info = localize((target.synthb_quip_key or target.original_key) .. (force_card and "_forced" or ""), "synthb_song_quips")
	local rows = info.rows
	local text_scale = info.scale or 0.6
	for i, row in ipairs(rows) do
		text[#text+1] = {n = G.UIT.R, nodes = {
			{n = G.UIT.O, config = {object = DynaText{
				string = {row},
				colours = {G.C.WHITE},
				pop_in_rate = 2,
				pop_in = 0.5 * (i - 1) + 0.5,
				bump_amount = 0,
				scale = text_scale,
				silent = true
			}}}
		}}
	end
	
	local quip_w = 8
	local quip_h = 3.5
	self.UI.card_quip_box = UIBox{
		definition = {n = G.UIT.ROOT, config = {colour = adjust_alpha(self.C.PHONE.QUIP, 0.8), r = true, res = 2, minw = quip_w, minh = quip_h}, nodes = {
			{n = G.UIT.C, config = {minw = 0.25}},
			{n = G.UIT.C, nodes = {
				{n = G.UIT.R, config = {minh = 0.25}},
				{n = G.UIT.R, nodes = text}
			}}
		}},
		config = {
			major = self.UI.card_quip_card,
			align = "bm",
			offset = {
				x = 0,
				y = -1.5
			}
		}
	}
end

function SynthB.PJSK:back_button()
	self.UI.back_button = UIBox{
		definition = {n = G.UIT.ROOT, config = {colour = G.C.CLEAR, button_dist = 0, button = "synthb_pjsk_transition", ref_table = "back"}, nodes = {
			{n = G.UIT.O, config = {object = SMODS.create_sprite(0, 0, 1.2, 1.2, "synthb_pjsk_back")}}
		}},
		config = {
			align = "tli",
			major = G.ROOM_ATTACH
		}
	}
end

function SynthB.PJSK:config_tab(type, no_border)
	local label = localize("b_synthb_config_" .. type)
	local tab_w = 3
	local tab_h = 1
	local tab_padding = 0.25
	local full_h = tab_h + tab_padding
	local border_padding = not no_border and 0.1 or 0
	return {n = G.UIT.C, config = {minw = tab_w, minh = full_h}, nodes = {
		{n = G.UIT.R, config = {minh = tab_padding}},
		{n = G.UIT.R, config = {minw = tab_w, minh = tab_h, id = "tab_" .. type, r = true, res = 1, colour = self.C.CONFIG.BACKGROUND_DARK, synthb_no_bottom_corners = true}, nodes = {
			{n = G.UIT.C, config = {minw = tab_w - border_padding, minh = tab_h}, nodes = {
				{n = G.UIT.C, config = {minw = tab_w - border_padding, minh = tab_h, button = "synthb_pjsk_config_tab", ref_table = type, button_dist = 0, align = "cm"}, nodes = {
					{n = G.UIT.T, config = {text = label, scale = 0.5, colour = self.C.CONFIG.TEXT_LIGHT}}
				}},
				not no_border and {n = G.UIT.C, config = {minw = border_padding, minh = tab_h, align = "cm"}, nodes = {
					{n = G.UIT.B, config = {w = border_padding, h = 0.5, colour = self.C.CONFIG.BORDER}}
				}} or nil
			}}
		}},
	}}
end

function G.FUNCS.synthb_pjsk_config_tab (e)
	local order = {"general", "info", "spoilers", "debug"}
	for _, tab in ipairs(order) do
		local E = SynthB.PJSK.UI.config:get_UIE_by_ID("tab_" .. tab)
		E.config.colour = SynthB.PJSK.C.CONFIG.BACKGROUND_DARK
		E.children[1].children[1].children[1].config.colour = SynthB.PJSK.C.CONFIG.TEXT_LIGHT
		if E.children[1].children[2] then
			E.children[1].children[2].children[1].config.colour = SynthB.PJSK.C.CONFIG.BORDER
		end
	end
	e.parent.parent.config.colour = SynthB.PJSK.C.CONFIG.BACKGROUND
	e.children[1].config.colour = SynthB.PJSK.C.CONFIG.TEXT_DARK
	for i, tab in ipairs(order) do
		if tab == e.config.ref_table then
			if i > 1 then
				SynthB.PJSK.UI.config:get_UIE_by_ID("tab_" .. order[i - 1]).children[1].children[2].children[1].config.colour = SynthB.PJSK.C.CONFIG.BACKGROUND_DARK
			end
			break
		end
	end
	if e.parent.children[2] then
		e.parent.children[2].children[1].config.colour = SynthB.PJSK.C.CONFIG.BACKGROUND
	end

	local target = SynthB.PJSK.UI.current_config.parent
	SynthB.PJSK.UI.current_config:remove()
	SynthB.PJSK.UI.current_config = UIBox{
		definition = SynthB.PJSK:config_page(e.config.ref_table),
		config = {
			parent = target,
			instance_type = "PJSK_CONFIG"
		}
	}
	target.config.object = SynthB.PJSK.UI.current_config
	target.UIBox:recalculate()


end

local h = 8
local w = 3 * 4

function SynthB.PJSK:config_page(type)
	SynthB.PJSK.second_layer = true
	if self.UI.config_scrollbox then self.UI.config_scrollbox:remove() end
	self.UI.config_scrollbox = SMODS.UIScrollBox{
		content = {
			definition = self["config_" .. type](self),
			config = {
				align = "cmi",
			}
		},

		overflow = {
			node_config = {
				maxh = h,
				r = 0.1,
			},
		},
	}
	SynthB.PJSK.second_layer = nil
	return {n = G.UIT.ROOT, config = {colour = G.C.CLEAR, align = "tr"}, nodes = {
		{n = G.UIT.C, config = {minw = w, minh = h}, nodes = {
			{n = G.UIT.O, config = {object = self.UI.config_scrollbox}}
		}},
		{n = G.UIT.C, config = {minw = 1.2, align = "cm"}, nodes = {
			SMODS.GUI.scrollbar({
				h = h,
				w = 0.2,
				min = 0,
				max = 1,
				bg_colour = { 0, 0, 0, 0.15 },
				scroll_collision_obj = self.UI.config_scrollbox,
				knob_h = 0.6,
				scroll_mult = 3
			})
		}}
	}}
end

---@class PJSKToggleArgs
---@field label string localization key for the label
---@field ref_table? string|string[]|table use something other than the base config table
---@field ref_value string what config field to modify
---@field w? number width in balaunits
---@field h? number button height in balaunits
---@field row? boolean `true` if return node should be a row

--- creates a config toggle for synthb's mod menu
--- @param args PJSKToggleArgs
function SynthB.PJSK:toggle(args)
	args.label = "  " .. localize(args.label or "ph_synthb_missing_label") .. "  "
	if not args.ref_table then args.ref_table = SynthB.mod.config
	else
		if type(args.ref_table) ~= "table" then args.ref_table = SynthB.mod.config[args.ref_table]
		elseif args.ref_table[1] ~= nil then
			local target = SynthB.mod.config
			repeat
---@diagnostic disable-next-line: need-check-nil
				target = target[args.ref_table[1]]
---@diagnostic disable-next-line: param-type-mismatch
				table.remove(args.ref_table, 1)
			until args.ref_table[1] == nil
			args.ref_table = target
		end
	end
	args.w = args.w or ((w - 0.2) / 3)
	args.h = args.h or 1.4

	local text_h = 0.6
	local padding_h = 0.1
	local full_h = args.h + text_h + padding_h
	local button_padding_w = 0.1
	local button_w = (args.w - button_padding_w ) / 2

	local active = args.ref_table[args.ref_value]

	return {n = args.row and G.UIT.R or G.UIT.C, config = {minw = args.w, minh = full_h, align = "tm"}, nodes = {
		{n = G.UIT.R, config = {minw = args.w, minh = text_h, maxw = args.w, maxh = text_h, r = true, align = "cm", colour = self.C.CONFIG.TOGGLE}, nodes = {
			{n = G.UIT.T, config = {text = args.label, colour = self.C.CONFIG.TEXT_LIGHT, scale = 0.5}}
		}},
		{n = G.UIT.R, config = {minh = padding_h}},
		{n = G.UIT.R, config = {minw = args.w, minh = args.h, align = "cm", res = 2, r = true, colour = self.C.CONFIG.TOGGLE_SPACING}, nodes = {
			{n = G.UIT.C, config = {minw = button_w, minh = args.h, maxw = button_w, maxh = args.h, res = 2, r = true, colour = active and self.C.CONFIG.TOGGLE or self.C.CONFIG.TOGGLE_SPACING}, nodes = {
				{n = G.UIT.C, config = {minw = button_w, minh = args.h, maxw = button_w, maxh = args.h, ref_table = {set = true, args = args}, button = "synthb_pjsk_toggle", button_dist = 0, align = "cm"}, nodes = {
					{n = G.UIT.T, config = {text = localize("b_synthb_on"), scale = 0.7, colour = self.C.CONFIG.TEXT_DARK}}
				}}
			}},
			{n = G.UIT.B, config = {w = button_padding_w, h = 0.1}},
			{n = G.UIT.C, config = {minw = button_w, minh = args.h, maxw = button_w, maxh = args.h, res = 2, r = true, colour = not active and self.C.CONFIG.TOGGLE or self.C.CONFIG.TOGGLE_SPACING}, nodes = {
				{n = G.UIT.C, config = {minw = button_w, minh = args.h, maxw = button_w, maxh = args.h, ref_table = {set = false, args = args}, button = "synthb_pjsk_toggle", button_dist = 0, align = "cm"}, nodes = {
					{n = G.UIT.T, config = {text = localize("b_synthb_off"), scale = 0.7, colour = self.C.CONFIG.TEXT_DARK}}
				}}
			}}
		}}
	}}
end

function G.FUNCS.synthb_pjsk_toggle (e)
	e.config.ref_table.args.ref_table[e.config.ref_table.args.ref_value] = e.config.ref_table.set
	e.parent.parent.children[1].config.colour = e.config.ref_table.set and SynthB.PJSK.C.CONFIG.TOGGLE or SynthB.PJSK.C.CONFIG.TOGGLE_SPACING
	e.parent.parent.children[3].config.colour = not e.config.ref_table.set and SynthB.PJSK.C.CONFIG.TOGGLE or SynthB.PJSK.C.CONFIG.TOGGLE_SPACING
end

function SynthB.PJSK:config_general()
	return {n = G.UIT.ROOT, config = {colour = G.C.CLEAR, minw = w, minh = h}, nodes = {
		{n = G.UIT.R, nodes = {
			self:toggle{
				label = "ph_synthb_triple_click_for_song",
				ref_value = "triple_click_for_song"
			},
			{n = G.UIT.B, config = {w = 0.1, h = 0.1}},
			self:toggle{
				label = "ph_synthb_mizuki_zoomies",
				ref_value = "mizuki_zoomies"
			}
		}}
	}}
end

function SynthB.PJSK:config_info()
	return {n = G.UIT.ROOT, config = {colour = G.C.CLEAR, minw = w, minh = h}, nodes = {
		{n = G.UIT.R, config = {align = "cm"}, nodes = {
			self:toggle{
				label = "ph_synthb_display_misc_info",
				ref_value = "display_misc_info"
			},
		}},
		{n = G.UIT.R, config = {minh = 0.2}},
		{n = G.UIT.R, config = {minh = 0.1, minw = w, colour = self.C.CONFIG.TOGGLE}},
		{n = G.UIT.R, config = {minh = 0.2}},
		{n = G.UIT.R, nodes = {
			self:toggle{
				label = "ph_synthb_display_song_info",
				ref_value = "display_song_info"
			},
			{n = G.UIT.B, config = {w = 0.1, h = 0.1}},
			self:toggle{
				label = "ph_synthb_display_heat_info",
				ref_value = "display_heat_info"
			},
			{n = G.UIT.B, config = {w = 0.1, h = 0.1}},
			self:toggle{
				label = "ph_synthb_display_energy_drink_info",
				ref_value = "display_energy_drink_info"
			}
		}},
		{n = G.UIT.R, config = {minh = 0.2}},
		{n = G.UIT.R, nodes = {
			self:toggle{
				label = "ph_synthb_display_blackjack_info",
				ref_value = "display_blackjack_info"
			},
			{n = G.UIT.B, config = {w = 0.1, h = 0.1}},
		}},
	}}
end

function SynthB.PJSK:config_spoilers()
	return {n = G.UIT.ROOT, config = {colour = G.C.CLEAR, minw = w, minh = h}, nodes = {
		{n = G.UIT.R, nodes = {
			self:toggle{
				label = "ph_synthb_spoilers_deltarune",
				ref_table = "spoilers",
				ref_value = "deltarune"
			},
			{n = G.UIT.B, config = {w = 0.1, h = 0.1}},
		}}
	}}
end

function SynthB.PJSK:config_debug()
	return {n = G.UIT.ROOT, config = {colour = G.C.CLEAR, minw = w, minh = h}, nodes = {
		{n = G.UIT.R, nodes = {
			self:toggle{
				label = "ph_synthb_allow_covers_on_any_card",
				ref_value = "allow_covers_on_any_card"
			},
			{n = G.UIT.B, config = {w = 0.1, h = 0.1}},
			self:toggle{
				label = "ph_synthb_DEBUG",
				ref_value = "DEBUG"
			},
			{n = G.UIT.B, config = {w = 0.1, h = 0.1}},
			self:toggle{
				label = "ph_synthb_disable_non_scoring_character_animations",
				ref_value = "disable_non_scoring_character_animations"
			}
		}},
		{n = G.UIT.R, config = {minh = 0.2}},
		{n = G.UIT.R, nodes = {
			self:toggle{
				label = "ph_synthb_experimental_features",
				ref_value = "experimental_features"
			},
			{n = G.UIT.B, config = {w = 0.1, h = 0.1}},
		}},
		{n = G.UIT.R, config = {minh = 0.2}},
		{n = G.UIT.R, config = {minh = 0.1, minw = w, colour = self.C.CONFIG.TOGGLE}},
		{n = G.UIT.R, config = {minh = 0.2}},
		{n = G.UIT.R, config = {minw = w, align = "cm"}, nodes = {
			{n = G.UIT.T, config = {text = localize("ph_synthb_requires_restart"), scale = 0.5, colour = self.C.CONFIG.TEXT_DARK}}
		}}
	}}
end

function SynthB.PJSK:config()
	SynthB.PJSK.second_layer = true
	self:gogogadget_ui_blocker_2()

	local config_w = 14.2
	local config_h = 11.25
	local tab_h = 1.25
	local back_h = 1.5
	local bottom_h = 8
	local button_w = 3
	local button_h = 1.2
	
	self.UI.current_config = Moveable()

	self.UI.config = UIBox{
		definition = {n = G.UIT.ROOT, config = {minw = config_w, minh = config_h, colour = self.C.CONFIG.BACKGROUND_DARK, r = true, res = 1}, nodes = {
			{n = G.UIT.R, config = {minw = config_w, minh = tab_h}, nodes = {
				{n = G.UIT.B, config = {w = 1, h = 1}},
				self:config_tab("general"),
				self:config_tab("info"),
				self:config_tab("spoilers"),
				self:config_tab("debug", true),
				{n = G.UIT.C, config = {button = "synthb_pjsk_transition", ref_table = "back", button_dist = 0, align = "cm", minh = tab_h, minw = config_w - 1 - 3 * 4}, nodes = {
					{n = G.UIT.O, config = {object = SMODS.create_sprite(0, 0, 1, 1, "synthb_pjsk_back", {x = 1, y = 0})}}
				}},
			}},
			{n = G.UIT.R, config = {minh = 0.5, colour = self.C.CONFIG.BACKGROUND}},
			{n = G.UIT.R, config = {minw = config_w, minh = bottom_h, colour = self.C.CONFIG.BACKGROUND, align = "tr"}, nodes = {
				{n = G.UIT.O, config = {object = self.UI.current_config}}
			}},
			{n = G.UIT.R, config = {minw = config_w, minh = back_h, colour = self.C.CONFIG.BACKGROUND, r = true, res = 1, synthb_no_top_corners = true, align = "cm"}, nodes = {
				{n = G.UIT.C, config = {minw = button_w, minh = button_h, colour = self.C.CONFIG.BACK_BUTTON, outline = 1, outline_colour = self.C.CONFIG.BACK_BORDER, r = true}, nodes = {
					{n = G.UIT.R, config = {minw = button_w, minh = button_h, button = "synthb_pjsk_transition", ref_table = "back", button_dist = 0, align = "cm"}, nodes = {
						{n = G.UIT.T, config = {text = localize("b_synthb_back"), colour = self.C.CONFIG.TEXT_DARK, scale = 0.75}}
					}}
				}}
			}}
		}},
		config = {
			align = "cmi",
			major = G.ROOM_ATTACH
		}
	}
	G.FUNCS.synthb_pjsk_config_tab(SynthB.PJSK.UI.config:get_UIE_by_ID("tab_general").children[1].children[1])
	SynthB.PJSK.second_layer = nil
end

function SynthB.PJSK:credits_sidebar()
	local w = 3.7
	local h = G.ROOM.T.h - 4

	self.UI.credits_sidebar = UIBox{
		definition = {n = G.UIT.ROOT, config = {colour = self.C.CREDITS.SIDEBAR.BACKGROUND, outline = 1, outline_colour = self.C.CREDITS.SIDEBAR.BORDER, align = "cr", minw = 15 + w, minh = h, r = true, res = 2}, nodes = {
			{n = G.UIT.C, config = {minw = w, minh = h, align = "cr"}, nodes = {
				self:credits_sidebar_tab("coders"),
				self:credits_sidebar_divider(),
				self:credits_sidebar_tab("artists"),
				self:credits_sidebar_divider(),
				self:credits_sidebar_tab("artists2")
			}}
		}},
		config = {
			major = G.ROOM_ATTACH,
			align = "cl",
			offset = {
				x = -15 + w - 0.75,
				y = 0.5
			}
		}
	}

	G.FUNCS.synthb_pjsk_credits_section(self.UI.credits_sidebar:get_UIE_by_ID(self.last_credit_tab))

	ease_value(self.UI.credits_sidebar.alignment.offset, "x", 15, nil, nil, true, 0.1)
end

function SynthB.PJSK:credits_sidebar_divider()
	local s = 0.1
	return {n = G.UIT.R, config = {align = "cr", padding = 0.1}, nodes = {
		{n = G.UIT.B, config = {w = s, h = s, colour = self.C.CREDITS.SIDEBAR.DOTS, r = true}},
		{n = G.UIT.B, config = {w = s, h = s, colour = self.C.CREDITS.SIDEBAR.DOTS, r = true}},
		{n = G.UIT.B, config = {w = s, h = s, colour = self.C.CREDITS.SIDEBAR.DOTS, r = true}},
		{n = G.UIT.B, config = {w = s, h = s, colour = self.C.CREDITS.SIDEBAR.DOTS, r = true}},
		{n = G.UIT.B, config = {w = s, h = s, colour = self.C.CREDITS.SIDEBAR.DOTS, r = true}},
		{n = G.UIT.B, config = {w = s, h = s, colour = self.C.CREDITS.SIDEBAR.DOTS, r = true}},
		{n = G.UIT.B, config = {w = s, h = s, colour = self.C.CREDITS.SIDEBAR.DOTS, r = true}},
		{n = G.UIT.B, config = {w = s, h = s, colour = self.C.CREDITS.SIDEBAR.DOTS, r = true}},
		{n = G.UIT.B, config = {w = s, h = s, colour = self.C.CREDITS.SIDEBAR.DOTS, r = true}},
		{n = G.UIT.B, config = {w = s, h = s, colour = self.C.CREDITS.SIDEBAR.DOTS, r = true}},
		{n = G.UIT.B, config = {w = s, h = s, colour = self.C.CREDITS.SIDEBAR.DOTS, r = true}},
		{n = G.UIT.B, config = {w = s, h = s, colour = self.C.CREDITS.SIDEBAR.DOTS, r = true}},
		{n = G.UIT.B, config = {w = s, h = s, colour = self.C.CREDITS.SIDEBAR.DOTS, r = true}},
		{n = G.UIT.B, config = {w = s, h = s, colour = self.C.CREDITS.SIDEBAR.DOTS, r = true}},
		{n = G.UIT.B, config = {w = s, h = s, colour = self.C.CREDITS.SIDEBAR.DOTS, r = true}},
		{n = G.UIT.B, config = {w = s, h = s, colour = self.C.CREDITS.SIDEBAR.DOTS, r = true}},
	}}
end

function SynthB.PJSK:credits_sidebar_tab(type)
	local label = localize("b_synthb_sidebar_" .. type)
	local colour = ({
		coders = self.C.CREDITS.SIDEBAR.CODERS,
		artists = self.C.CREDITS.SIDEBAR.ARTISTS,
		artists2 = self.C.CREDITS.SIDEBAR.ARTISTS2,
		music = self.C.CREDITS.SIDEBAR.MUSIC,
	})[type]
	local text_colour = ({
		coders = self.C.CONFIG.TEXT_DARK,
		artists = self.C.CONFIG.TEXT_LIGHT,
		artists2 = self.C.CONFIG.TEXT_LIGHT,
		music = self.C.CONFIG.TEXT_LIGHT,
	})[type]
	local h = (6.5 - 0.3 * 2) / 3
	local w = 3.7
	local dither_w = h / 83 * 46
	return {n = G.UIT.R, config = {id = type, align = "cr", button_dist = 0, button = "synthb_pjsk_credits_section", ref_table = {type = type, colour = colour, text_colour = text_colour}}, nodes = {
		{n = G.UIT.B, config = {w = dither_w, h = h, colour = G.C.CLEAR, shader = 'synthb_pjsk_mask_ui', pjsk_mask = "synthb_pjsk_dither"}},
		{n = G.UIT.C, config = {minw = w, minh = h, align = "cm"}, nodes = {
			{n = G.UIT.T, config = {text = label, colour = self.C.CONFIG.TEXT_LIGHT, scale = 0.7}}
		}}
	}}
end

function G.FUNCS.synthb_pjsk_credits_section(e)
	if SynthB.PJSK.safe_click then
		SynthB.PJSK.safe_click = false
		local targets = {e.parent.children[1], e.parent.children[3], e.parent.children[5]}
		for _, target in ipairs(targets) do
			target.children[1].config.colour = G.C.CLEAR
			target.children[2].config.colour = G.C.CLEAR
			target.children[2].children[1].config.colour = SynthB.PJSK.C.CONFIG.TEXT_LIGHT
		end
		e.children[1].config.colour = e.config.ref_table.colour
		e.children[2].config.colour = e.config.ref_table.colour
		e.children[2].children[1].config.colour = e.config.ref_table.text_colour
		SynthB.PJSK:credits_section(e.config.ref_table.type)
		SynthB.PJSK.last_credit_tab = e.config.ref_table.type
		
		G.E_MANAGER:add_event(Event{
			func = function()
				SynthB.PJSK.safe_click = true
				return true
			end
		})
	end
end

function SynthB.PJSK:remove_credits_section()
	local time = 0.1
	local keys = {}
	for i = 1, 5 do
		local key = "credits_section_" .. i
		local target_key = key
		repeat target_key = target_key .. "_b" until not self.UI[target_key]
		keys[i] = target_key
		self.UI[target_key] = self.UI[key]
		self.UI[key] = nil
		key = target_key
		delay(0.01 * (i - 1), "other")
		G.E_MANAGER:add_event(Event{
			func = function()
				ease_value(self.UI[key].alignment.offset, "y", 15, nil, nil, true, time, "outquad")
				return true
			end
		}, "other")
	end
	delay(time, "other")
	G.E_MANAGER:add_event(Event{
		func = function()
			for i = 1, 5 do
				local key = keys[i]
				if self.UI[key] then
					self.UI[key]:remove()
					self.UI[key] = nil
				end
			end
			return true
		end
	}, "other")
end

function SynthB.PJSK:credits_section(type)
	if self.UI.credits_section_1 then
		self:remove_credits_section()
	end

	local people = {}
	for _, key in ipairs(SynthB.Credits.index_to_key) do
		if SynthB.Credits.data[key].synthb_role[type] then
			people[#people + 1] = SynthB.Credits.data[key]
		end
	end
	while #people < 5 do
		people[#people+1] = SynthB.Credits.data.credits_placeholder
	end

	---@type string
---@diagnostic disable-next-line: assign-type-mismatch
	local label = localize("b_synthb_sidebar_" .. type) or "???"

	local full_w = 2.5
	local full_h = 8
	local padding = 0.5
	local inner_w = full_w - padding
	local inner_h = full_h - padding
	local text_padding_h = padding + 0.1
	local random_bar_padding = padding * 5 / 3
	local random_bar_h = padding * 1.25
	local random_bar_w = 0.15
	local bottom_trapezoid_h = 1.75
	local bottom_rect_h = 1.25
	local top_padding = full_h - (random_bar_padding + random_bar_h + bottom_trapezoid_h + bottom_rect_h)
	local bottom_trapezoid_padding_h = 0.75
	for i, person in ipairs(people) do
		---@type string
---@diagnostic disable-next-line: assign-type-mismatch
		local name = localize{type = "name_text", set = "SynthBCredits", key = person.original_key} or "???"
		if name == "ERROR" then name = "???" end
		local desc = localize(person.original_key, "synthb_credits_desc")
		if desc == "ERROR" then desc = localize("credits_placeholder", "synthb_credits_desc") end

		local main_box = UIBox{
			definition = {n = G.UIT.ROOT, config = {colour = G.C.CLEAR, minw = full_w, minh = full_h}, nodes = {
				{n = G.UIT.B, config = {w = padding, h = 0.5}},
				{n = G.UIT.C, config = {minw = inner_w, minh = inner_h, colour = self.C.CREDITS.SIDEBAR.BACKGROUND, align = "tr"}, nodes = {
					{n = G.UIT.R, config = {minh = text_padding_h}},
					{n = G.UIT.R, nodes = {
						{n = G.UIT.T, config = {vert = true, text = name:upper(), colour = self.C.CREDITS.SIDEBAR.BACKGROUND, text_outline = self.C.CREDITS.SECTION.OUTLINE, scale = 0.5}},
						{n = G.UIT.B, config = {h = 0.1, w = 0.05}}
					}}
				}}
			}},
			config = {
				align = "cmi",
				major = G.ROOM_ATTACH,
				offset = {
					x = -4 + 3.2 * (i - 1),
					y = -15 - 0.5
				}
			}
		}
		self.UI["credits_section_" .. i] = main_box
		local white_box = UIBox{
			definition = {n = G.UIT.ROOT, config = {colour = G.C.CLEAR, minw = full_w, minh = full_h}, nodes = {
				{n = G.UIT.R, config = {minh = padding}},
				{n = G.UIT.C, config = {minw = inner_w, minh = inner_h, colour = self.C.CREDITS.SECTION.WHITE, align = "tl"}, nodes = {
					{n = G.UIT.R, config = {minh = text_padding_h}},
					{n = G.UIT.R, nodes = {
						{n = G.UIT.B, config = {h = 0.1, w = 0.1}},
						{n = G.UIT.T, config = {vert = true, text = label:upper(), colour = self.C.CREDITS.SECTION.WHITE, text_outline = self.C.CREDITS.SECTION.OUTLINE, scale = 0.5}},
					}}
				}}
			}},
			config = {
				align = "cmi",
				major = main_box,
			}
		}

		local sprite

		local is_aiko = person.key == "j_synthb_credits_aiko"

		if is_aiko then
			sprite = SMODS.create_sprite(0, 0, 3.5, 9, "synthb_" .. person.mini_atlas)
		elseif person.mini_pos or person.mini_atlas then
			sprite = SMODS.create_sprite(0, 0, inner_w, full_h, person.mini_atlas and ("synthb_" .. person.mini_atlas) or person.atlas or "Jokers", person.mini_pos or person.pos)
		else
			sprite = SMODS.create_sprite(0, 0, full_h / G.CARD_H * G.CARD_W, full_h, person.atlas or "Jokers")
		end

		local image_box = UIBox{
			definition = {n = G.UIT.ROOT, config = {colour = G.C.CLEAR, minw = full_w, minh = full_h}, nodes = {
				{n = G.UIT.C, config = {minw = inner_w, minh = full_h, maxw = not is_aiko and inner_w or nil, maxh = not is_aiko and full_h or nil, no_overflow = true, align = "cm"}, nodes = {
					{n = G.UIT.O, config = {object = sprite}}
				}}
			}},
			config = {
				align = "cmi",
				major = main_box,
			}
		}

		local colour = person.colour or self.C.CREDITS.SECTION.DEFAULT_COLOUR
		local trapezoid_colour = adjust_alpha(colour, 0.8)
		local rect_colour = darken(trapezoid_colour, 0.2)
		local top_box = UIBox{
			definition = {n = G.UIT.ROOT, config = {colour = G.C.CLEAR, minw = full_w, minh = full_h, button = "synthb_credits_page", ref_table = person.original_key, button_dist = 0}, nodes = {
				{n = G.UIT.R, config = {minh = random_bar_padding}},
				{n = G.UIT.R, nodes = {
					{n = G.UIT.B, config = {h = random_bar_h, w = random_bar_w, colour = colour}}
				}},
				{n = G.UIT.R, config = {minh = top_padding}},
				{n = G.UIT.R, config = {minh = bottom_trapezoid_h, minw = full_w, colour = trapezoid_colour, r = true, synthb_trapezoid = true}, nodes = {
					{n = G.UIT.R, config = {minh = bottom_trapezoid_padding_h}},
					{n = G.UIT.R, config = {minw = full_w, maxw = full_w, align = "cm"}, nodes = {
						{n = G.UIT.T, config = {text = name, colour = self.C.CREDITS.SECTION.TEXT_LIGHT, scale = 0.6, text_outline = self.C.CONFIG.TEXT_DARK}}
					}},
					{n = G.UIT.R, config = {minh = 0.1}},
					{n = G.UIT.R, config = {minw = full_w, maxw = full_w, align = "cm"}, nodes = {
						{n = G.UIT.T, config = {text = desc, scale = 0.3, colour = self.C.CONFIG.TEXT_DARK}}
					}}
				}},
				{n = G.UIT.R, config = {minh = bottom_rect_h, minw = full_w, colour = rect_colour}},
			}},
			config = {
				align = "cmi",
				major = main_box,
			}
		}

		
		local button_box = UIBox{
			definition = {n = G.UIT.ROOT, config = {colour = G.C.CLEAR, minw = full_w, minh = full_h, button = person.original_key ~= "credits_placeholder" and "synthb_credits_page" or nil, ref_table = person.original_key, button_dist = 0}},
			config = {
				align = "cmi",
				major = main_box,
			}
		}

		local main_box_remove_ref = main_box.remove
		function main_box:remove()
			main_box_remove_ref(self)
			white_box:remove()
			image_box:remove()
			top_box:remove()
			button_box:remove()
		end

		delay(0.01 * (i - 1))
		G.E_MANAGER:add_event(Event{
			func = function()
				if self.UI["credits_section_" .. i] then
					ease_value(self.UI["credits_section_" .. i].alignment.offset, "y", 15, nil, nil, true, 0.1, "elastic")
				end
				return true
			end
		})
	end
end

function G.FUNCS.synthb_credits_page(e)
	SynthB.PJSK:transition("single_credit", e.config.ref_table)
end

function SynthB.PJSK:credits_text()
	self.UI.credits_text = UIBox{
		definition = {n = G.UIT.ROOT, config = {colour = G.C.CLEAR}, nodes = {
			{n = G.UIT.T, config = {text = localize("ph_synthb_select_a_contributor"), colour = self.C.CREDITS.SECTION.TEXT_LIGHT, scale = 0.5, text_outline = self.C.CONFIG.TEXT_DARK}}
		}},
		config = {
			align = "bmi",
			major = G.ROOM_ATTACH,
			offset = {
				x = 2,
				y = 15 - 1
			}
		}
	}
	ease_value(self.UI.credits_text.alignment.offset, "y", -15, nil, nil, true, 0.1)
end

function SynthB.PJSK:single_credit_left(person)
	local w = 6
	local h = w / G.CARD_W * G.CARD_H
	local card = Card(0, 0, w, h, nil, "c_base")
	if card.children.front then
		card.children.front:remove()
		card.children.front = nil
	end

	local target = G.P_CENTERS["j_synthb_" .. person]

	card.children.center:remove()
	card.children.center = SMODS.create_sprite(0, 0, w, h, target.atlas or "Jokers", target.pos)
	card.states.collide.can = false
	function card:update()
		card.states.collide.can = false
		card.T.r = 0
	end
	card.synthb_quip = true
	card.children.center.states.collide.can = false
	card.children.center:set_role({major = card, role_type = 'Glued', draw_major = card})

	local cardarea = CardArea(0, 0, w, h, {type = 'title_2', card_limit = 1, highlight_limit = 0})
	cardarea:emplace(card)

	local extra_h = 0.7
	local offset = G.ROOM_ATTACH.T.h + extra_h + 2
	self.UI.credit_card = UIBox{
		definition = {n = G.UIT.ROOT, config = {colour = G.C.CLEAR}, nodes = {
			{n = G.UIT.O, config = {object = cardarea}}
		}},
		config = {
			major = G.ROOM_ATTACH,
			align = "cli",
			offset = {
				x = 2,
				y = offset
			}
		}
	}
	ease_value(self.UI.credit_card.alignment.offset, "y", -offset, nil, nil, true, 0.1)

	self.UI.credit_card_box = UIBox{
		definition = {n = G.UIT.ROOT, config = {colour = G.C.CLEAR}, nodes = {
			{n = G.UIT.R, config = {align = "cl", colour = adjust_alpha(G.C.UI.TRANSPARENT_DARK, 0.8), minw = 6, minh = 2, r = 0.2}, nodes = {
				{n = G.UIT.C, nodes = {
					{n = G.UIT.B, config = {w = 0.25, h = 1.9}}
				}},
				{n = G.UIT.C, nodes = {
					{n = G.UIT.R, nodes = {
						{n = G.UIT.B, config = {w = 6, h = 0.1}}
					}},
					{n = G.UIT.R, config = {align = "cl"}, nodes = {
						{n = G.UIT.T, config = {text = localize{type = "name_text", set = "SynthBCredits", key = person}, scale = 1.2, colour = G.C.UI.TEXT_LIGHT}}
					}},
					{n = G.UIT.R, nodes = {
						{n = G.UIT.B, config = {w = 6, h = 0.1}}
					}},
					{n = G.UIT.R, config = {align = "cl"}, nodes = {
						{n = G.UIT.C, nodes = {
							{n = G.UIT.B, config = {w = 0.25, h = 0.5}}
						}},
						{n = G.UIT.C, config = {align = "cm"}, nodes = {
							{n = G.UIT.O, config = {object = SMODS.create_sprite(0, 0, 0.5, 0.5, "synthb_modicon", {x = 0, y = 0})}}
						}},
						{n = G.UIT.C, nodes = {
							{n = G.UIT.B, config = {w = 0.25, h = 0.5}}
						}},
						{n = G.UIT.C, config = {align = "cl", maxw = 4.5}, nodes = {
							{n = G.UIT.T, config = {text = localize(person, "synthb_credits_desc"), scale = 0.5, colour = G.C.UI.TEXT_LIGHT}}
						}}
					}},
					{n = G.UIT.R, nodes = {
						{n = G.UIT.B, config = {w = 6, h = 0.1}}
					}},
				}},
			}}
		}},
		config = {
			major = self.UI.credit_card,
			align = "bm",
			offset = {
				x = 0,
				y = -1.5
			}
		}
	}

end

function G.FUNCS.synthb_pjsk_align_book_box (e)
	e.UIBox.T.r = 0.02
	if SynthB.mod.config.mizuki_zoomies then
		e.UIBox.T.r = 2 * math.pi * math.sin(math.sin(G.TIMERS.REAL) + 2 * math.sin(G.TIMERS.REAL * 2) + 0.5 * math.sin(G.TIMERS.REAL * 8))
	end
end

function SynthB.PJSK:single_credit_book(person)
	local book_h = 7.1 * 3 / 2
	local book_w = book_h
	
	local target = G.P_CENTERS["j_synthb_" .. person]
	local nodes = {background_colour = self.C.CREDITS.SIDEBAR.BACKGROUND}
	self.text_colour = self.C.CONFIG.TEXT_LIGHT
	localize{type = "descriptions", set = "SynthBCredits", key = person, vars = target:credit_vars(), nodes = nodes}
	self.text_colour = nil
	local desc = desc_from_rows(nodes, true, book_w - 0.2 - 0.1 - 0.5 - 0.5)
	desc.config.minw = book_w - 0.2 - 0.1 - 0.5 - 0.5
	desc.config.minh = person == "credits_foo54" and 4.5 or 9
	desc.config.align = "tl"
	desc.config.padding = 0.1
	desc.config.emboss = 0.1
	for _, node in ipairs(desc.nodes) do
		for _, _node in ipairs(node.nodes) do
			_node.config.align = "tl"
		end
		node.config.align = "tl"
	end

	self.UI.credit_book = UIBox{
		definition = {n = G.UIT.ROOT, config = {func = "synthb_pjsk_align_book_box", minh = book_h, minw = book_w, colour = SynthB.custom_colors.credits.foo.BOOK, emboss = 0.2, r = 0.2}, nodes = {
			{n = G.UIT.C, nodes = {
				{n = G.UIT.B, config = {colour = SynthB.custom_colors.credits.foo.BOOK_2, w = 0.2, h = book_h}}
			}},
			{n = G.UIT.C, nodes = {
				{n = G.UIT.B, config = {colour = SynthB.custom_colors.credits.foo.BOOK_3, w = 0.1, h = book_h}}
			}},
			{n = G.UIT.C, nodes = {
				{n = G.UIT.B, config = {w = 0.5, h = book_h}}
			}},
			{n = G.UIT.C, config = {minw = book_w - 0.2 - 0.1 - 0.5 - 0.5, align = "tm"}, nodes = {
				{n = G.UIT.R, config = {minw = book_w - 0.2 - 0.1 - 0.5 - 0.5, align = "cr"}, nodes = {
					{n = G.UIT.C, nodes = {
						{n = G.UIT.B, config = {w = 0.5, h = 1.5}}
					}},
					{n = G.UIT.C, nodes = {
						{n = G.UIT.T, config = {text = localize{type = "name_text", set = "SynthBCredits", key = person}:upper(), scale = 1.5, colour = SynthB.custom_colors.credits.foo.TEXT}}
					}}
				}},
				{n = G.UIT.R, config = {minw = book_w - 0.2 - 0.1 - 0.5 - 0.5, align = "tl"}, nodes = {
					desc
				}},
				person == "credits_foo54" and {n = G.UIT.R, nodes = {
					{n = G.UIT.B, config = {w = 0.5, h = 0.3}}
				}} or nil,
				person == "credits_foo54" and {n = G.UIT.R, config = {align = "cm"}, nodes = {
					{n = G.UIT.C, config = {align = "cm", minw = 0.5}, nodes = {
						{n = G.UIT.T, config = {text = "Go Go Gadget Mizuki", vert = true, scale = 0.5, colour = SynthB.custom_colors.credits.foo.TEXT}}
					}},
					{n = G.UIT.C, config = {align = "cm"}, nodes = {
						{n = G.UIT.O, config = {object = SMODS.create_sprite(0, 0, 3, 4, "synthb_credits_foo_mizuki", {x = 0, y = 0})}}
					}},
					{n = G.UIT.C, config = {align = "cm", minw = 0.5}, nodes = {
						{n = G.UIT.B, config = {w = 0.5, h = 0.5}}
					}}
				}} or nil
			}},
		}},
		config = {
			align = "cri",
			r_bond = "Weak",
			major = G.ROOM_ATTACH,
			offset = {
				x = 15,
				y = 0
			}
		}
	}

	ease_value(self.UI.credit_book.alignment.offset, "x", -15, nil, nil, true, 0.1)
end

function SynthB.PJSK:content_sidebar()
	local w = 3.7
	local h = G.ROOM.T.h - 4

	self.UI.content_sidebar = UIBox{
		definition = {n = G.UIT.ROOT, config = {colour = self.C.CREDITS.SIDEBAR.BACKGROUND, outline = 1, outline_colour = self.C.CREDITS.SIDEBAR.BORDER, align = "cr", minw = 15 + w, minh = h, r = true, res = 2}, nodes = {
			{n = G.UIT.C, config = {minw = w, minh = h, align = "cr"}, nodes = {
				self:content_sidebar_tab("jokers"),
				self:credits_sidebar_divider(),
				self:content_sidebar_tab("consumables"),
				self:credits_sidebar_divider(),
				self:content_sidebar_tab("modifications"),
				self:credits_sidebar_divider(),
				self:content_sidebar_tab("other"),
			}}
		}},
		config = {
			major = G.ROOM_ATTACH,
			align = "cl",
			offset = {
				x = -15 + w - 0.75,
				y = 0.5
			}
		}
	}

	G.FUNCS.synthb_pjsk_content_section(self.UI.content_sidebar:get_UIE_by_ID(self.last_content_tab))

	ease_value(self.UI.content_sidebar.alignment.offset, "x", 15, nil, nil, true, 0.1)
end

function SynthB.PJSK:content_sidebar_tab(type)
	local label = localize("b_synthb_sidebar_" .. type)
	local h = (6.5 - 0.3 * 3) / 4
	local w = 3.7
	local dither_w = h / 83 * 46
	return {n = G.UIT.R, config = {id = type, align = "cr", button_dist = 0, button = "synthb_pjsk_content_section", ref_table = {type = type}}, nodes = {
		{n = G.UIT.B, config = {w = dither_w, h = h, colour = G.C.CLEAR, shader = 'synthb_pjsk_mask_ui', pjsk_mask = "synthb_pjsk_dither"}},
		{n = G.UIT.C, config = {minw = w, minh = h, align = "cm"}, nodes = {
			{n = G.UIT.T, config = {text = label, colour = self.C.CONFIG.TEXT_LIGHT, scale = 0.7}}
		}}
	}}
end

function G.FUNCS.synthb_pjsk_content_section(e)
	if SynthB.PJSK.safe_click then
		SynthB.PJSK.safe_click = false
		local targets = {e.parent.children[1], e.parent.children[3], e.parent.children[5], e.parent.children[7]}
		for _, target in ipairs(targets) do
			target.children[1].config.colour = G.C.CLEAR
			target.children[2].config.colour = G.C.CLEAR
			target.children[2].children[1].config.colour = SynthB.PJSK.C.CONFIG.TEXT_LIGHT
		end
		e.children[1].config.colour = SynthB.PJSK.C.CREDITS.SIDEBAR.CODERS
		e.children[2].config.colour = SynthB.PJSK.C.CREDITS.SIDEBAR.CODERS
		e.children[2].children[1].config.colour = SynthB.PJSK.C.CONFIG.TEXT_DARK
		local prototypes = {}
		if e.config.ref_table.type == "jokers" then
			for _, center in ipairs(G.P_CENTER_POOLS.Joker) do
				if center.mod == SynthB.mod then
					prototypes[#prototypes+1] = center
				end
			end
		elseif e.config.ref_table.type == "consumables" then
			for _, center in ipairs(G.P_CENTER_POOLS.Tarot) do
				if center.mod == SynthB.mod then
					prototypes[#prototypes+1] = center
				end
			end
			for _, center in ipairs(G.P_CENTER_POOLS.Spectral) do
				if center.mod == SynthB.mod then
					prototypes[#prototypes+1] = center
				end
			end
			for _, center in ipairs(G.P_CENTER_POOLS.Tuning) do
				if center.mod == SynthB.mod then
					prototypes[#prototypes+1] = center
				end
			end
			for _, center in ipairs(G.P_CENTER_POOLS.synthb_Sign) do
				if center.mod == SynthB.mod then
					prototypes[#prototypes+1] = center
				end
			end
		elseif e.config.ref_table.type == "modifications" then
			for _, center in ipairs(G.P_CENTER_POOLS.Enhanced) do
				if center.mod == SynthB.mod then
					prototypes[#prototypes+1] = center
				end
			end
			for _, center in ipairs(G.P_CENTER_POOLS.Edition) do
				if center.mod == SynthB.mod then
					prototypes[#prototypes+1] = center
				end
			end
			for _, center in ipairs(G.P_CENTER_POOLS.Seal) do
				if center.mod == SynthB.mod then
					prototypes[#prototypes+1] = center
				end
			end
			for _, center in pairs(SMODS.Stickers) do
				if center.mod == SynthB.mod then
					prototypes[#prototypes+1] = center
				end
			end
		else
			for _, tag in pairs(G.P_TAGS) do
				if tag.mod == SynthB.mod then
					prototypes[#prototypes+1] = tag
				end
			end
			if SynthB.mod.config.experimental_features then
				for _, center in ipairs(G.P_CENTER_POOLS.synthb_Character) do
					if center.mod == SynthB.mod then
						if center.synthb_character ~= "padding" then
							prototypes[#prototypes+1] = center
						end
					end
				end
			end
		end
		for i = #prototypes, 1, -1 do
			local proto = prototypes[i]
			if proto.no_collection and (proto.no_collection == true or proto:no_collection()) then
				table.remove(prototypes, i)
			end
		end
		SynthB.PJSK:content_box(prototypes)
		SynthB.PJSK.last_content_tab = e.config.ref_table.type
		
		G.E_MANAGER:add_event(Event{
			func = function()
				SynthB.PJSK.safe_click = true
				return true
			end
		})
	end
end

function SynthB.PJSK:collection_area(width, cards)
	return CardArea(
		0, 0,
		width, G.CARD_H,
		{card_limit = cards, type = 'title', highlight_limit = 0, collection = true}
	)
end

function SynthB.PJSK:collection_card(index, prototype)
	if not prototype.is then error("what are you doing where is the is function") end
	local card
	if prototype:is(SMODS.Edition) then
		card = Card(0, 0, G.CARD_W, G.CARD_H, G.P_CENTERS.empty, G.P_CENTERS.c_base)
		card:set_edition(prototype.key, true, true)
	elseif prototype:is(SMODS.Sticker) then
		card = Card(0, 0, G.CARD_W, G.CARD_H, G.P_CENTERS.empty, G.P_CENTERS.c_base)
		card:add_sticker(prototype.key, true)
	elseif prototype:is(SMODS.Seal) then
		card = Card(0, 0, G.CARD_W, G.CARD_H, G.P_CENTERS.empty, G.P_CENTERS.c_base)
		card:set_seal(prototype.key, true, true)
	elseif prototype:is(SMODS.Center) then
		card = Card(0, 0, G.CARD_W, G.CARD_H, G.P_CENTERS.empty, prototype)
	else
		card = Card(0, 0, G.CARD_W, G.CARD_W, G.P_CARDS.empty, G.P_CENTERS.c_base)
		if card.children.front then
			card.children.front:remove()
			card.children.front = nil
		end
		card.children.center:remove()
		local temp_tag = Tag(prototype.key, true)
		local _, sprite = temp_tag:generate_UI(G.CARD_W)
		card.children.center = sprite
		card.children.center.states.collide = card.states.collide
		card.children.center.states.drag = card.states.drag
		card.children.center.states.hover = card.states.hover
		card.children.center.states.click = card.states.click
		card.children.center:set_role({major = card, role_type = 'Glued', draw_major = card, align = "cmi"})
		function card:hover()
			self.ability_UIBox_table = temp_tag:get_uibox_table().ability_UIBox_table
			self.config.h_popup = G.UIDEF.card_h_popup(self)
			self.config.h_popup_config = self:align_h_popup()
			Node.hover(self)
		end
	end
	local card_hover_ref = card.hover
	function card:hover()
		SynthB.PJSK.force_ui = true
		card_hover_ref(self)
		SynthB.PJSK.force_ui = nil
	end
	return card
end

function SynthB.PJSK:content_box(pool)
	local w = 14
	local h = 10
	local padding = 0.2
	local scrollbar_w = 1.25
	local box_w = w - scrollbar_w - padding * 3
	local box_h = h - padding * 2
	local inner_w = box_w - 0.15 * 2
	
	local cards_per_row = math.floor(inner_w / G.CARD_W)
	local current_area = self:collection_area(inner_w, cards_per_row)

	local nodes = {n = G.UIT.ROOT, config = {colour = G.C.CLEAR, minw = box_w, align = "tl", padding = 0.15}, nodes = {
		{n = G.UIT.R, config = {align = "cm"}, nodes = {
			{n = G.UIT.O, config = {object = current_area}}
		}}
	}}
	for i, proto in ipairs(pool) do
		if #current_area.cards >= cards_per_row then
			current_area:align_cards()
			current_area:hard_set_cards()
			current_area = self:collection_area(inner_w, cards_per_row)
			nodes.nodes[#nodes.nodes + 1] = {n = G.UIT.R, config = {align = "cm"}, nodes = {
				{n = G.UIT.O, config = {object = current_area}}
			}}
		end
		current_area:emplace(self:collection_card(i, proto))
	end

	SynthB.PJSK.second_layer = true
	if self.UI.content_scrollbox then self.UI.content_scrollbox:remove() end
	self.UI.content_scrollbox = SMODS.UIScrollBox{
		content = {
			definition = nodes,
			config = {
				align = "cmi",
			}
		},
		overflow = {
			node_config = {
				maxh = box_h,
				r = 0.1,
			},
		},
	}
	local scrollbar = SMODS.GUI.scrollbar({
		h = box_h,
		w = 0.2,
		min = 0,
		max = 1,
		knob_colour = self.C.PHONE.BORDER,
		bg_colour = { 0, 0, 0, 0.15 },
		scroll_collision_obj = self.UI.content_scrollbox,
		knob_h = 0.6,
		scroll_mult = 3
	})
	SynthB.PJSK.second_layer = nil
	
	if self.UI.content_box then self.UI.content_box:remove() end
	self.UI.content_box = UIBox{
		definition = {n  = G.UIT.ROOT, config = {colour = self.C.CONTENT.GREY, r = true, minw = w, minh = h, padding = padding, align = "tr"}, nodes = {
			{n = G.UIT.C, config = {minw = box_w, minh = box_h}, nodes = {
				{n = G.UIT.O, config = {object = self.UI.content_scrollbox}}
			}},
			{n = G.UIT.C, config = {minw = scrollbar_w, align = "cm"}, nodes = {
				scrollbar
			}}
		}},
		config = {
			major = G.ROOM_ATTACH,
			align = "cmi",
			offset = {
				x = 2,
				y = 15
			}
		}
	}
	ease_value(self.UI.content_box.alignment.offset, "y", -15, nil, nil, true, 0.1)
end

function SynthB.PJSK:exit_songs()
	G.ARGS.push.sound_settings.music_volume = self.mem_volume or G.ARGS.push.sound_settings.music_volume
	G.ARGS.push.sound_settings.game_sounds_volume = self.mem_sfx or G.ARGS.push.sound_settings.game_sounds_volume
	self.mem_volume = nil
	self.mem_sfx = nil
	self.current_song = nil
	self.event = nil
	G.ARGS.push.type = "synthb_stop_clip"
	G.SOUND_MANAGER.channel:push(G.ARGS.push)
end

function SynthB.PJSK:play_song(key)
	if SynthB.key_songs[key].spoiler and SynthB.mod.config.spoilers[SynthB.key_songs[key].spoiler] then return end
	if not SMODS.NFS.getInfo(SynthB.mod.path .. "assets/sounds/clips/" .. key .. ".ogg") then return end
	G.ARGS.push.type = "synthb_stop_clip"
	self.mem_volume = self.mem_volume or G.ARGS.push.sound_settings.music_volume
	G.ARGS.push.sound_settings.music_volume = 0
	local cap = 0.5 * self.mem_sfx
	G.ARGS.push.sound_settings.game_sounds_volume = 0.01
	G.SOUND_MANAGER.channel:push(G.ARGS.push)
	play_sound("synthb_clip_" .. key)
	self.current_song = key
	local t = G.TIMERS.REAL
	local loop
	loop = Event{
		func = function()
			if SynthB.PJSK.event ~= loop then return true end
			if G.TIMERS.REAL - t >= 15 then
				G.ARGS.push.type = "synthb_stop_clip"
				G.ARGS.push.sound_settings.game_sounds_volume = 0.01
				G.SOUND_MANAGER.channel:push(G.ARGS.push)
				t = G.TIMERS.REAL
				play_sound("synthb_clip_" .. key)
			elseif G.TIMERS.REAL - t <= 0.5 then
				G.ARGS.push.sound_settings.game_sounds_volume = cap * ((G.TIMERS.REAL - t) * 2)
			elseif G.TIMERS.REAL - t >= 13 then
				G.ARGS.push.sound_settings.game_sounds_volume = cap * (1 - (G.TIMERS.REAL - t - 13) / 2)
			end
		end,
		blockable = false,
		blocking = false,
	}
	G.E_MANAGER:add_event(loop)
	self.event = loop
end

function G.FUNCS.synthb_pjsk_hover_song(e)
	if e.states.hover.is then
		if not e.config.ref_table.hovering then
			e.config.ref_table.hovering = true
			if e.config.ref_table.song.key ~= SynthB.PJSK.current_song then
				SynthB.PJSK:play_song(e.config.ref_table.song.key)
				e.config.minh = 3
			end
		end
	else
		e.config.ref_table.hovering = false
		e.config.minh = 1.75
	end
end

function G.FUNCS.synthb_pjsk_click_song(e)
	love.system.openURL(e.config.ref_table.song.link)
end

function SynthB.PJSK:song_list_entry(data)
	local h = 1.75
	local w = 1.75
	local img = SMODS.create_sprite(0, 0, w - 0.1, h - 0.1, data.atlas or "synthb_covers", data.pos)
	local nodes = {}
	if data.spoiler and SynthB.mod.config.spoilers[data.spoiler] then
		nodes = {{n = G.UIT.R, nodes = {{n = G.UIT.T, config = {scale = 0.5 * 1.2, colour = G.C.UI.TEXT_LIGHT, text = localize("k_synthb_spoiler")}}}}}
	else
---@diagnostic disable-next-line: cast-local-type
		nodes = localize{type = "name", set = (data.set or "Joker"), key = (data.prefix or "j_synthb_") .. data.key, fixed_scale = 1.2}
	end
	local nodes = name_from_rows(nodes)
	if nodes then
		if nodes.config then nodes.config.align = nil end
		for _, node in ipairs(nodes.nodes) do
			if node.config then node.config.align = nil end
		end
	end
	return {n = G.UIT.R, nodes = {
		{n = G.UIT.R, config = {minw = 8, minh = 0.1}},
		{n = G.UIT.R, config = {minw = 10, maxw = 10, minh = 0.05, colour = self.C.SONGS.BORDER, r = true, no_fill = true}}, 
		{n = G.UIT.R, config = {minw = 8, minh = 0.1}},
		{n = G.UIT.R, config = {button = "synthb_pjsk_click_song", func = "synthb_pjsk_hover_song", ref_table = {song = data, img = img}, minh = h, align = "cl"}, nodes = {
			{n = G.UIT.O, config = {object = SMODS.create_sprite(0, 0, w - 0.3, h - 0.3, "synthb_pjsk_type_icons", nil, {
				default_state = "state1",
				states = {
					state1 = {
						frame_order = {0}
					}
				},
			})}},
			{n = G.UIT.B, config = {w = 0.1, h = h}},
			{n = G.UIT.O, config = {object = img}},
			{n = G.UIT.B, config = {w = 0.1, h = h}},
			{n = G.UIT.C, nodes = {
				nodes
			}}
		}}
	}}
end

function SynthB.PJSK:song_list()
	
	local w = 16
	local h = 10
	local padding = 0.2
	local scrollbar_w = 1.25
	local box_w = w - scrollbar_w - padding * 3
	local box_h = h - padding * 2
	local inner_w = box_w - 0.15 * 2
	local inner_h = 1.75

	local nodes = {n = G.UIT.ROOT, config = {colour = G.C.CLEAR, minw = box_w, align = "tl", padding = 0.15}, nodes = {}}

	local songs = {}
	for _, song in ipairs(SynthB.songs) do
		if self.filter_voicebank then
			if song.voicebanks then
				for _, vb in ipairs(song.voicebanks) do
					if vb == self.filter_voicebank then
						songs[#songs + 1] = song
						goto continue
					end
				end
			else
				if SMODS.has_attribute(G.P_CENTERS[(song.prefix or "j_synthb_") .. song.key], self.filter_voicebank) then
					songs[#songs + 1] = song
					goto continue
				end
			end
		else
			songs[#songs + 1] = song
		end
		::continue::
	end

	for _, song in ipairs(songs) do
		nodes.nodes[#nodes.nodes + 1] = self:song_list_entry(song)
	end

	SynthB.PJSK.second_layer = true
	if self.UI.song_scrollbox then self.UI.song_scrollbox:remove() end
	self.UI.song_scrollbox = SMODS.UIScrollBox{
		content = {
			definition = nodes,
			config = {
				align = "cmi",
			}
		},
		overflow = {
			node_config = {
				maxh = box_h,
			},
		},
	}
	local scrollbar = SMODS.GUI.scrollbar({
		h = box_h,
		w = 0.2,
		min = 0,
		max = 1,
		knob_colour = self.C.PHONE.BORDER,
		bg_colour = { 0, 0, 0, 0.15 },
		scroll_collision_obj = self.UI.song_scrollbox,
		knob_h = 0.6,
		scroll_mult = 3
	})
	SynthB.PJSK.second_layer = nil
	
	local exists = self.UI.song_list
	if self.UI.song_list then self.UI.song_list:remove() end
	self.UI.song_list = UIBox{
		definition = {n  = G.UIT.ROOT, config = {colour = self.C.SONGS.TRANS_BLACK, r = true, minw = w, minh = h, padding = padding, align = "tr"}, nodes = {
			{n = G.UIT.C, config = {minw = scrollbar_w, align = "cm"}, nodes = {
				scrollbar
			}},
			{n = G.UIT.C, config = {minw = box_w, minh = box_h}, nodes = {
				{n = G.UIT.O, config = {object = self.UI.song_scrollbox}}
			}},
		}},
		config = {
			major = G.ROOM_ATTACH,
			align = "cmi",
			offset = {
				x = 1,
				y = not exists and 15 or 0
			}
		}
	}
	if not exists then ease_value(self.UI.song_list.alignment.offset, "y", -15, nil, nil, true, 0.1) end
end

function G.FUNCS.synthb_pjsk_filter_voicebank(e)
	for i, target in ipairs(e.parent.children) do
		if i % 2 == 1 then
			target.children[1].config.colour = G.C.CLEAR
			target.children[2].config.colour = G.C.CLEAR
			target.children[2].children[1].config.colour = SynthB.PJSK.C.CONFIG.TEXT_LIGHT
		end
	end
	if SynthB.PJSK.filter_voicebank == e.config.ref_table.type then
		SynthB.PJSK.filter_voicebank = nil
	else
		e.children[1].config.colour = SynthB.PJSK.C.CREDITS.SIDEBAR.CODERS
		e.children[2].config.colour = SynthB.PJSK.C.CREDITS.SIDEBAR.CODERS
		e.children[2].children[1].config.colour = SynthB.PJSK.C.CONFIG.TEXT_DARK
		SynthB.PJSK.filter_voicebank = e.config.ref_table.type
	end
	
	SynthB.PJSK.event = nil
	G.ARGS.push.type = "synthb_stop_clip"
	G.SOUND_MANAGER.channel:push(G.ARGS.push)
	SynthB.PJSK:song_list()
end

function SynthB.PJSK:song_sidebar()
	local w = 3.7
	local h = G.ROOM.T.h - 4
	
	local nodes = {}
	for voicebank in pairs(SynthB.Voicebanks) do
		nodes[#nodes + 1] = self:song_sidebar_tab(voicebank)
		nodes[#nodes + 1] = self:credits_sidebar_divider()
	end
	nodes[#nodes] = nil
	
	SynthB.PJSK.second_layer = true
	if self.UI.filter_scrollbox then self.UI.filter_scrollbox:remove() end
	self.UI.filter_scrollbox = SMODS.UIScrollBox{
		content = {
			definition = {n = G.UIT.ROOT, config = {colour = G.C.CLEAR}, nodes = nodes},
			config = {
				align = "cmi",
			}
		},
		overflow = {
			node_config = {
				maxh = h - 0.5,
			},
		},
	}
	local scrollbar = SMODS.GUI.scrollbar({
		h = h - 0.5,
		w = 0.2,
		min = 0,
		max = 1,
		knob_colour = self.C.PHONE.BORDER,
		bg_colour = { 0, 0, 0, 0.15 },
		scroll_collision_obj = self.UI.filter_scrollbox,
		knob_h = 0.6,
		scroll_mult = 3
	})
	SynthB.PJSK.second_layer = nil

	self.UI.song_sidebar = UIBox{
		definition = {n = G.UIT.ROOT, config = {colour = self.C.CREDITS.SIDEBAR.BACKGROUND, outline = 1, outline_colour = self.C.CREDITS.SIDEBAR.BORDER, align = "cr", minw = 15 + w, minh = h, r = true, res = 2}, nodes = {
			{n = G.UIT.C, config = {minw = w, minh = h, align = "cr"}, nodes = {
				{n = G.UIT.O, config = {object = self.UI.filter_scrollbox}}
			}},
			{n = G.UIT.C, config = {minw = 0.4, minh = h, align = "cr"}, nodes = {
				scrollbar
			}}
		}},
		config = {
			major = G.ROOM_ATTACH,
			align = "cl",
			offset = {
				x = -15 + w - 0.75,
				y = 0.5
			}
		}
	}

	ease_value(self.UI.song_sidebar.alignment.offset, "x", 15, nil, nil, true, 0.1)
end

function SynthB.PJSK:song_sidebar_tab(type)
	local label = type
	local h = (6.5 - 0.3 * 5) / 6
	local w = 3.7
	local dither_w = h / 83 * 46
	return {n = G.UIT.R, config = {id = type, align = "cr", button_dist = 0, button = "synthb_pjsk_filter_voicebank", ref_table = {type = type}}, nodes = {
		{n = G.UIT.B, config = {w = dither_w, h = h, colour = G.C.CLEAR, shader = 'synthb_pjsk_mask_ui', pjsk_mask = "synthb_pjsk_dither"}},
		{n = G.UIT.C, config = {minw = w, minh = h, align = "cm"}, nodes = {
			{n = G.UIT.T, config = {text = label, colour = self.C.CONFIG.TEXT_LIGHT, scale = 0.7}}
		}}
	}}
end

function SynthB.PJSK:gogogadget_ui_blocker()
	self.UI.ui_blocker = UIBox{
		definition = {n = G.UIT.ROOT, config = {colour = {0.8, 0.8, 0.8, 0.2}, minw = G.ROOM_ATTACH.T.w * 5, minh = G.ROOM_ATTACH.T.h *5}},
		config = {
			align = "cmi",
			major = G.ROOM_ATTACH,
		}
	}
end

function SynthB.PJSK:gogogadget_ui_blocker_2()
	self.UI.ui_blocker_2 = UIBox{
		definition = {n = G.UIT.ROOT, config = {minw = G.ROOM_ATTACH.T.w * 5, minh = G.ROOM_ATTACH.T.h *5, colour = G.C.CLEAR}},
		config = {
			align = "cmi",
			major = G.ROOM_ATTACH,
		}
	}
end

function G.FUNCS.synthb_pjsk_credits_inky_kofi(e)
	love.system.openURL("https://ko-fi.com/inkystanderson")
end

function SynthB.PJSK:remove()
	for _ , element in pairs(self.UI) do
		element:remove()
	end
	if self.STATE == self.STATES.SONGS then
		self:exit_songs()
	end
	self.active = false
end

function SynthB.PJSK:draw()
	if self.active then
		for _, v in pairs(G.I.PJSK) do
			if v ~= self.UI.back_button and v ~= self.UI.content_box then
				love.graphics.push("all")
				love.graphics.setShader()
				v:translate_container()
				v:draw()
				love.graphics.pop()
			end
		end
	end
	if self.UI.content_box then
		love.graphics.push("all")
		love.graphics.setShader()
		self.UI.content_box:translate_container()
		self.UI.content_box:draw()
		love.graphics.pop()
	end
	if self.UI.song_list then
		self.UI.song_scrollbox.content:update(G.REAL_DT)
		love.graphics.push("all")
		love.graphics.setShader()
		self.UI.song_list:translate_container()
		self.UI.song_list:draw()
		love.graphics.pop()
	end
	if self.UI.filter_scrollbox then
		love.graphics.push("all")
		love.graphics.setShader()
		self.UI.filter_scrollbox:translate_container()
		self.UI.filter_scrollbox:draw()
		love.graphics.pop()
	end
	if self.UI.back_button then
		love.graphics.push("all")
		love.graphics.setShader()
		self.UI.back_button:translate_container()
		self.UI.back_button:draw()
		love.graphics.pop()
	end
	for _, v in pairs(G.I.PJSK_POPUP) do
		love.graphics.push("all")
		love.graphics.setShader()
		v:translate_container()
		v:draw()
		love.graphics.pop()
	end
end

function SynthB.PJSK:draw_config()
	if self.active then
		for _, v in pairs(G.I.PJSK_CONFIG) do
			if v ~= self.UI.back_button then
				love.graphics.push("all")
				love.graphics.setShader()
				v:translate_container()
				v:draw()
				love.graphics.pop()
			end
		end
	end
end