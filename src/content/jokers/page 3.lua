--- Page 3


-- Spot Late
SynthB.Joker{
	key = "spot_late",
	cost = 4,
	config = {
		extra = {
			gain = 1,
			mult = 0
		}
	},
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	attributes = {"mult", "scaling", "song", "vocaloid song", "inabakumori", "yuki"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "spot_late")
		return {vars = {card.ability.extra.gain, card.ability.extra.mult}}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.gain
			return {
				mult = card.ability.extra.mult
			}
		end
		if context.before then
			if G.jokers.cards[1] == card then
				card.ability.extra.mult = math.max(0, card.ability.extra.mult - card.ability.extra.gain)
			else
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.gain
			end
		end
		if context.joker_main and G.jokers.cards[1] == card then
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
			calc_function = function (card)
				card.joker_display_values.mult = G.jokers.cards[1] == card and card.ability.extra.mult or 0
			end
		}
	end
}

-- Heat Abnormal
SynthB.Joker{
	key = "heat_abnormal",
	pos = {x = 2, y = 0},
	rarity = 3,
	cost = 8,
	config = {
		extra = {
			raise = 1,
			gain = 8,
			limit = 100
		}
	},
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	attributes = {"chips", "scaling", "modify_card", "temperature", "song", "vocaloid song", "Iyowa", "Rei"},
	loc_vars = function(self, info_queue, card)
		SynthB.heat_info(info_queue)
		SynthB.song_info(info_queue, "heat_abnormal")
		return {vars = {card.ability.extra.gain, card.ability.extra.limit, card.ability.extra.gain * math.floor((G.GAME or {}).synthb_temp or 0), card.ability.extra.raise}}
	end,
	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
			return {
				chips = card.ability.extra.gain * math.floor(SynthB.get_temp())
			}
		end
		if context.individual and context.cardarea == G.play then
			return {
				func = SynthB.ease_temp(1)
			}
		end
	end,
	can_use = function(self, card)
		return SynthB.get_temp() >= card.ability.extra.limit and G.hand and G.hand.cards and #G.hand.cards > 0
	end,
	use = function(self, card)
		SynthB.ease_temp(-card.ability.extra.limit)()
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.4,
			func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
				return true
			end
		}))
		for i = 1, #G.hand.cards do
			local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					G.hand.cards[i]:flip()
					play_sound('card1', percent)
					G.hand.cards[i]:juice_up(0.3, 0.3)
					return true
				end
			}))
		end
		delay(0.2)
		for i = 1, #G.hand.cards do
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					G.hand.cards[i]:set_ability(SMODS.poll_enhancement{guaranteed = true})
					return true
				end
			}))
		end
		for i = 1, #G.hand.cards do
			local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					G.hand.cards[i]:flip()
					play_sound('tarot2', percent, 0.6)
					G.hand.cards[i]:juice_up(0.3, 0.3)
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
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{ text = "+", colour = G.C.CHIPS },
				{ ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult", colour = G.C.CHIPS },
				{ text = " "},
				{
					border_nodes = {
						{text = "+"},
						{ref_table = "card.joker_display_values", ref_value = "heat", retrigger_type = "mult"}
					},
					border_colour = G.C.ORANGE
				}
			},
			calc_function = function (card)
				local heat = 0
				local text, _, scoring_hand = JokerDisplay.evaluate_hand()
				if text ~= 'Unknown' then
					for _, scoring_card in pairs(scoring_hand) do
						heat = heat + card.ability.extra.raise * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
					end
				end
				card.joker_display_values.heat = heat
				card.joker_display_values.chips = card.ability.extra.gain * (SynthB.get_temp() + (G.play and G.play.cards and #G.play.cards == 0 and heat or 0))
			end
		}
	end
}

-- Spoken For
SynthB.Joker{
	key = "spoken_for",
	cost = 5,
	config = {
		extra = {
			mult = 30
		}
	},
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	demicolon_compat = true,
	attributes = {"mult", "chance", "song", "vocaloid song", "Teto", "Flavor Foley"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "spoken_for")
		return {vars = {card.ability.extra.mult}}
	end,
	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
			return {
				mult = card.ability.extra.mult * (SMODS.pseudorandom_probability(card, "synthb_spoken_for", 1, 2, nil, true) and 1 or -1)
			}
		end
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{ text = "+/- " },
				{ ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" }
			},
			text_config = {colour = G.C.MULT}
		}
	end
}

-- Hello, World!
SynthB.Joker{
	key = "hello_world",
	pos = {x = 1, y = 0},
	rarity = 2,
	cost = 7,
	config = {
		immutable = {
			active = true
		}
	},
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	demicolon_compat = false,
	attributes = {"passive", "song", "vocaloid song", "Motoo Fujiwara", "Miku"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "hello_world")
		local cardarea = CardArea(G.ROOM.T.x, G.ROOM.T.y, G.CARD_W * 0.7, G.CARD_H * 0.7, {
			type = 'title_2', card_limit = 1, highlight_limit = 0
		})
		if G.deck and G.deck.cards and #G.deck.cards > 0 and not (card.area and card.area.config.collection) then
			cardarea:emplace(copy_card(G.deck.cards[#G.deck.cards], nil, 0.7))
		end
		return {vars = {elements = {cardarea}}}
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval then
			card.ability.immutable.active = true
		end
	end,
	can_use = function(self, card)
		return G.deck and #G.deck.cards > 1 and card.ability.immutable.active
	end,
	use = function(self, card)
		card.ability.immutable.active = false
		local card = G.deck.cards[#G.deck.cards]
		G.deck.cards[#G.deck.cards] = nil
		table.insert(G.deck.cards, 1, card)
	end
}

-- Clone Clone
SynthB.Joker{
	key = "clone_clone",
	pos = {x = 2, y = 0},
	rarity = 3,
	cost = 9,
	config = {
		extra = {
			num = 1,
			dem = 4,
		}
	},
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = false,
	attributes = {"generation", "chance", "stickers", "song", "vocaloid song", "Atena", "GUMI", "Rin"},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {set = "Other", key = "synthb_fake"}
		SynthB.song_info(info_queue, "clone_clone")
		local num, dem = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.dem, "synthb_clone_clone")
		return {vars = {num, dem}}
	end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			local copied = {}
			for _, _card in ipairs(context.scoring_hand) do
				if SMODS.pseudorandom_probability(card, "synthb_clone_clone", card.ability.extra.num, card.ability.extra.dem) then
					G.playing_card = (G.playing_card and G.playing_card + 1) or 1
					local card_copied = copy_card(_card, nil, nil, G.playing_card)
					if SMODS.pseudorandom_probability(card, "synthb_clone_clone_fake", 1, 4, nil, true) then
						card_copied:add_sticker("synthb_fake", true)
					end
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
				end
			end
			if #copied > 0 then
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

-- I'm the Rain
SynthB.Joker{
	key = "im_the_rain",
	cost = 4,
	config = {
		extra = {
			num = 2,
			dem = 5
		}
	},
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	attributes = {"chance", "tarot", "generation", "rank", "song", "vocaloid", "Miku", "Yuki", "inabakumori"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "im_the_rain")
		local num, dem = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.dem, "synthb_im_the_rain")
		return {vars = {num, dem}}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger or context.modify_card_rank then
			if context.forcetrigger or SMODS.pseudorandom_probability(card, "synthb_im_the_rain", card.ability.extra.num, card.ability.extra.dem) then
				if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					return {
						message = "雨",
						font = 5,
						color = G.C.GREY,
						func = function()
							G.E_MANAGER:add_event(Event({
								func = (function()
									SMODS.add_card {set = 'Tarot'}
									G.GAME.consumeable_buffer = 0
									return true
								end)
							}))
						end
					}
				end
			end
		end
	end,
}

-- Parry
SynthB.Joker{
	key = "parry",
	cost = 5,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = false,
	attributes = {"modify_card", "enhancement", "song", "vocaloid", "Len", "Rin", "Miyamori Bungaku"},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_glass
		info_queue[#info_queue+1] = G.P_CENTERS.m_gold
		SynthB.song_info(info_queue, "parry")
	end,
}

-- Nyan Cat
SynthB.Joker{
	key = "nyan_cat",
	pos = {x = 1, y = 0},
	rarity = 2,
	cost = 6,
	config = {
		extra = {
			scale = 0.25
		}
	},
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	attributes = {"xmult", "suit", "song", "vocaloid song", "Momone", "momomomoP"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "nyan_cat")
		return {vars = {card.ability.extra.scale}}
	end,
	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
			if G.play.cards then
				local suits = {}
				local wilds = 0
				for _, _card in ipairs(context.scoring_hand or G.play.cards) do
					if SMODS.has_enhancement(_card, "m_wild") then
						wilds = wilds + 1
					else
						suits[_card.base.suit] = true
					end
				end
				for _ in pairs(suits) do
					wilds = wilds + 1
				end
				return {
					xmult = 1 + wilds * card.ability.extra.scale
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
						{text = "X"},
						{ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult"}
					},
				}
			},
			calc_function = function (card)
				local wilds = 0
				local text, _, scoring_hand = JokerDisplay.evaluate_hand()
				if text ~= 'Unknown' then
					local suits = {}
					for _, _card in ipairs(scoring_hand) do
						if SMODS.has_enhancement(_card, "m_wild") then
							wilds = wilds + 1
						else
							suits[_card.base.suit] = true
						end
					end
					for _ in pairs(suits) do
						wilds = wilds + 1
					end
				end
				
				card.joker_display_values.mult = 1 + wilds * card.ability.extra.scale
			end
		}
	end
}

-- D/N/A
SynthB.Joker{
	key = "dna",
	atlas = "joker_placeholders",
	pos = {x = 8, y = 3},
	rarity = 3,
	cost = 8,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = false,
	attributes = {"generation", "modify_card", "hands", "song", "vocaloid song", "Teto", "flower", "Azari"},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {set = "Other", key = "synthb_linked", vars = {"N/A"}}
		SynthB.song_info(info_queue, "dna")
	end,
	calculate = function(self, card, context)
		if context.first_hand_drawn and not context.blueprint then
			local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
			juice_card_until(card, eval, true)
		end
		if context.before and G.GAME.current_round.hands_played == 0 and not context.blueprint and #context.full_hand == 1 then
			G.playing_card = (G.playing_card and G.playing_card + 1) or 1
			local card_copied = copy_card(context.full_hand[1], nil, nil, G.playing_card)
			card_copied:add_to_deck()
			SynthB.link_cards{context.full_hand[1], card_copied}
			G.deck.config.card_limit = G.deck.config.card_limit + 1
			table.insert(G.playing_cards, card_copied)
			G.discard:emplace(card_copied)
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
							SMODS.calculate_context({ playing_card_added = true, cards = { card_copied } })
							return true
						end
					}))
				end
			}
		end
	end,
}

-- Character T
SynthB.Joker{
	key = "character_t",
	pos = {x = 0, y = 0},
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "character_t")
	end,
	calculate = function(self, card, context)
		if context.forcetrigger or (context.setting_blind and #G.jokers.cards == 1) then
			local do_teto_edition = SMODS.pseudorandom_probability(card, "synthb_character_t", 1, 10, nil, true)
			G.GAME.joker_buffer = G.GAME.joker_buffer + 1
			G.E_MANAGER:add_event(Event({
				func = function()
					local _card = SMODS.add_card{key = pseudorandom_element(SMODS.get_attribute_pool(do_teto_edition and "chip" or "Teto")) or "j_synthb_miku"}
					if not _card:has_attribute("Teto") then
						_card:set_edition("e_synthb_cover_teto")
					end
					play_sound("synthb_teto", 1, 1)
					G.GAME.joker_buffer = 0
					return true
				end
			}))
			return {
				message = localize('k_synthb_plus_teto'),
				colour = G.ARGS.LOC_COLOURS.garfields_thanksgiving,
			}
		end
	end,
}

--- Feedback
SynthB.Joker{
	key = "feedback",
	cost = 5,
	config = {
		extra = {
			mult = 0,
			scaling = 3
		}
	},
	attributes = {"scaling", "mult", "rank", "suit", "ace", "spades", "enhancenment", "song", "vocaloid song", "Luka", "MonochroMenace", "isidore"},
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "feedback")
		return {vars = {card.ability.extra.mult, card.ability.extra.scaling}}
	end,
	calculate = function(self, card, context)
		if (context.before or context.forcetrigger) and not context.blueprint then
			local scaled = true
			for key, value in ipairs(context.scoring_hand) do
				if value:get_id() == 14 and value.base.suit == "Spades" and SMODS.has_enhancement(value, "m_wild") then
					SMODS.scale_card(card, {
						ref_table = card.ability.extra,
						ref_value = "mult",
						scalar_value = "scaling"
					})
					break
				end
			end
		end
		if context.joker_main and context.forcetrigger then
			return {
				mult = card.ability.extra.mult
			}
		end
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{text = "+"},
				{ref_table = "card.joker_display_values", ref_value = "mult"}
			},
			reminder_text = {
				{text = "(Wild Ace of Spades)"}
			},
			text_config = {colour = G.C.MULT},
			calc_function = function (card)
				local mult = card.ability.extra.mult
				local text, _, scoring_hand = JokerDisplay.evaluate_hand()
				if text ~= 'Unknown' then
					for _, scoring_card in pairs(scoring_hand) do
						if scoring_card:get_id() == 14 and scoring_card.base.suit == "Spades" and SMODS.has_enhancement(scoring_card, "m_wild") then
							mult = mult + card.ability.extra.scaling
						end
					end
				end
				card.joker_display_values.mult = mult
			end
		}
	end
}

--- Tell Your World
SynthB.Joker{
	key = "tell_your_world",
	rarity = 4,
	pos = {x = 3, y = 0},
	cost = 25,
	config = {
		extra = {
			rounds = 5
		},
		immutable = {
			tarot = "c_world",
		}
	},
	attributes = {"generation", "tarot", "stickers", "modify_card", "song", "vocaloid song", "Miku", "kz"},
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	demicolon_compat = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS[card.ability.immutable.tarot]
		info_queue[#info_queue+1] = {set = "Other", key = "synthb_linked_temp", vars = {39, 5, "s"}}
		SynthB.song_info(info_queue, "tell_your_world")
		return {vars = {localize{type = "name_text", set = "Tarot", key = card.ability.immutable.tarot}, card.ability.extra.rounds}}
	end,
	calculate = function(self, card, context)
		if context.setting_blind or context.forcetrigger then
			if (#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) or context.forcetrigger then
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
	end
}
