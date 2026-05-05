--- Page 1


-- I'm Talking to You!!!
SynthB.Joker{
	key = "antani_itten_no",
	pos = {x = 0, y = 0},
	attributes = {"mult", "suit", "clubs", "Teto", "song", "Pinata", "vocaloid song"},
	config = {
		extra = {
			suit = "Clubs",
			mult = 6
		}
	},
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	cost = 4,
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "antani_itten_no")
		return {vars = {card.ability.extra.suit, card.ability.extra.mult}}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.hand and not context.end_of_round then
			if context.other_card:is_suit(card.ability.extra.suit) then
				return {
					mult = card.ability.extra.mult
				}
			end
		end
		if context.forcetrigger then
			if G.hand and G.hand.cards then
				local out = 0
				for _, _card in ipairs(G.hand.cards) do
					if _card:is_suit(card.ability.extra.suit) then
						out = out + card.ability.extra.mult
					end
				end
				return {
					mult = out
				}
			end
		end
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{ text = "+" },
				{ ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" },
			},
			text_config = { colour = G.C.MULT },
			calc_function = function(card)
				local playing_hand = next(G.play.cards)
				local mult = 0
				for _, playing_card in ipairs(G.hand.cards) do
					if playing_hand or not playing_card.highlighted then
						if playing_card.facing and not (playing_card.facing == 'back') and not playing_card.debuff and playing_card:is_suit(card.ability.extra.suit) then
							mult = mult + card.ability.extra.mult * JokerDisplay.calculate_card_triggers(playing_card, nil, true)
						end
					end
				end
				card.joker_display_values.mult = mult
			end
		}
	end,
	demicolon_compat = true,
}

-- Cadmium Colors
SynthB.Joker{
	key = "cadmium_colors",
	pos = {x = 0, y = 0},
	attributes = {"suit", "hearts", "diamonds", "economy", "song", "Jamie Paige", "Teto", "vocaloid song"},
	config = {
		extra = {
			suits = {"Hearts", "Diamonds"},
			earnings = 1
		}
	},
	cost = 5,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "cadmium_colors")
		return {vars = {card.ability.extra.suits[1], card.ability.extra.suits[2], card.ability.extra.earnings}}
	end,
	calculate = function(self, card, context)
		if context.individual and (context.cardarea == G.play or context.cardarea == G.hand) and not context.end_of_round then
			if context.other_card:is_suit(card.ability.extra.suits[1]) or context.other_card:is_suit(card.ability.extra.suits[2]) then
				if context.cardarea == G.play then
					return {
						dollars = card.ability.extra.earnings
					}
				else
					return {
						dollars = -card.ability.extra.earnings
					}
				end
			end
		end
		if context.forcetrigger then
			local out = 0
			if G.play and G.play.cards then
				for _, _card in ipairs(G.play.cards) do
					if _card:is_suit(card.ability.extra.suits[1]) or _card:is_suit(card.ability.extra.suits[2]) then
						out = out + card.ability.extra.earnings
					end
				end
			end
			if G.hand and G.hand.cards then
				for _, _card in ipairs(G.hand.cards) do
					if _card:is_suit(card.ability.extra.suits[1]) or _card:is_suit(card.ability.extra.suits[2]) then
						out = out - card.ability.extra.earnings
					end
				end
			end
			return {
				dollars = out
			}
		end
	end,
	demicolon_compat = true,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{ ref_table = "card.joker_display_values", ref_value = "sign"},
				{ text = "$" },
				{ ref_table = "card.joker_display_values", ref_value = "money", retrigger_type = "mult" },
			},
			text_config = { colour = G.C.MONEY },
			calc_function = function(card)
				local playing_hand = next(G.play.cards)
				local money = 0
				local text, _, scoring_hand = JokerDisplay.evaluate_hand()
				if text ~= "Unknown" then
					for _, playing_card in ipairs(scoring_hand) do
						if not playing_card.debuff and (playing_card:is_suit(card.ability.extra.suits[1]) or playing_card:is_suit(card.ability.extra.suits[2])) then
							money = money + card.ability.extra.earnings * JokerDisplay.calculate_card_triggers(playing_card, scoring_hand)
						end
					end
				end
				for _, playing_card in ipairs(G.hand.cards) do
					if playing_hand or not playing_card.highlighted then
						if playing_card.facing and not (playing_card.facing == 'back') and not playing_card.debuff and (playing_card:is_suit(card.ability.extra.suits[1]) or playing_card:is_suit(card.ability.extra.suits[2])) then
							money = money - card.ability.extra.earnings * JokerDisplay.calculate_card_triggers(playing_card, nil, true)
						end
					end
				end
				card.joker_display_values.money = math.abs(money)
				card.joker_display_values.sign = money >= 0 and "+" or "-"
			end
		}
	end
}

-- The World is Mine
SynthB.Joker{
	key = "the_world_is_mine",
	pos = {x = 1, y = 0},
	cost = 6,
	rarity = 2,
	config = {
		extra = {
			chip_gain = 3,
			chips = 0,
			suit = "Spades"
		}
	},
	attributes = {"chips", "suit", "spades", "scaling", "song", "ryo", "Miku", "vocaloid song"},
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "the_world_is_mine")
		return {vars = {card.ability.extra.chip_gain, card.ability.extra.suit, card.ability.extra.chips}}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "chips",
				scalar_value = "chip_gain"
			})
			return {
				chips = card.ability.extra.chips
			}
		end
		if context.individual and context.cardarea == G.play and not context.blueprint then
			if context.other_card:is_suit(card.ability.extra.suit) then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "chips",
					scalar_value = "chip_gain"
				})
			end
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

-- lump of caramel in the air fryer
SynthB.Joker{
	key = "caramel_airfryer",
	pos = {x = 1, y = 0},
	config = {
		extra = {
			num = 1,
			dem = 4,
			enhancement = "m_stone"
		}
	},
	rarity = 2,
	cost = 5,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	attributes = {"chance", "enhancements", "modify_card", "song", "Mai", "Choir", "Copykeys", "vocaloid song"},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS[card.ability.extra.enhancement]
		SynthB.song_info(info_queue, "caramel_airfryer", {"#1"})
		local num, dem = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.dem, "synthb_airfryer_stone")
		return {vars = {num, dem}}
	end,
	calculate = function(self, card, context)
		if (context.before or context.forcetrigger) and not context.blueprint then
			local stoned = 0
			for _, scored_card in ipairs(context.full_hand or G.play.cards or {}) do
				if SMODS.pseudorandom_probability(card, "synthb_airfryer_stone", card.ability.extra.num, card.ability.extra.dem) then
					stoned = stoned + 1
					scored_card:set_ability(card.ability.extra.enhancement, nil, true)
					G.E_MANAGER:add_event(Event({
						func = function()
							scored_card:juice_up()
							return true
						end
					}))
				end
			end
			SynthB.debug(context.full_hand or G.play.cards)
			if stoned > 0 then
				return {
					message = "Drained!",
					colour = G.C.GREY
				}
			end
		end
	end
}

-- Regret Rock
SynthB.Joker{
	key = "regret_rock",
	pos = {x = 2, y = 0},
	rarity = 3,
	cost = 7,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	attributes = {"debuff", "song", "MonochroMenace", "Teto", "vocaloid song"},
	config = {
		immutable = {
			active = true
		}
	},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "regret_rock")
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			card.ability.immutable.active = true
			juice_card_until(card, function() return card.ability.immutable.active and not G.RESET_JIGGLES end, true)
		end
		if context.forcetrigger then
			if G.hand and G.hand.cards then
				for _, _card in ipairs(G.hand.cards) do
					SMODS.debuff_card(_card, "prevent_debuff", "regret_rock")
				end
			end
			if G.play and G.play.cards then
				for _, _card in ipairs(G.play.cards) do
					SMODS.debuff_card(_card, "prevent_debuff", "regret_rock")
				end
			end
		end
		if context.press_play and not context.blueprint then
			if card.ability.immutable.active then
				if G.hand and G.hand.highlighted then
					local debuffed = 0
					for _, _card in ipairs(G.hand.highlighted) do
						if _card.debuff then debuffed = debuffed + 1 end
					end
					if debuffed == #G.hand.highlighted then
						card.ability.immutable.active = false
						for _, _card in ipairs(G.hand.cards) do
							SMODS.debuff_card(_card, "prevent_debuff", "regret_rock")
						end
					end
				end
			end
		end
	end
}

-- My Bread was Burnt to a Crisp
SynthB.Joker{
	key = "burnt_toast",
	pos = {x = 2, y = 0},
	config = {
		extra = {
			gain = 5,
			cost = 30
		}
	},
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	rarity = 3,
	cost = 8,
	attributes = {"planet", "chance", "song", "Rei", "Picdo", "vocaloid song"},
	loc_vars = function(self, info_queue, card)
		SynthB.heat_info(info_queue)
		SynthB.song_info(info_queue, "burnt_toast")
		return {vars = {card.ability.extra.gain, (G.GAME or {}).synthb_temp or 0, (G.GAME or {}).synthb_max_temp or 100, card.ability.extra.cost}}
	end,
	calculate = function(self, card, context)
		if context.remove_playing_cards then
			return {
				func = SynthB.ease_temp(card.ability.extra.gain * #context.removed)
			}
		end
		if context.using_consumeable and context.consumeable.config.center.set == "Planet" then
			if SMODS.pseudorandom_probability(card, "synthb_burnt_bread", G.GAME.synthb_temp or 0, G.GAME.synthb_max_temp or 100, nil, true) then
				SMODS.upgrade_poker_hands{
---@diagnostic disable-next-line: assign-type-mismatch
					hands = context.consumeable.ability.hand_type or "High Card"
				}
			end
		end
	end,
	can_use = function(self, card)
		return G.hand.highlighted and #G.hand.highlighted > 0 and G.GAME.synthb_temp or 0 >= card.ability.extra.cost
	end,
	use = function(self, card)
		SynthB.ease_temp(-card.ability.extra.cost)()
		local t, _, _, _, _= G.FUNCS.get_poker_hand_info(G.hand.highlighted)
		SMODS.upgrade_poker_hands{
---@diagnostic disable-next-line: assign-type-mismatch
			hands = t
		}
	end
}

-- Machine Love
SynthB.Joker{
	key = "machine_love",
	pos = {x = 1, y = 0},
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			mult = 1
		}
	},
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	attributes = {"modify_card", "mult", "perma_bonus", "reset", "discard", "song", "Teto", "Jamie Paige", "vocaloid song"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "machine_love")
		return {vars = {card.ability.extra.mult}}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			if G.play and G.play.cards then
				for _, _card in ipairs(G.play.cards) do
					_card.ability.perma_mult = (_card.ability.perma_mult or 0) + card.ability.extra.mult
					_card.ability.SynthB_machine_love_mult = (_card.ability.SynthB_machine_love_mult or 0) + card.ability.extra.mult
				end
			end
		end
		if context.individual and context.cardarea == G.play then
			context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) + card.ability.extra.mult
			context.other_card.ability.SynthB_machine_love_mult = (context.other_card.ability.SynthB_machine_love_mult or 0) + card.ability.extra.mult
			return {
				message = localize('k_upgrade_ex'),
				colour = G.C.MULT
			}
		end
	end
}

-- Triple Baka
SynthB.Joker{
	key = "triple_baka",
	pos = {x = 0, y = 0},
	config = {
		immutable = {
			hand = nil,
			tarot = "c_fool"
		}
	},
	cost = 4,
	eternal_compat = true,
	blueprint_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	attributes = {"hand_type", "generation", "tarot", "song", "vocaloid song", "Teto", "Miku", "LamazeP"},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS[card.ability.immutable.tarot]
		SynthB.song_info(info_queue, "triple_baka")
		return {vars = {card.ability.immutable.hand and localize(card.ability.immutable.hand, "poker_hands") or "[Random Poker Hand]", localize{type = "name_text", set = "Tarot", key = card.ability.immutable.tarot}}}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			G.E_MANAGER:add_event(Event({
				func = (function()
					G.E_MANAGER:add_event(Event({
						func = function()
							SMODS.add_card{key = card.ability.immutable.tarot}
							G.GAME.consumeable_buffer = 0
							return true
						end
					}))
					SMODS.calculate_effect({ message = localize('k_plus_tarot'), colour = G.C.PURPLE }, context.blueprint_card or card)
					return true
				end)
			}))
		end
		if context.before and context.scoring_name == card.ability.immutable.hand then
			if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				G.E_MANAGER:add_event(Event({
					func = (function()
						G.E_MANAGER:add_event(Event({
							func = function()
								SMODS.add_card{key = card.ability.immutable.tarot}
								G.GAME.consumeable_buffer = 0
								return true
							end
						}))
						SMODS.calculate_effect({ message = localize('k_plus_tarot'), colour = G.C.PURPLE }, context.blueprint_card or card)
						return true
					end)
				}))
				return nil, true
			end
		end
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			local _poker_hands = {}
			for handname, _ in pairs(G.GAME.hands) do
				if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.immutable.hand then
					_poker_hands[#_poker_hands + 1] = handname
				end
			end
			card.ability.immutable.hand = pseudorandom_element(_poker_hands, 'synthb_triple_baka')
			return {
				message = localize('k_reset')
			}
		end
	end,
	set_ability = function(self, card, initial, delay_sprites)
		local _poker_hands = {}
		for handname, _ in pairs(G.GAME.hands) do
			if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.immutable.hand then
				_poker_hands[#_poker_hands + 1] = handname
			end
		end
		card.ability.immutable.hand = pseudorandom_element(_poker_hands, 'synthb_triple_baka')
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{ text = "+" },
				{ ref_table = "card.joker_display_values", ref_value = "tarots", retrigger_type = "mult" },
			},
			text_config = { colour = G.C.SECONDARY_SET.Tarot },
			reminder_text = {
				{ text = "(" },
				{ ref_table = "card.joker_display_values", ref_value = "poker_hand", colour = G.C.ORANGE },
				{ text = ")" },
			},
			calc_function = function(card)
				local text, _, _ = JokerDisplay.evaluate_hand()
				card.joker_display_values.tarots = text == card.ability.immutable.hand and 1 or 0
				card.joker_display_values.poker_hand = localize(card.ability.immutable.hand, 'poker_hands')
			end
		}
	end
}

-- Rolling Girl
SynthB.Joker{
	key = "rolling_girl",
	pos = {x = 0, y = 0},
	cost = 4,
	attributes = {"song", "vocaloid song", "Miku", "Wowaka"},
	config = {
		extra = {
			retriggers = 2
		}
	},
	eternal_compat = true,
	blueprint_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "rolling_girl")
		return {vars = {card.ability.extra.retriggers}}
	end,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			if context.other_card == context.scoring_hand[#context.scoring_hand] then
				return {
					repetitions = card.ability.extra.retriggers
				}
			end
		end
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
				if held_in_hand then return 0 end
				local last_card = scoring_hand and scoring_hand[#scoring_hand]
				return last_card and playing_card == last_card and joker_card.ability.extra.retriggers * JokerDisplay.calculate_joker_triggers(joker_card) or 0
			end
		}
	end
}

-- Self Destructive Girl
SynthB.Joker{
	key = "self_destructive_girl",
	pos = {x = 1, y = 0},
	rarity = 2,
	cost = 7,
	perishable_compat = true,
	eternal_compat = false,
	attributes = {"on_sell", "destroy_card", "song", "vocaloid song", "Miku", "EMIRI"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "self_destructive_girl")
	end,
	calculate = function(self, card, context)
		if context.selling_self or context.forcetrigger then
			local index = 0
			for i, _card in ipairs(G.jokers.cards) do
				if _card == (context.blueprint_card or card) then
					index = i
					break
				end
			end
			if index ~= 0 then SMODS.destroy_cards({G.jokers.cards[index - 1], G.jokers.cards[index + 1]}, true) end
		end
	end
}

-- Lemonade
SynthB.Joker{
	key = "lemonade",
	pos = {x = 1, y = 0},
	rarity = 2,
	cost = 8,
	config = {
		extra = {
			earnings = 6,
			loss = 1,
			scale = 1,
			cap = 10
		},
		immutable = {
			mem_earnings = 6
		}
	},
	perishable_compat = true,
	eternal_compat = false,
	blueprint_compat = true,
	demicolon_compat = true,
	attributes = {"economy", "food", "scaling", "song", "vocaloid song", "Yi Xi", "worzy"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "lemonade")
		return {vars = {card.ability.extra.earnings, card.ability.extra.loss, card.ability.extra.scale, card.ability.extra.cap}}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			card.ability.immutable.mem_earnings = card.ability.extra.earnings
			card.ability.extra.earnings = card.ability.extra.earnings - card.ability.extra.loss
			if card.ability.extra.earnings <= 0 then
				SMODS.destroy_cards(card, nil, nil, true)
			else
				card.ability.extra.earnings = math.min(card.ability.extra.earnings * 2, card.ability.extra.cap)
				card.ability.extra.loss = card.ability.extra.loss + card.ability.extra.scale
				card.ability.extra.scale = card.ability.extra.scale + 1
			end
			return {
				dollars = card.ability.immutable.mem_earnings
			}
		end
		if context.end_of_round and context.main_eval then
			card.ability.immutable.mem_earnings = card.ability.extra.earnings
			card.ability.extra.earnings = card.ability.extra.earnings - card.ability.extra.loss
			if card.ability.extra.earnings <= 0 then
				SMODS.destroy_cards(card, nil, nil, true)
			end
		end
		if context.selling_card and not context.blueprint then
			card.ability.extra.earnings = math.min(card.ability.extra.earnings * 2, card.ability.extra.cap)
			card.ability.extra.loss = card.ability.extra.loss + card.ability.extra.scale
			card.ability.extra.scale = card.ability.extra.scale + 1
		end
	end,
	calc_dollar_bonus = function (self, card)
		return card.ability.immutable.mem_earnings or nil
	end
}

-- Tetoris
SynthB.Joker{
	key = "tetoris",
	pos = {x = 0, y = 0},
	config = {
		extra = {
			scaling = 10,
			chips = 0
		},
		immutable = {
			cards = 5
		}
	},
	cost = 5,
	attributes = {"chips", "hand_type", "scaling", "song", "Teto", "vocaloid song"},
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	demicolon_compat = true,
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "tetoris")
		return {vars = {card.ability.extra.scaling, card.ability.immutable.cards, card.ability.extra.chips}}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "chips",
				scalar_value = "scaling"
			})
			return {
				chips = card.ability.extra.chips
			}
		end
		if context.joker_main then
			return {
				chips = card.ability.extra.chips
			}
		end
		if context.before and not context.blueprint then
			if #context.scoring_hand == card.ability.immutable.cards then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "chips",
					scalar_value = "scaling"
				})
			end
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

-- Relay Outer
SynthB.Joker{
	key = "relayouter",
	pos = {x = 1, y = 0},
	rarity = 2,
	cost = 7,
	config = {
		extra = {
			reset = 1,
			earnings = 1,
			scaling = 1
		},
		immutable = {
			rank = 9,
			mem_earnings = 1
		}
	},
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	attributes = {"economy", "scaling", "reset", "rank", "9", "song", "vocaloid song", "Yuki", "inabakumori"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "relayouter")
		return {vars = {card.ability.extra.earnings, card.ability.extra.scaling, card.ability.immutable.rank}}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "earnings",
				scalar_value = "scaling"
			})
			return {
				dollars = card.ability.extra.earnings
			}
		end
		if context.individual and context.cardarea == G.play and not context.blueprint then
			if context.other_card:get_id() == card.ability.immutable.rank then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "earnings",
					scalar_value = "scaling"
				})
				SynthB.debug(card.ability.extra.earnings)
				card.ability.immutable.mem_earnings = card.ability.extra.earnings
			end
		end
		if context.end_of_round and context.game_over == false and context.main_eval and context.beat_boss and not context.blueprint then
			if card.ability.extra.earnings > card.ability.extra.reset then
				card.ability.immutable.mem_earnings = card.ability.extra.earnings
				card.ability.extra.earnings = card.ability.extra.reset
				return {
					message = localize('k_reset'),
					colour = G.C.RED
				}
			end
		end
	end,
	calc_dollar_bonus = function (self, card)
		return card.ability.immutable.mem_earnings or nil
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{ text = "$" },
				{ ref_table = "card.ability.extra", ref_value = "earnings", retrigger_type = "mult" },
			},
			text_config = { colour = G.C.MONEY },
		}
	end
}

-- Retry Now Normal
SynthB.Joker{
	key = "retry_now_normal",
	pos = {x = 2, y = 0},
	rarity = 3,
	cost = 9,
	attributes = {"prevents_death", "song", "vocaloid song", "Miku", "Nakiso"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "retry_now")
	end,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	calculate = function(self, card, context)
		if context.end_of_round and context.game_over and context.main_eval then
			if G.GAME.chips / G.GAME.blind.chips >= 0.9 then
				G.E_MANAGER:add_event(Event({
					func = function()
						G.hand_text_area.blind_chips:juice_up()
						G.hand_text_area.game_chips:juice_up()
						G.E_MANAGER:add_event(Event{
							trigger = 'after',
							delay = 0.15,
							func = function()
								card:flip()
								return true
							end
						})
						delay(0.2)
						G.E_MANAGER:add_event(Event{
							trigger = 'after',
							delay = 0.1,
							func = function()
								card:set_ability("j_synthb_retry_now_change")
								play_sound('tarot1') -- replace with custom sound
								return true
							end
						})
						G.E_MANAGER:add_event(Event{
							trigger = 'after',
							delay = 0.15,
							func = function()
								card:flip()
								return true
							end
						})
						return true
					end
				}))
				G.GAME.SynthB_retry_now_saved = true
				return {
					message = localize('k_saved_ex'),
					saved = 'ph_retry_now',
					colour = G.C.BLUE
				}
			end
		end
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			reminder_text = {
				{ text = "(" },
				{ ref_table = "card.joker_display_values", ref_value = "active_text" },
				{ text = ")" },
			},
			calc_function = function(card)
				local is_active = false
				local blind_ratio = (G.GAME.chips or 0) / ((G.GAME.blind or {}).chips or 1)
				is_active = blind_ratio and blind_ratio ~= 0 and blind_ratio >= 0.9 or false

				card.joker_display_values.is_active = is_active
				card.joker_display_values.active_text = is_active and localize("jdis_active") or localize("jdis_inactive")
			end,
			style_function = function(card, text, reminder_text, extra)
				if reminder_text and reminder_text.children and reminder_text.children[2] then
					reminder_text.children[2].config.colour = card.joker_display_values.is_active and G.C.GREEN or G.C.UI.TEXT_INACTIVE
				end
			end
		}
	end
}

-- Retry Now Changed
SynthB.Joker{
	key = "retry_now_change",
	pos = {x = 3, y = 0},
	rarity = 4,
	cost = 20,
	synthb_song = "retry_now_normal",
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	config = {
		extra = {
			scaling = 0.1
		}
	},
	in_pool = function (self, args)
		return false
	end,
	attributes = {"xmult", "scaling", "hand", "song", "vocaloid song", "Miku", "Nakiso"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "retry_now")
		return {vars = {card.ability.extra.scaling, 1 + card.ability.extra.scaling * (G.GAME.hands_played or 0)}}
	end,
	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
			return {
				xmult = 1 + card.ability.extra.scaling * (G.GAME.hands_played or 0)
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
						{ ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
					}
				}
			},
			calc_function = function(card)
				card.joker_display_values.xmult = 1 + card.ability.extra.scaling * (G.GAME.hands_played or 0)
			end
		}
	end
}




