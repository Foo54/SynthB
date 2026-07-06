SynthB.Credits.Contributor{
	key = "credits_foo54",
	atlas = "credits_foo54",
	name = "Foo54",
	click = function (self)
		play_sound("synthb_teto")
	end,
	custom_ui = function (self)
		G.synthb_credits_background_box = UIBox{
			definition = {n = G.UIT.ROOT, config = {colour = G.C.CLEAR}, nodes = {
				{n = G.UIT.O, config = {object = SMODS.create_sprite(0, 0, 15, 7.5, "synthb_credits_foo_background", {x = 0, y = 0})}}
			}},
			config = {}
		}
		local H_TO_W = G.CARD_W / G.CARD_H
		local cardarea = self:create_area(6 * H_TO_W, 6)
		
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

		local card = self:create_sprite(cardarea, {scale = {w = 6 * H_TO_W / G.CARD_W, h = 6 / G.CARD_H}})
		G.synthb_credits_cardarea_box = UIBox{
			definition = {n = G.UIT.ROOT, config = {colour = G.C.CLEAR}, nodes = {
				{n = G.UIT.O, config = {object = cardarea}}
			}},
			config = {
				major = G.synthb_credits_background_box,
				bond = "Strong",
				align = "bli",
				offset = {x = 1, y = 0},
				instance_type = "POPUP"
			}
		}

		G.synthb_credits_main_info_box = UIBox{
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
							{n = G.UIT.T, config = {text = "Foo54", scale = 1.2, colour = G.C.UI.TEXT_LIGHT}}
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
							{n = G.UIT.C, config = {align = "cl"}, nodes = {
								{n = G.UIT.T, config = {text = "Lead Developer", scale = 0.5, colour = G.C.UI.TEXT_LIGHT}}
							}}
						}},
						{n = G.UIT.R, nodes = {
							{n = G.UIT.B, config = {w = 6, h = 0.1}}
						}},
					}},
				}}
			}},
			config = {
				major = G.synthb_credits_background_box,
				bond = "Strong",
				align = "bli",
				offset = {x = 0.2, y = -0.2},
				instance_type = "POPUP"
			}
		}
		
		G.synthb_credits_book_box = UIBox{
			definition = {n = G.UIT.ROOT, config = {func = "synthb_align_book_box", minh = 7.1, minw = 7.1, colour = SynthB.custom_colors.credits.foo.BOOK, emboss = 0.2, r = 0.2}, nodes = {
				{n = G.UIT.C, nodes = {
					{n = G.UIT.B, config = {colour = SynthB.custom_colors.credits.foo.BOOK_2, w = 0.2, h = 7.1}}
				}},
				{n = G.UIT.C, nodes = {
					{n = G.UIT.B, config = {colour = SynthB.custom_colors.credits.foo.BOOK_3, w = 0.1, h = 7.1}}
				}},
				{n = G.UIT.C, nodes = {
					{n = G.UIT.B, config = {w = 0.5, h = 7.1}}
				}},
				{n = G.UIT.C, config = {align = "tm"}, nodes = {
					{n = G.UIT.R, config = {align = "cr"}, nodes = {
						{n = G.UIT.C, nodes = {
							{n = G.UIT.B, config = {w = 0.5, h = 1.5}}
						}},
						{n = G.UIT.C, nodes = {
							{n = G.UIT.T, config = {text = "CREDITS", scale = 1.5, colour = SynthB.custom_colors.credits.foo.TEXT}}
						}}
					}},
					{n = G.UIT.R, config = {align = "cm"}, nodes = {
						{n = G.UIT.C, nodes = {
							{n = G.UIT.R, config = {minw = 2.5, maxw = 2.5, minh = 1, maxh = 1, padding = 0.2, r = 0.2, colour = SynthB.custom_colors.credits.foo.BUTTON, emboss = 0.1, align = "cm", button = "synthb_credits_foo_1"}, nodes = {
								{n = G.UIT.C, config = {align = "cm"}, nodes = {
									{n = G.UIT.R, config = {align = "cm"}, nodes = {
										{n = G.UIT.T, config = {text = "About & More", colour = SynthB.custom_colors.credits.foo.BUTTON_TEXT, scale = 0.5}}
									}},
									{n = G.UIT.R, nodes = {
										{n = G.UIT.B, config = {colour = SynthB.custom_colors.credits.foo.BUTTON_TEXT, w = 2.4, h = 0.05}}
									}}
								}}
							}}
						}},
						{n = G.UIT.C, nodes = {
							{n = G.UIT.B, config = {w = 0.3, h = 0.3}}
						}},
						{n = G.UIT.C, nodes = {
							{n = G.UIT.R, config = {minw = 2.5, maxw = 2.5, minh = 1, maxh = 1, padding = 0.2, r = 0.2, colour = SynthB.custom_colors.credits.foo.BUTTON, emboss = 0.1, align = "cm", button = "synthb_credits_foo_2"}, nodes = {
								{n = G.UIT.C, config = {align = "cm"}, nodes = {
									{n = G.UIT.R, config = {align = "cm"}, nodes = {
										{n = G.UIT.T, config = {text = "Special Thanks", colour = SynthB.custom_colors.credits.foo.BUTTON_TEXT, scale = 0.5}}
									}},
									{n = G.UIT.R, nodes = {
										{n = G.UIT.B, config = {colour = SynthB.custom_colors.credits.foo.BUTTON_TEXT, w = 2.4, h = 0.05}}
									}}
								}}
							}}
						}}
					}},
					{n = G.UIT.R, nodes = {
						{n = G.UIT.B, config = {w = 0.5, h = 0.3}}
					}},
					{n = G.UIT.R, config = {align = "cm"}, nodes = {
						{n = G.UIT.C, config = {align = "cm", minw = 0.5}, nodes = {
							{n = G.UIT.T, config = {text = "Go Go Gadget Mizuki", vert = true, scale = 0.5, colour = SynthB.custom_colors.credits.foo.TEXT}}
						}},
						{n = G.UIT.C, config = {align = "cm"}, nodes = {
							{n = G.UIT.O, config = {object = SMODS.create_sprite(0, 0, 3, 4, "synthb_credits_foo_mizuki", {x = 0, y = 0})}}
						}},
						{n = G.UIT.C, config = {align = "cm", minw = 0.5}, nodes = {
							{n = G.UIT.B, config = {w = 0.5, h = 0.5}}
						}}
					}}
				}},
			}},
			config = {
				major = G.synthb_credits_background_box,
				bond = "Strong",
				align = "bri",
				r_bond = "Weak",
				offset = {x = -0.2, y = -0.3},
				instance_type = "POPUP"
			}
		}
		
		G.synthb_credits_backarrow_box = UIBox{
			definition = {n = G.UIT.ROOT, config = {colour = G.C.CLEAR}, nodes = {
				{n = G.UIT.R, config = {button = "synthb_credits_foo_back", button_dist = 0.1}, nodes = {
					{n = G.UIT.T, config = {text = "< Back", scale = 0.5, colour = G.C.BLACK}}
				}}
			}},
			config = {
				major = G.synthb_credits_background_box,
				bond = "Strong",
				align = "tli",
				offset = {x = 0.3, y = 0.05},
				instance_type = "POPUP"
			}
		}

		G.synthb_credits_contributions_box = UIBox{
			definition = {n = G.UIT.ROOT, config = {colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_BORDER, minw = 14, minh = 6.4, r = 0.1, padding = 0.2}, nodes = {
				{n = G.UIT.C, config = {colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_INSIDE, minw = 13.5, minh = 6, padding = 0.5}, nodes = {
					{n = G.UIT.R, config = {colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_FURTHER_INSIDE, minw = 12.5, minh = 5}, nodes = {
						{n = G.UIT.C, config = {minw = 6, maxw = 6, minh = 5, maxh = 5, padding = 0.2}, nodes = {
							{n = G.UIT.R, nodes = {
								{n = G.UIT.C, nodes = {
									{n = G.UIT.R, nodes = {
										{n = G.UIT.T, config = {text = "About", scale = 0.75, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_TAB_TEXT}}
									}},
									{n = G.UIT.R, nodes = {
										{n = G.UIT.B, config = {h = 0.05, w = 4, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_EVEN_FURTHER_INSIDE}}
									}},
									{n = G.UIT.R, nodes = {
										{n = G.UIT.T, config = {text = "Hi! I'm the main developer of the mod.", scale = 0.4, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_TAB_TEXT}}
									}},
									{n = G.UIT.R, nodes = {
										{n = G.UIT.T, config = {text = "I don't really know what", scale = 0.4, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_TAB_TEXT}}
									}},
									{n = G.UIT.R, nodes = {
										{n = G.UIT.T, config = {text = "to put here for now...", scale = 0.4, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_TAB_TEXT}}
									}},
									{n = G.UIT.R, nodes = {
										{n = G.UIT.T, config = {text = "Have another Mizuki ig", scale = 0.4, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_TAB_TEXT}}
									}},
									{n = G.UIT.R, nodes = {
										{n = G.UIT.O, config = {object = SMODS.create_sprite(0, 0, 1.5, 2, "synthb_credits_foo_mizuki", {x = 0, y = 0})}}
									}}
								}}
							}}
						}},
						{n = G.UIT.C, nodes = {
							{n = G.UIT.B, config = {colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_SPINE_OUTER, h = 5, w = 0.15}}
						}},
						{n = G.UIT.C, nodes = {
							{n = G.UIT.B, config = {colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_SPINE_INNER, h = 5, w = 0.2}}
						}},
						{n = G.UIT.C, nodes = {
							{n = G.UIT.B, config = {colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_SPINE_OUTER, h = 5, w = 0.15}}
						}},
						{n = G.UIT.C, config = {minw = 6, maxw = 6, minh = 5, maxh = 5, padding = 0.2}, nodes = {
							{n = G.UIT.R, nodes = {
								{n = G.UIT.C, nodes = {
									{n = G.UIT.R, nodes = {
										{n = G.UIT.T, config = {text = "Contributions", scale = 0.75, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_TAB_TEXT}}
									}},
									{n = G.UIT.R, nodes = {
										{n = G.UIT.B, config = {h = 0.05, w = 4, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_EVEN_FURTHER_INSIDE}}
									}},
									{n = G.UIT.R, nodes = {
										{n = G.UIT.T, config = {text = "Nearly all the programming", scale = 0.4, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_TAB_TEXT}}
									}},
									{n = G.UIT.R, nodes = {
										{n = G.UIT.T, config = {text = "All the UI work", scale = 0.4, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_TAB_TEXT}}
									}},
									{n = G.UIT.R, nodes = {
										{n = G.UIT.T, config = {text = "Concepting and Ideas", scale = 0.4, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_TAB_TEXT}}
									}},
									{n = G.UIT.R, nodes = {
										{n = G.UIT.T, config = {text = "A few pieces of art", scale = 0.4, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_TAB_TEXT}}
									}},
									{n = G.UIT.R, config = {maxw = 6}, nodes = {
										{n = G.UIT.T, config = {text = "Basicly everything that isn't attributed to someone else", scale = 0.4, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_TAB_TEXT}}
									}},
								}}
							}}
						}},
					}}
				}}
			}},
			config = {
				major = G.synthb_credits_background_box,
				bond = "Strong",
				align = "cmi",
				instance_type = "POPUP"
			}
		}
		G.synthb_credits_contributions_box.states.visible = false
		G.synthb_credits_backarrow_box.states.visible = false

		

		G.synthb_credits_special_thanks_box = UIBox{
			definition = {n = G.UIT.ROOT, config = {colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_BORDER, minw = 14, minh = 6.4, r = 0.1, padding = 0.2}, nodes = {
				{n = G.UIT.C, config = {colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_INSIDE, minw = 13.5, minh = 6, padding = 0.5}, nodes = {
					{n = G.UIT.R, config = {colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_FURTHER_INSIDE, minw = 12.5, minh = 5}, nodes = {
						{n = G.UIT.C, config = {minw = 6, maxw = 6, minh = 5, maxh = 5, padding = 0.2}, nodes = {
							{n = G.UIT.R, nodes = {
								{n = G.UIT.C, nodes = {
									{n = G.UIT.R, nodes = {
										{n = G.UIT.T, config = {text = "Special Thanks", scale = 0.75, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_TAB_TEXT}}
									}},
									{n = G.UIT.R, nodes = {
										{n = G.UIT.B, config = {h = 0.05, w = 4, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_EVEN_FURTHER_INSIDE}}
									}},
									{n = G.UIT.R, config = {maxw = 6}, nodes = {
										{n = G.UIT.T, config = {text = "Placeholder textures - ThunderEdge", scale = 0.4, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_TAB_TEXT}}
									}},
									{n = G.UIT.R, config = {maxw = 6}, nodes = {
										{n = G.UIT.T, config = {text = "UI Help - SleepyG11", scale = 0.4, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_TAB_TEXT}}
									}},
									{n = G.UIT.R, config = {maxw = 6}, nodes = {
										{n = G.UIT.T, config = {text = "Mod Name - mf", scale = 0.4, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_TAB_TEXT}}
									}},
									{n = G.UIT.R, config = {maxw = 6}, nodes = {
										{n = G.UIT.T, config = {text = "Mod Icon - LasagnaFelidae", scale = 0.4, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_TAB_TEXT}}
									}},
									{n = G.UIT.R, nodes = {
										{n = G.UIT.O, config = {object = SMODS.create_sprite(0, 0, 5, 5 * 88 / 518, "synthb_revo", {x = 0, y = 0})}}
									}}
								}}
							}}
						}},
						{n = G.UIT.C, nodes = {
							{n = G.UIT.B, config = {colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_SPINE_OUTER, h = 5, w = 0.15}}
						}},
						{n = G.UIT.C, nodes = {
							{n = G.UIT.B, config = {colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_SPINE_INNER, h = 5, w = 0.2}}
						}},
						{n = G.UIT.C, nodes = {
							{n = G.UIT.B, config = {colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_SPINE_OUTER, h = 5, w = 0.15}}
						}},
						{n = G.UIT.C, config = {minw = 6, maxw = 6, minh = 5, maxh = 5, padding = 0.2}, nodes = {
							{n = G.UIT.R, nodes = {
								{n = G.UIT.C, nodes = {
									{n = G.UIT.R, nodes = {
										{n = G.UIT.T, config = {text = "Special Thanks", scale = 0.75, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_TAB_TEXT}}
									}},
									{n = G.UIT.R, config = {maxw = 6}, nodes = {
										{n = G.UIT.B, config = {h = 0.05, w = 4, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_EVEN_FURTHER_INSIDE}}
									}},
									{n = G.UIT.R, config = {maxw = 6}, nodes = {
										{n = G.UIT.T, config = {text = "Potato Patch Discord", scale = 0.4, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_TAB_TEXT}}
									}},
									{n = G.UIT.R, config = {maxw = 6}, nodes = {
										{n = G.UIT.T, config = {text = "Balatro Discord", scale = 0.4, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_TAB_TEXT}}
									}},
									{n = G.UIT.R, config = {maxw = 6}, nodes = {
										{n = G.UIT.T, config = {text = "SMODS Wiki", scale = 0.4, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_TAB_TEXT}}
									}},
									{n = G.UIT.R, config = {maxw = 6}, nodes = {
										{n = G.UIT.T, config = {text = "VanillaRemade", scale = 0.4, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_TAB_TEXT}}
									}},
									{n = G.UIT.R, config = {maxw = 6}, nodes = {
										{n = G.UIT.T, config = {text = "Vocaloid Lyrics Wiki", scale = 0.4, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_TAB_TEXT}}
									}},
									{n = G.UIT.R, config = {maxw = 6}, nodes = {
										{n = G.UIT.T, config = {text = "chigago", scale = 0.4, colour = SynthB.custom_colors.credits.foo.OPEN_BOOK_TAB_TEXT}}
									}}
								}}
							}}
						}},
					}}
				}}
			}},
			config = {
				major = G.synthb_credits_background_box,
				bond = "Strong",
				align = "cmi",
				instance_type = "POPUP"
			}
		}
		G.synthb_credits_special_thanks_box.states.visible = false

		SynthB.link_UIBox(
			G.synthb_credits_background_box,
			G.synthb_credits_cardarea_box,
			G.synthb_credits_main_info_box,
			G.synthb_credits_book_box,
			G.synthb_credits_contributions_box,
			G.synthb_credits_backarrow_box,
			G.synthb_credits_special_thanks_box
		)
		return {n = G.UIT.ROOT, config = {colour = G.C.CLEAR}, nodes = {
			{n = G.UIT.O, config = {object = G.synthb_credits_background_box}}
		}}
	end,
}

function G.FUNCS.synthb_align_book_box (e)
	G.synthb_credits_book_box.T.r = -0.02
	if SynthB.mod.config.mizuki_zoomies then
		G.synthb_credits_book_box.T.r = 2 * math.pi * math.sin(math.sin(G.TIMERS.REAL) + 2 * math.sin(G.TIMERS.REAL * 2) + 0.5 * math.sin(G.TIMERS.REAL * 8))
	end
end

function G.FUNCS.synthb_credits_foo_hide_ui ()
	G.synthb_credits_cardarea_box.states.visible = false
	G.synthb_credits_main_info_box.states.visible = false
	G.synthb_credits_book_box.states.visible = false
end

function G.FUNCS.synthb_credits_foo_show_ui ()
	G.synthb_credits_cardarea_box.states.visible = true
	G.synthb_credits_main_info_box.states.visible = true
	G.synthb_credits_book_box.states.visible = true
end

function G.FUNCS.synthb_credits_foo_back (e)
	G.FUNCS.synthb_credits_foo_show_ui()
	G.synthb_credits_contributions_box.states.visible = false
	G.synthb_credits_special_thanks_box.states.visible = false
	G.synthb_credits_backarrow_box.states.visible = false
end

function G.FUNCS.synthb_credits_foo_1 (e)
	G.FUNCS.synthb_credits_foo_hide_ui()
	G.synthb_credits_contributions_box.states.visible = true
	G.synthb_credits_backarrow_box.states.visible = true
end
function G.FUNCS.synthb_credits_foo_2 (e)
	G.FUNCS.synthb_credits_foo_hide_ui()
	G.synthb_credits_special_thanks_box.states.visible = true
	G.synthb_credits_backarrow_box.states.visible = true
end




