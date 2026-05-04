--- Page 2


-- Fire Dance
SynthB.Joker{
	key = "fire_dance",
	pos = {x = 1, y = 0},
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			initial_loss = 1,
			gain = 1,
			scaling = 20,
			selected = 2,
			rank_gain = 1,
			cost = 20,
			heat = 10
		}
	},
	attributes = {"hand_size", "hands", "temperature", "song", "vocaloid song", "Miku", "Len", "KAITO", "MEIKO", "Deco*27", "Giga"},
	blueprint_compat = true,
	eternal_compat = true,
	demicolon_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "fire_dance")
		return {vars = {
			card.ability.extra.initial_loss,
			card.ability.extra.gain,
			card.ability.extra.scaling,
			card.ability.extra.selected,
			card.ability.extra.rank_gain,
			card.ability.extra.cost,
			-card.ability.extra.initial_loss + card.ability.extra.gain * math.floor(((G.GAME or {}).synthb_temp or 0) / card.ability.extra.scaling),
			card.ability.extra.heat
		}}
	end,
	add_to_deck = function(self, card, from_debuff)
		G.hand:change_size(-card.ability.extra.initial_loss + card.ability.extra.gain * math.floor((G.GAME.synthb_temp or 0) / card.ability.extra.scaling))
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(card.ability.extra.initial_loss - card.ability.extra.gain * math.floor((G.GAME.synthb_temp or 0) / card.ability.extra.scaling))
	end,
	calculate = function(self, card, context)
		if context.forcetrigger or (context.blind_defeated and context.main_eval and SMODS.last_hand_oneshot) then
			SynthB.ease_temp(card.ability.extra.heat)
		end
		if context.mod_temp and not context.blueprint then
			local new_val = math.floor(math.abs(context.new_temp) / card.ability.extra.scaling)
			local old_val = math.floor(math.abs(context.old_temp) / card.ability.extra.scaling)
			if new_val ~= old_val then
				G.hand:change_size((context.mod_temp > 0 and 1 or -1) * card.ability.extra.gain * (new_val - old_val))
			end
		end
	end,
	can_use = function(self, card)
		return (G.GAME.synthb_temp or 0) >= card.ability.extra.cost and G.hand and G.hand.highlighted and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.selected
	end,
	use = function(self, card)
		SynthB.ease_temp(-card.ability.extra.cost)
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.4,
			func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
				return true
			end
		}))
		for i = 1, #G.hand.highlighted do
			local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					G.hand.highlighted[i]:flip()
					play_sound('card1', percent)
					G.hand.highlighted[i]:juice_up(0.3, 0.3)
					return true
				end
			}))
		end
		delay(0.2)
		for i = 1, #G.hand.highlighted do
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					assert(SMODS.modify_rank(G.hand.highlighted[i], card.ability.extra.rank_gain))
					return true
				end
			}))
		end
		for i = 1, #G.hand.highlighted do
			local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					G.hand.highlighted[i]:flip()
					play_sound('tarot2', percent, 0.6)
					G.hand.highlighted[i]:juice_up(0.3, 0.3)
					return true
				end
			}))
		end
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.2,
			func = function()
				G.hand:unhighlight_all()
				return true
			end
		}))
		delay(0.5)
	end
}

-- KING
SynthB.Joker{
	key = "king",
	pos = {x = 0, y = 0},
	cost = 5,
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "king")
	end,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	attributes = {"modify_card", "rank", "position", "king", "song", "vocaloid song", "GUMI", "Kanaria"},
	calculate = function(self, card, context)
		if context.forcetrigger then
			if G.play and G.play.cards then
				if G.play.cards[1]:get_id() ~= 13 then 
					assert(SMODS.modify_rank(G.play.cards[1], 1))
					G.play.cards[1]:juice_up()
				end
				if G.play.cards[#G.play.cards]:get_id() ~= 13 then
					assert(SMODS.modify_rank(G.play.cards[#G.play.cards], 1))
					G.play.cards[#G.play.cards]:juice_up()
				end
			end
		end
		if context.before then
			if context.full_hand[1]:get_id() ~= 13 then 
				assert(SMODS.modify_rank(context.full_hand[1], 1))
				context.full_hand[1]:juice_up()
			end
			if context.full_hand[#context.full_hand]:get_id() ~= 13 then
				assert(SMODS.modify_rank(context.full_hand[#context.full_hand], 1))
				context.full_hand[#context.full_hand]:juice_up()
			end
		end
	end,
}

-- Birdbrain
SynthB.Joker{
	key = "birdbrain",
	pos = {x = 1, y = 0},
	cost = 6,
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "birdbrain")
	end,
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	attributes = {"hands", "passive", "song", "vocaloid song", "Teto", "Jamie Paige", "OK Glass"}
	-- see birdbrain.toml for implementation
}

-- Brain Rot
SynthB.Joker{
	key = "brainrot",
	pos = {x = 2, y = 0},
	rarity = 2,
	cost = 6,
	attributes = {"generation", "enhancements", "song", "vocaloid song", "Teto", "Tokyo Manaka"},
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_stone
		SynthB.song_info(info_queue, "brainrot")
	end,
	calculate = function(self, card, context)
		if context.remove_playing_cards then
			local copied = {}
			for _, _card in ipairs(context.removed) do
				G.playing_card = (G.playing_card and G.playing_card + 1) or 1
				local card_copied = copy_card(_card, nil, nil, G.playing_card)
				card_copied:set_ability("m_stone", nil, true)
				copied[#copied+1] = card_copied
				card_copied:add_to_deck()
				G.deck.config.card_limit = G.deck.config.card_limit + 1
				table.insert(G.playing_cards, card_copied)
				G.hand:emplace(card_copied)
				card_copied.states.visible = nil

				G.E_MANAGER:add_event(Event({
					func = function()
						card_copied:start_materialize()
						return true
					end
				}))
				return {
					message = localize('k_copied_ex'),
					colour = G.C.CHIPS,
					func = function() -- This is for timing purposes, it runs after the message
						G.E_MANAGER:add_event(Event({
							func = function()
								SMODS.calculate_context({ playing_card_added = true, cards = { copied } })
								return true
							end
						}))
					end
				}
			end
		end
	end,
}

-- Shrimp Fried Rice
SynthB.Joker{
	key = "shrimp_fried_rice",
	cost = 4,
	config = {
		extra = {
			chips = 39,
			loss = -1
		}
	},
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = false,
	demicolon_compat = true,
	attributes = {"food", "scaling", "chips", "song", "vocaloid song", "Jamie Paige", "Miku"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "shrimp_fried_rice")
		return {vars = {card.ability.extra.chips, -card.ability.extra.loss}}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			return {
				chips = card.ability.extra.chips
			}
		end
		if context.individual then
			if context.cardarea == G.play then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "chips",
					scalar_value = "loss",
					no_message = true
				})
				if card.ability.extra.chips <= 0 then
					SMODS.destroy_cards(card, nil, nil, true)
				end
			end
			if context.cardarea == "unscored" then
				return {
					chips = card.ability.extra.chips
				}
			end
		end
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{ text = "+" },
				{ ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" }
			},
			text_config = { colour = G.C.CHIPS },
			reminder_text = {
					{ text = "(unscored)" },
			},
			calc_function = function(card)
					local chips = 0
					local text, _, scoring_hand = JokerDisplay.evaluate_hand()
					if text ~= 'Unknown' then
							chips = chips + card.ability.extra.chips * (#JokerDisplay.current_hand - #scoring_hand)
					end
					card.joker_display_values.chips = chips
			end,
		}
	end
}

-- Disclose Flick
SynthB.Joker{
	key = "disclose_flick",
	pos = {x = 2, y = 0},
	rarity = 3,
	cost = 8,
	config = {
		extra = {
			chips_scale = 0.2,
			xchips = 1,
			mult_scale = 0.2,
			xmult = 1,
		},
		immutable = {
			tarot1 = "c_judgement",
			tarot2 = "c_justice"
		}
	},
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	attributes = {"xchips", "xmult", "scaling", "tarot", "song", "vocaloid song", "Teto", "Hiiragi Magnetite"},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS[card.ability.immutable.tarot1]
		info_queue[#info_queue+1] = G.P_CENTERS[card.ability.immutable.tarot2]
		SynthB.song_info(info_queue, "disclose_flick")
		return {vars = {
			card.ability.extra.chips_scale,
			localize{type = "name_text", set = "Tarot", key = card.ability.immutable.tarot1},
			card.ability.extra.mult_scale,
			localize{type = "name_text", set = "Tarot", key = card.ability.immutable.tarot2},
			card.ability.extra.xchips,
			card.ability.extra.xmult
		}}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "xchips",
				scalar_value = "chips_scale"
			})
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "xmult",
				scalar_value = "mult_scale"
			})
			return {
				xchips = card.ability.extra.xchips,
				xmult = card.ability.extra.xmult
			}
		end
		if context.using_consumeable and not context.blueprint then
			if context.consumeable.config.center.key == card.ability.immutable.tarot1 then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "xchips",
					scalar_value = "chips_scale"
				})
			end
			if context.consumeable.config.center.key == card.ability.immutable.tarot2 then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "xmult",
					scalar_value = "mult_scale"
				})
			end
		end
		if context.joker_main then
			return {
				xchips = card.ability.extra.xchips,
				xmult = card.ability.extra.xmult
			}
		end
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{
					border_nodes = {
						{ text = "X" },
						{ ref_table = "card.ability.extra", ref_value = "xchips", retrigger_type = "exp" }
					},
					border_colour = G.C.CHIPS
				},
				{text = " "},
				{
					border_nodes = {
						{ text = "X" },
						{ ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" }
					},
				}
			}
		}
	end
}

-- Copycat
SynthB.Joker{
	key = "copycat",
	pos = {x = 2, y = 0},
	rarity = 3,
	cost = 9,
	config = {
		immutable = {
			suit = "Hearts"
		}
	},
	attributes = {"modify_card", "suit", "song", "vocaloid song", "GUMI", "CircusP"},
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	demicolon_compat = true,
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "copycat")
		return {vars = {localize(card.ability.immutable.suit, "suits_singular")}}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			if G.hand and G.hand.cards then
				for _i, _card in ipairs(G.hand.cards) do
					if _card:is_suit(card.ability.immutable.suit) then
						local index = _i - 1
						if index ~= 0 then
							local target = G.hand.cards[index]
							G.E_MANAGER:add_event(Event{
								trigger = "after",
								delay = 0.15,
								func = function()
									target:flip()
									play_sound('card1')
									target:juice_up(0.3, 0.3)
									return true
								end
							})
							delay(0.2)
							local other_card = _card
							G.E_MANAGER:add_event(Event{
								trigger = "after",
								delay = 0.1,
								func = function()
									copy_card(other_card, target)
									return true
								end
							})
							G.E_MANAGER:add_event(Event{
								trigger = "after",
								delay = 0.15,
								func = function()
									G.hand.cards[index]:flip()
									play_sound('tarot2', nil, 0.6)
									G.hand.cards[index]:juice_up(0.3, 0.3)
									return true
								end
							})
						end
					end
				end
			end
		end
		if context.end_of_round and context.individual and context.cardarea == G.hand and not context.blueprint then
			if context.other_card:is_suit(card.ability.immutable.suit) then
				local index = 0
				for i, _card in ipairs(G.hand.cards) do
					if _card == context.other_card then
						index = i - 1
						break
					end
				end
				if index ~= 0 then
					local target = G.hand.cards[index]
					G.E_MANAGER:add_event(Event{
						trigger = "after",
						delay = 0.15,
						func = function()
							target:flip()
							play_sound('card1')
							target:juice_up(0.3, 0.3)
							return true
						end
					})
					delay(0.2)
					local other_card = context.other_card
					G.E_MANAGER:add_event(Event{
						trigger = "after",
						delay = 0.1,
						func = function()
							copy_card(other_card, target)
							return true
						end
					})
					G.E_MANAGER:add_event(Event{
						trigger = "after",
						delay = 0.15,
						func = function()
							G.hand.cards[index]:flip()
							play_sound('tarot2', nil, 0.6)
							G.hand.cards[index]:juice_up(0.3, 0.3)
							return true
						end
					})
				end
			end
		end
		if context.round_eval and not context.blueprint then
			local suits = {}
			for key, _ in pairs(SMODS.Suits) do
				if key ~= card.ability.immutable.suit then
					suits[#suits+1] = key
				end
			end
			card.ability.immutable.suit = pseudorandom_element(suits, "synthb_hontono")
		end
	end,
	set_ability = function (self, card, initial, delay_sprites)
		local suits = {}
		for key, _ in pairs(SMODS.Suits) do
			suits[#suits+1] = key
		end
		card.ability.immutable.suit = pseudorandom_element(suits, "synthb_hontono_initial")
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			reminder_text = {
				{ text = "(" },
				{ ref_table = "card.joker_display_values", ref_value = "suit", colour = G.C.ORANGE },
				{ text = ")" },
			},
			calc_function = function(card)
				card.joker_display_values.suit = localize(card.ability.immutable.suit, "suits_plural")
			end,
			style_function = function(card, text, reminder_text, extra)
				if reminder_text and reminder_text.children[2] then
					reminder_text.children[2].config.colour = lighten(G.C.SUITS[card.ability.immutable.suit], 0.35)
				end
			end
		}
	end
}

-- kyu-kurarin
SynthB.Joker{
	key = "kyu_kurarin",
	cost = 5,
	config = {
		extra = {
			scaling = 7,
			chips = 0
		}
	},
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	attributes = {"chips", "scaling", "song", "vocaloid song", "KAFU", "Iyowa"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "kyu_kurarin")
		return {vars = {card.ability.extra.scaling, card.ability.extra.chips}}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "chips",
				scalar_value = "scaling",
				no_message = true
			})
			return {
				chips = card.ability.extra.chips
			}
		end
		if context.remove_playing_cards and not context.blueprint then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "chips",
				scalar_table = {card.ability.extra.scaling * #context.removed},
---@diagnostic disable-next-line: assign-type-mismatch
				scalar_value = 1,
				no_message = true
			})
		end
		if context.joker_main then
			return {
				chips = card.ability.extra.chips
			}
		end
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{ text = "+" },
				{ ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" },
			},
			text_config = { colour = G.C.CHIPS },
		}
	end
}

-- Medicine
SynthB.Joker{
	key = "medicine",
	cost = 5,
	blueprint_compat = true,
	demicolon_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = {"face", "mult", "song", "vocaloid song", "Sasuke Haraguchi", "Teto"},
	config = {
		extra = {
			mult = 4
		}
	},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "medicine")
		SynthB.card_credits(info_queue, "idea_credits", {"Ice"})
		return {vars = {card.ability.extra.mult}}
	end,
	calculate = function(self, card, context)
		if context.modify_scoring_hand and not context.blueprint then
			if SynthB.is_face(context.other_card) then
				return {
					add_to_hand = true
				}
			end
		end
		if context.individual and context.cardarea == G.play then
			if SynthB.is_face(context.other_card) then
				return {
					mult = card.ability.extra.mult
				}
			end
		end
		if context.forcetrigger then
			return {
				mult = card.ability.extra.mult
			}
		end
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{ text = "+" },
				{ ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
			},
			text_config = { colour = G.C.MULT },
			reminder_text = {
				{ text = "(" },
				{ ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.ORANGE },
				{ text = ")" },
			},
			calc_function = function(card)
				local mult = 0
				local text, _, scoring_hand = JokerDisplay.evaluate_hand()
				if text ~= 'Unknown' then
					for _, scoring_card in pairs(scoring_hand) do
						if SynthB.is_face(scoring_card) then
							mult = mult + card.ability.extra.mult * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
						end
					end
				end
				card.joker_display_values.mult = mult
				card.joker_display_values.localized_text = localize("k_face_cards")
			end
		}
	end
}

-- Internet is Mine
SynthB.Joker{
	key = "internet_is_mine",
	cost = 4,
	config = {
		extra = {
			xmult = 2
		},
		immutable = {
			rank = 12
		}
	},
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	demicolon_compat = true,
	attributes = {"xmult", "queen", "rank", "song", "vocaloid song", "Miku", "Treb", "aleon", "Nocticola"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "internet_is_mine")
		return {vars = {card.ability.extra.xmult}}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			return {
				xmult = card.ability.extra.xmult
			}
		end
		if context.individual and not context.end_of_round and context.cardarea == "unscored" then
			if context.other_card:get_id() == card.ability.immutable.rank then
				return {
					xmult = card.ability.extra.xmult
				}
			end
		end
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{
					border_nodes = {
						{ text = "X" },
						{ ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "mult" }
					}
				}
			},
			reminder_text = {
					{ text = "(unscored Queens)" },
			},
			calc_function = function(card)
					local xmult = 1
					local text, _, scoring_hand = JokerDisplay.evaluate_hand()
					if text ~= 'Unknown' then
						for _, _card in ipairs(JokerDisplay.current_hand) do
							if _card:get_id() == card.ability.immutable.rank then
								for _, __card in ipairs(scoring_hand) do
									if _card == __card then
										goto continue
									end
								end
								xmult = xmult * card.ability.extra.xmult
							end
							::continue::
						end
					end
					card.joker_display_values.xmult = xmult
			end,
		}
	end
}

-- Glass Girl
SynthB.Joker{
	key = "glass_girl",
	pos = {x=1,y=0},
	rarity = 2,
	cost = 7,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	attributes = {"modify_card", "song", "Rei", "Jamie Paige", "eggtan"},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_steel
		info_queue[#info_queue+1] = G.P_CENTERS.m_glass
		SynthB.song_info(info_queue, "glass_girl")
	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			if G.hand and G.hand.cards then
				for _, _card in ipairs(G.hand.cards) do
					_card:set_ability("m_steel", nil, true)
					_card:juice_up()
				end
			end
		end
		if context.remove_playing_cards and not context.blueprint then
			if context.scoring_hand and G.hand and G.play then
				for i = 2, #context.removed do
					if context.removed[i].glass_trigger then
						local index = 0
						for _i, _card in ipairs(G.play.cards) do
							if _card == context.removed[i] then
								index = _i - 1
								break
							end
						end
						if index ~= 0 then
							if G.play.cards[index].glass_trigger then
								if G.hand and G.hand.cards then
									for _, _card in ipairs(G.hand.cards) do
										_card:set_ability("m_steel", nil, true)
										G.E_MANAGER:add_event(Event{
											func = function ()
												_card:juice_up()
												return true
											end
										})
									end
								end
								return {
									message = "!!!",
									colour = G.C.ORANGE
								}
							end
						end
					end
				end
			end
		end
	end,
}

-- Monitoring
SynthB.Joker{
	key = "monitoring",
	pos = {x = 2, y = 0},
	rarity = 3,
	cost = 8,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = false,
	attributes = {"hands", "song", "vocaloid song", "Deco*27", "Miku"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "monitoring")
	end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			if G.GAME.current_round.hands_played == 0 then
				local marked_card
				for _, _card in ipairs(context.scoring_hand) do
					if _card.ability.synthb_monitored then
						marked_card = _card
						break
					end
				end
				G.GAME.synthb_monitored = false
				for _, _card in ipairs(G.playing_cards) do
					if _card ~= marked_card then
						_card.ability.synthb_monitored = nil
					else
						G.GAME.synthb_monitored = true
					end
				end
			end
			if #context.full_hand == 1 then
				context.full_hand[1].ability.synthb_monitored = true
				return {
					message = 'MWAH!',
					colour = G.C.BLUE
				}
			end
		end
	end,
	remove_from_deck = function (self, card, from_debuff)
		if not from_debuff then
			G.GAME.synthb_monitored = false
			for _, _card in ipairs(G.playing_cards) do
				_card.ability.synthb_monitored = nil
			end
		end
	end
}

-- Six Trillion Years and Overnight Story
SynthB.Joker{
	key = "six_trillion",
	pos = {x = 1, y = 0},
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			chips = 0,
			mult = 0
		}
	},
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	attributes = {"destroy_card", "hands", "scaling", "chips", "mult", "song", "vocaloid song", "IA", "kemu"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "six_trillion")
		return {vars = {card.ability.extra.chips, card.ability.extra.mult}}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger or context.joker_main then
			return {
				chips = card.ability.extra.chips,
				mult = card.ability.extra.mult
			}
		end
		if context.destroy_card and G.GAME.current_round.hands_left == 0 and (context.cardarea == G.play or context.cardarea == "unscored") and not context.blueprint then
			card.ability.extra.chips = card.ability.extra.chips + (context.destroy_card:get_chip_bonus() + ((context.destroy_card.edition or {}).chips or 0)) / 3
			card.ability.extra.mult = card.ability.extra.mult + (context.destroy_card:get_chip_mult() + ((context.destroy_card.edition or {}).mult or 0)) / 3
			return {
				remove = true
			}
		end
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{ text = "+", colour = G.C.CHIPS },
				{ ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult", colour = G.C.CHIPS },
				{text = " "},
				{ text = "+", colour = G.C.MULT },
				{ ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult", colour = G.C.MULT }
			}
		}
	end
}

-- Miku
SynthB.Joker{
	key = "miku",
	cost = 3,
	config = {
		card_limit = 1,
		extra = {
			chips = 3.9
		}
	},
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	attributes = {"chips", "song", "vocaloid song", "Miku", "Anamanaguchi"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "miku")
		return {vars = {card.ability.extra.chips}}
	end,
	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
			return {
				chips = card.ability.extra.chips
			}
		end
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{ text = "+" },
				{ ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
			},
			text_config = { colour = G.C.CHIPS }
		}
	end,
	in_pool = function (self, args)
		return true, {allow_duplicates = true}
	end
}

-- Matryoshka
SynthB.Joker{
	key = "matryoshka",
	pos = {x = 1, y = 0},
	rarity = 2,
	cost = 4,
	config = {
		extra = {
			num = 1,
			dem = 4,
			gain = 1
		}
	},
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	attributes = {"chance", "hands", "song", "vocaloid song", "Miku", "GUMI", "Hachi"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "matryoshka")
		local num, dem = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.dem, "synthb_matryoshka")
		num = math.min(num, dem - 1)
		return {vars = {num, dem, card.ability.extra.gain}}
	end,
	calculate = function(self, card, context)
		if context.before or context.forcetrigger then
			local flag = context.forcetrigger or false
			local num, dem = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.dem, "synthb_matryoshka")
			num = math.min(num, dem - 1)
			if flag or (#context.full_hand == 4 and SMODS.pseudorandom_probability(card, "synthb_matryoshka", num, dem, nil, true)) then
				ease_hands_played(card.ability.extra.gain)
			end
		end
	end,
}
