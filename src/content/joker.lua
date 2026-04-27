
-- I'm Talking to You!!!
SMODS.Joker{
	key = "antani_itten_no",
	atlas = "placeholder",
	pos = {x = 0, y = 0},
	attributes = {"mult", "suit", "clubs", "Teto", "song", "ぴーなた", "vocaloid song"},
	config = {
		extra = {
			suit = "Clubs",
			mult = 6
		}
	},
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
	end
}

-- Cadmium Colors
SMODS.Joker{
	key = "cadmium_colors",
	atlas = "placeholder",
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
	end,
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
SMODS.Joker{
	key = "the_world_is_mine",
	atlas = "placeholder",
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
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "the_world_is_mine")
		return {vars = {card.ability.extra.chip_gain, card.ability.extra.suit, card.ability.extra.chips}}
	end,
	calculate = function(self, card, context)
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
SMODS.Joker{
	key = "caramel_airfryer",
	atlas = "placeholder",
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
	attributes = {"chance", "enhancements", "modify_card", "song", "Mai", "Choir", "Copykeys", "vocaloid song"},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS[card.ability.extra.enhancement]
		SynthB.song_info(info_queue, "caramel_airfryer", {"#1"})
		local num, dem = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.dem, "synthb_airfryer_stone")
		return {vars = {num, dem}}
	end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			local stoned = 0
			for _, scored_card in ipairs(context.full_hand) do
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
SMODS.Joker{
	key = "regret_rock",
	atlas = "placeholder",
	pos = {x = 2, y = 0},
	rarity = 3,
	cost = 7,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	attributes = {"debuff", "song", "MonochroMenace", "Teto", "vocaloid song"},
	config = {
		immutable = {
			active = false
		}
	},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "regret_rock")
	end,
	add_to_deck = function (self, card, from_debuff)
		card.ability.immutable.active = true
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			card.ability.immutable.active = true
			juice_card_until(card, function() return card.ability.immutable.active and not G.RESET_JIGGLES end, true)
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
SMODS.Joker{
	key = "burnt_toast",
	atlas = "placeholder",
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
					local hand = card.ability.immutable.hands[_card.base.value] or SMODS.Ranks[_card.base.value].SynthB_toast_hand or "High Card"
					if hand == "Last Played" then hand = (SMODS.last_hand or {}).scoring_name or "High Card" end
					if not G.GAME.hands[hand].visible then
						hand = card.ability.immutable.if_hidden[_card.base.value] or SMODS.Ranks[_card.base.value].SynthB_toast_hand_hidden or "High Card"
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
SMODS.Joker{
	key = "machine_love",
	atlas = "placeholder",
	pos = {x = 1, y = 0},
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			mult = 1
		}
	},
	attributes = {"modify_card", "mult", "perma_bonus", "reset", "discard", "song", "Teto", "Jamie Paige", "vocaloid song"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "machine_love")
		return {vars = {card.ability.extra.mult}}
	end,
	calculate = function(self, card, context)
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
