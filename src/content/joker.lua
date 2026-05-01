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
		immutable = {
			hands = {
				["2"] = "High Card",
				["3"] = "Pair",
				["4"] = "Two Pair",
				["5"] = "Three of a Kind",
				["6"] = "Straight",
				["7"] = "Flush",
				["8"] = "Full House",
				["9"] = "Four of a Kind",
				["10"] = "Straight Flush",
				Jack = "Five of a Kind",
				Queen = "Flush House",
				King = "Flush Five",
				Ace = "Last Played"
			},
			if_hidden = {
				Jack = "Full House",
				Queen = "Four of a Kind",
				King = "Straight Flush"
			}
		}
	},
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	rarity = 3,
	cost = 8,
	attributes = {"rank", "song", "Rei", "Picdo", "vocaloid song"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "burnt_toast")
	end,
	calculate = function(self, card, context)
		if context.remove_playing_cards then
			local hands = {}
			for _, _card in ipairs(context.removed) do
				if not _card.debuff then
					local hand = card.ability.immutable.hands[_card.base.value] or SMODS.Ranks[_card.base.value].SynthB_bread_hand or "High Card"
					if hand == "Last Played" then hand = (SMODS.last_hand or {}).scoring_name or "High Card" end
					if not SMODS.is_poker_hand_visible(hand) then
						hand = card.ability.immutable.if_hidden[_card.base.value] or SMODS.Ranks[_card.base.value].SynthB_bread_hand_hidden or "High Card"
					end
					hands[#hands+1] = hand
				end
			end
			SynthB.debug(hands)
			SMODS.upgrade_poker_hands{
				hands = hands,
				from = card
			}
		end
	end,
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


--- Page 2


-- Fire Dance
SynthB.Joker{
	key = "fire_dance",
	pos = {x = 1, y = 0},
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			gain = 2
		},
		immutable = {
			active = false
		}
	},
	attributes = {"hand_size", "hands", "song", "vocaloid song", "Miku", "Len", "KAITO", "MEIKO", "Deco*27", "Giga"},
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "fire_dance")
		return {vars = {card.ability.extra.gain, card.ability.extra.gained}}
	end,
	calculate = function(self, card, context)
		if context.blind_defeated and context.main_eval then
			if G.GAME.SynthB_oneshot_last_boss and not card.ability.immutable.active then
				card.ability.immutable.active = true
				G.hand:change_size(card.ability.extra.gain)
			elseif not G.GAME.SynthB_oneshot_last_boss and card.ability.immutable.active then
				card.ability.immutable.active = false
				G.hand:change_size(-card.ability.extra.gain)
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
				card.joker_display_values.active_text = card.ability.immutable.active and localize("jdis_active") or localize("jdis_inactive")
			end,
			style_function = function(card, text, reminder_text, extra)
				if reminder_text and reminder_text.children and reminder_text.children[2] then
					reminder_text.children[2].config.colour = card.ability.immutable.active and G.C.GREEN or G.C.UI.TEXT_INACTIVE
				end
			end
		}
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
	persishable_compat = true,
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