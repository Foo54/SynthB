--- Page 4



-- Blackjack
SynthB.Joker{
	key = "blackjack",
	pos = {x = 0, y = 1},
	atlas = "pepix jokers",
	rarity = 3,
	cost = 7,
	synthb_credits = {
		Artist = "Pepix"
	},
	config = {
		extra = {
			xmult = 2,
		},
		immutable = {
			raise = 0.25,
			betting = 0,
			STATE_COMPLETE = true,
			STATE = 0,
			STATES = {
				NOTHING = 0,
				NEEDS_ATTENTION = 1,
				BETTING = 2,
				PLAYING = 3,
				OPPONENT = 4,
				CONTINUE = 5,
			}
		}
	},
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	demicolon_compat = true,
	attributes = {"scaling", "xmult", "song", "vocaloid song", "Luka", "YuchaP", "DarvishP", "kaichi"},
	loc_vars = function(self, info_queue, card)
		SynthB.blackjack_info(info_queue)
		SynthB.song_info(info_queue, "blackjack")
		local loc_nodes = {}
		localize{type = "other", vars = {card.ability.extra.xmult}, key = "synthb_blackjack", nodes = loc_nodes}
		for i, nodes in ipairs(loc_nodes) do
			loc_nodes[i] = {n = G.UIT.R, config = {align = "cm"}, nodes = nodes}
		end
		if card.ability.immutable.STATE ~= card.ability.immutable.STATES.NOTHING then
		SynthB.Globals.blackjack.deck = CardArea(G.ROOM.T.x, G.ROOM.T.y, G.CARD_W * 0.4, G.CARD_H * 0.4, {
			type = 'deck', card_limit = 52, highlight_limit = 0
		})
		SynthB.Globals.blackjack.opponent = CardArea(G.ROOM.T.x, G.ROOM.T.y, G.CARD_W * 0.4 * 5, G.CARD_H * 0.4, {
			type = 'hand', card_limit = 5, highlight_limit = 0, no_card_count = true
		})
		SynthB.Globals.blackjack.hand = CardArea(G.ROOM.T.x, G.ROOM.T.y, G.CARD_W * 0.4 * 5, G.CARD_H * 0.4, {
			type = 'hand', card_limit = 5, highlight_limit = 0, no_card_count = true
		})
	end
		return {main_end = {
			{n = G.UIT.R, nodes = {
				card.ability.immutable.STATE ~= card.ability.immutable.STATES.NOTHING and {n = G.UIT.C, config = {align = "cm"}, nodes = {
					{n = G.UIT.O, config = {id = "blackjack", object = UIBox{
						definition = {n = G.UIT.ROOT, config = {colour = G.C.UI.TRANSPARENT_DARK, padding = 0.1, r = 0.1, minw = 5, minh = 3}, nodes = {
							{n = G.UIT.C, config = {align = "cm", minw = 1.5}, nodes = {
								{n = G.UIT.R, config = {align = "cm", r = 0.1, padding = 0.1, colour = G.C.MULT}, nodes = {
									{n = G.UIT.T, config = {text = "X", scale = 0.4, colour = G.C.UI.TEXT_LIGHT}},
									{n = G.UIT.T, config = {ref_table = card.ability.immutable, ref_value = "betting", scale = 0.4, colour = G.C.UI.TEXT_LIGHT}}
								}},
								{n = G.UIT.R, nodes = {
									{n = G.UIT.B, config = {w = 0.1, h = 0.2}}
								}},
								{n = G.UIT.R, config = {align = "cm"}, nodes = {
									{n = G.UIT.O, config = {object = SynthB.Globals.blackjack.deck}}
								}}
							}},
							{n = G.UIT.C, config = {align = "cm"}, nodes = {
								{n = G.UIT.R, config = {align = "cm"}, nodes = {
									{n = G.UIT.O, config = {object = SynthB.Globals.blackjack.opponent}}
								}},
								{n = G.UIT.R, nodes = {
									{n = G.UIT.B, config = {w = 0.1, h = 0.1}}
								}},
								{n = G.UIT.R, config = {align = "cm"}, nodes = {
									{n = G.UIT.C, config = {id = "left_button", synthb_ignore = true, func = "synthb_can_lower", button = "synthb_lower", button_dist = 0, ref_table = card, align = "cm", padding = 0.1, minw = 1.25, maxw = 1.25, minh = 0.4, colour = G.C.RED, r = 0.1}, nodes = {
										{n = G.UIT.T, config = {ref_table = SynthB.Globals.blackjack.buttons, ref_value = "left_button", scale = 0.4, colour = G.C.UI.TEXT_LIGHT}}
									}},
									{n = G.UIT.C, nodes = {
										{n = G.UIT.B, config = {w = 0.1, h = 0.1}}
									}},
									{n = G.UIT.C, config = {id = "middle_button", synthb_ignore = true, button = "synthb_confirm", button_dist = 0, ref_table = card, align = "cm", padding = 0.1, minw = 0.75, maxw = 0.75, minh = 0.4, colour = G.C.GREEN, r = 0.1}, nodes = {
										{n = G.UIT.T, config = {ref_table = SynthB.Globals.blackjack.buttons, ref_value = "middle_button", scale = 0.4, colour = G.C.UI.TEXT_LIGHT}}
									}},
									{n = G.UIT.C, nodes = {
										{n = G.UIT.B, config = {w = 0.1, h = 0.1}}
									}},
									{n = G.UIT.C, config = {id = "right_button", synthb_ignore = true, func = "synthb_can_raise", button = "synthb_raise", button_dist = 0, ref_table = card, align = "cm", padding = 0.1, minw = 1.25, maxw = 1.25, minh = 0.4, colour = G.C.RED, r = 0.1}, nodes = {
										{n = G.UIT.T, config = {ref_table = SynthB.Globals.blackjack.buttons, ref_value = "right_button", scale = 0.4, colour = G.C.UI.TEXT_LIGHT}}
									}}
								}},
								{n = G.UIT.R, nodes = {
									{n = G.UIT.B, config = {w = 0.1, h = 0.1}}
								}},
								{n = G.UIT.R, config = {align = "cm"}, nodes = {
									{n = G.UIT.O, config = {object = SynthB.Globals.blackjack.hand}}
								}}
							}},
						}},
						config = {}
					}}}
				}} or nil,
				{n = G.UIT.C, config = {padding = 0.05, align = "cm"}, nodes = loc_nodes}
			}},
		}}
	end,
	update = function (self, card, dt)
		if card.ability.immutable.STATE == card.ability.immutable.STATES.NEEDS_ATTENTION then
			if not card.ability.immutable.STATE_COMPLETE then
				juice_card_until(card, function() return card.ability.immutable.STATE == card.ability.immutable.STATES.NEEDS_ATTENTION end)
				card.ability.immutable.STATE_COMPLETE = true
			end
		end
		if card.ability.immutable.STATE == card.ability.immutable.STATES.BETTING then
			if not card.ability.immutable.STATE_COMPLETE then
				card.ability.immutable.betting = 0
				SynthB.Globals.blackjack.buttons.left_button = "Lower"
				SynthB.Globals.blackjack.buttons.middle_button = "Confirm"
				SynthB.Globals.blackjack.buttons.right_button = "Raise"
				for _, rank in ipairs{"2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"} do
					for _, suit in ipairs{"Hearts", "Spades", "Diamonds", "Clubs"} do
						local _card = SMODS.create_card{scale = {w = 0.4, h = 0.4}, set = "Base", rank = rank, suit = suit}
						SynthB.Globals.blackjack.deck:emplace(_card)
					end
				end
				SynthB.Globals.blackjack.deck:shuffle("synthb_blackjack_shuffle")
				card.ability.immutable.STATE_COMPLETE = true
			end
		end
		if card.ability.immutable.STATE == card.ability.immutable.STATES.PLAYING then
			if not card.ability.immutable.STATE_COMPLETE then
				local e
				for _, element in ipairs(G.I.POPUP) do
					if element:get_UIE_by_ID("left_button") then
						e = element
						break
					end
				end
				if not e then error("Could not find Blackjack UI Box, please report this as an issue") end
				local data = {
					{"hand", 			false}, -- cardarea, stay flipped
					{"opponent",	true},
					{"hand", 			false},
					{"opponent", 	false}
				}
				for _, rules in ipairs(data) do
					local _card = SynthB.Globals.blackjack.deck.cards[#SynthB.Globals.blackjack.deck.cards]
					SynthB.Globals.blackjack.deck:remove_card(_card)
					SynthB.Globals.blackjack[rules[1]]:emplace(_card, nil, rules[2])
				end

				---@type UIElement
				local middle_button = e:get_UIE_by_ID("middle_button")
				middle_button.config.button = nil
				middle_button.config.colour = G.C.CLEAR
				SynthB.Globals.blackjack.buttons.middle_button = SynthB.blackjack_score(SynthB.Globals.blackjack.hand)

				---@type UIElement
				local left_button = e:get_UIE_by_ID("left_button")
				left_button.config.button = "synthb_hit"
				left_button.config.func = "synthb_can_hit"
				SynthB.Globals.blackjack.buttons.left_button = "Hit"

				---@type UIElement
				local right_button = e:get_UIE_by_ID("right_button")
				right_button.config.button = "synthb_stand"
				right_button.config.func = "synthb_update_stand"
				right_button.config.colour = G.C.RED
				SynthB.Globals.blackjack.buttons.right_button = "Stand"

				card.ability.immutable.STATE_COMPLETE = true
			end
		end
		if card.ability.immutable.STATE == card.ability.immutable.STATES.OPPONENT then
			if not card.ability.immutable.STATE_COMPLETE then
				local e
				for _, element in ipairs(G.I.POPUP) do
					if element:get_UIE_by_ID("left_button") then
						e = element
						break
					end
				end
				if not e then error("Could not find Blackjack UI Box, please report this as an issue") end
				
				while SynthB.blackjack_score(SynthB.Globals.blackjack.opponent) < 16 do
					local _card = SynthB.Globals.blackjack.deck.cards[#SynthB.Globals.blackjack.deck.cards]
					SynthB.Globals.blackjack.deck:remove_card(_card)
					SynthB.Globals.blackjack.opponent:emplace(_card)
				end
				SynthB.Globals.blackjack.opponent.cards[1]:flip()

				local opponent = SynthB.blackjack_score(SynthB.Globals.blackjack.opponent)
				local you = SynthB.blackjack_score(SynthB.Globals.blackjack.hand)
				SynthB.Globals.blackjack.buttons.middle_button = opponent .. " / " .. you

				---@type UIElement
				local left_button = e:get_UIE_by_ID("left_button")
				left_button.config.func = nil
				left_button.config.colour = G.C.GREEN
				left_button.config.button = "synthb_continue"
				SynthB.Globals.blackjack.buttons.left_button = "Continue"

				---@type UIElement
				local right_button = e:get_UIE_by_ID("right_button")
				right_button.config.colour = G.C.UI.BACKGROUND_INACTIVE
				right_button.config.func = nil
				right_button.config.button = nil

				card.ability.immutable.STATE_COMPLETE = true
			end
		end
		if card.ability.immutable.STATE == card.ability.immutable.STATES.CONTINUE then
			if not card.ability.immutable.STATE_COMPLETE then
				local opponent = SynthB.blackjack_score(SynthB.Globals.blackjack.opponent)
				local you = SynthB.blackjack_score(SynthB.Globals.blackjack.hand)
				local outcome
				if opponent > 21 and you > 21 then outcome = 0
				elseif opponent > 21 then outcome = -1
				elseif you > 21 then outcome = 1
				else outcome = opponent - you end

				SynthB.Globals.blackjack_open = nil
				SynthB.Globals.blackjacks_to_play = SynthB.Globals.blackjacks_to_play - 1
				card:stop_hover()
				card:click()

				card.ability.extra.xmult = card.ability.extra.xmult + card.ability.immutable.betting * (outcome < 0 and 1 or outcome > 0 and -1 or 0)

				if you ~= 0 then SMODS.calculate_effect({message = localize("k_synthb_blackjack_" .. (outcome < 0 and "win" or outcome > 0 and "lose" or "tie")), colour = G.C.MONEY}, card) end
				
				if card.ability.extra.xmult <= 0 then
					SMODS.destroy_cards(card)
				end
				card.ability.immutable.STATE = card.ability.immutable.STATES.NOTHING
				card.ability.immutable.STATE_COMPLETE = true
			end
		end
	end,
	calculate = function(self, card, context)
		if context.press_play and not context.blueprint and not context.retrigger_joker then
			SynthB.Globals.blackjacks_to_play = SynthB.Globals.blackjacks_to_play + 1
			card.ability.immutable.STATE = card.ability.immutable.STATES.NEEDS_ATTENTION
			card.ability.immutable.STATE_COMPLETE = false
			return {
				message = localize("k_synthb_needs_attention")
			}
		end
		if context.joker_main then
			return {
				xmult = card.ability.extra.xmult
			}
		end
	end
}


-- Dance Delightful
SynthB.Joker{
	key = "dance_delightful",
	pos = {x = 3, y = 1},
	soul_pos = {x = 4, y = 1},
	atlas = "pepix jokers",
	synthb_credits = {
		Artist = "Pepix"
	},
	rarity = 4,
	cost = 20,
	config = {
		extra = {
			manip = 2
		}
	},
	demicolon_compat = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	attributes = {"joker", "vocaloid", "vocaloid song", "Rei", "Jamie Paige"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "dance_delightful")
		return {vars = {card.ability.extra.manip}}
	end,
	remove_from_deck = function (self, card, from_debuff)
		if G.jokers and G.jokers.cards then
			for _, _card in ipairs(G.jokers.cards) do
				if (_card.synthb_dd_mod or {})[card] then
					SynthB.manip_card(_card, function (key, val) return val / _card.synthb_dd_mod[card] end)
					_card.synthb_dd_mod[card] = nil
				end
			end
		end
	end,
	update = function (self, card, dt)
		if not card.debuff and G.jokers and G.jokers.cards and card.area == G.jokers then
			local left_card
			local looking_for = "left"
			local modified_cards = {}
			for i, _card in pairs(G.jokers.cards) do
				if looking_for == "left" then
					if _card == card then -- we've found our card, left_card is a target to modify
						if left_card then -- no valid left card
							if not left_card.synthb_dd_mod then left_card.synthb_dd_mod = {} end -- don't crash
							if left_card.synthb_dd_mod[card] ~= card.ability.extra.manip then -- there has been a change since we last manipulated it
								SynthB.manip_card(left_card, function(key, val) return val * card.ability.extra.manip / (left_card.synthb_dd_mod[card] or 1) end) -- remove old change, add new change
								left_card.synthb_dd_mod[card] = card.ability.extra.manip -- store new change
							end
							modified_cards[left_card] = nil -- remove card from the list of cards to wipe
						end
						looking_for = "right" -- now look for right card
					elseif _card.config.center.key ~= "j_synthb_dance_delightful" then -- store cards to the left of this card if they aren't other dd's
						if not _card.synthb_dd_mod then _card.synthb_dd_mod = {} end
						if _card.synthb_dd_mod[card] then modified_cards[_card] = i end -- card was moved and needs to have its bonus removed
						left_card = _card
					end
				else -- looking for right card, or checking for any cards that were moved
					if _card.config.center.key ~= "j_synthb_dance_delightful" then -- again, skip other dance delightfuls
						if not _card.synthb_dd_mod then _card.synthb_dd_mod = {} end -- no crash
						if looking_for == "right" then -- right card found
							if _card.synthb_dd_mod[card] ~= card.ability.extra.manip then -- there has been a change, see above
								SynthB.manip_card(_card, function(key, val) return val * card.ability.extra.manip / (_card.synthb_dd_mod[card] or 1) end)
								_card.synthb_dd_mod[card] = card.ability.extra.manip
							end
							looking_for = "none" -- just store it as cards to wipe
						elseif _card.synthb_dd_mod[card] then modified_cards[_card] = i end
					end
				end
			end
			for _card, index in pairs(modified_cards) do -- wipe cards
				if _card.synthb_dd_mod[card] then
					SynthB.manip_card(_card, function(key, val) return val / _card.synthb_dd_mod[card] end)
					_card.synthb_dd_mod[card] = nil
				end
			end
		end
	end
}


-- YARARARA
SynthB.Joker{
	key = "yararara",
	pos = {x = 2, y = 0},
	rarity = 3,
	cost = 9,
	config = {
		extra = {
			scoring = 128,
			discarding = 39
		},
		immutable = {
			scored = 0,
			discarded = 0
		}
	},
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
	demicolon_compat = true,
	attributes = {"generation", "discards", "joker", "song", "vocaloid song", "Teto", "Miku", "AnythingBecomeMoe"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "yararara")
		return {vars = {card.ability.extra.scoring, card.ability.extra.discarding, card.ability.immutable.scored, card.ability.immutable.discarded}}
	end,
	calculate = function(self, card, context)
		if not context.blueprint then
			if context.discard then
				card.ability.immutable.discarded = card.ability.immutable.discarded + 1
			end
			if context.individual and context.cardarea == G.play then
				card.ability.immutable.scored = card.ability.immutable.scored + 1
			end
			if context.forcetrigger or ((context.after or context.discard) and card.ability.immutable.scored >= card.ability.extra.scoring and card.ability.immutable.discarded >= card.ability.extra.discarding) then
				local jokers = {}
				for i = 1, #G.jokers.cards do
					if G.jokers.cards[i] ~= card then
						jokers[#jokers + 1] = G.jokers.cards[i]
					end
				end
				local chosen_joker = pseudorandom_element(jokers, 'synthb_yararara')
				local copied_joker = copy_card(chosen_joker)
				copied_joker:add_to_deck()
				copied_joker:set_edition("e_negative")
				G.jokers:emplace(copied_joker)
				SMODS.destroy_cards(card)
				return { message = localize('k_duplicated_ex') }
			end
		end
	end,
}


-- needLe
SynthB.Joker{
	atlas = "bd_jokers",
	pos = {x = 1, y = 0},
	key = "needle",
	synthb_credits = {
		Artist = "Foo54"
	},
	cost = 5,
	config = {
		extra = {
			num = 1,
			dem = 4
		}
	},
	eternal_compat = true,
	perishable_compat = true,
	blueprint_compat = false,
	demicolon_compat = false,
	attributes = {"suit", "hearts", "chance", "song", "vocaloid song", "Miku", "Deco*27"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "needle")
		local num, dem = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.dem, "synthb_needle")
		return {vars = {num, dem}}
	end,
	calculate = function(self, card, context)
		if context.prevent_destroy_card and not context.blueprint then
			if context.prevent_destroy_card:is_suit("Hearts") then
				if not SMODS.pseudorandom_probability(card, "synthb_needle", card.ability.extra.num, card.ability.extra.dem) then
					return {
						prevent_destroy = true
					}
				end
			end
		end
	end,
}


-- Pink
SynthB.Joker{
	key = "pink",
	synthb_song = "song_synthb_pink",
	atlas = "joker_placeholders",
	pos = {x = 9, y = 4},
	synthb_credits = {
		Background = "Foo54",
	},
	rarity = 4,
	cost = 20,
	config = {
		extra = {
			xmult = 5,
			scoring = 20,
			scored = 0
		}
	},
	set_sprites = function (self, card, front)
		if SynthB.mod.config.spoilers.deltarune then
			card.children.center:set_sprite_pos({x = 4, y = 1}) -- replace this with a spoiler sprite
		end
	end,
	in_pool = function (self, args)
		return not SynthB.mod.config.spoilers.deltarune
	end,
	attributes = {"xmult", "hearts", "suit", "generation", "song", "vocaloid song", "Camellia", "Toby Fox", "Miku"},
	loc_vars = function(self, info_queue, card)
		if SynthB.mod.config.spoilers.deltarune then return {vars = {"Deltarune"}, key = "j_synthb_spoiler"} end
		SynthB.song_info(info_queue, "pink")
		info_queue[#info_queue+1] = G.P_CENTERS.j_synthb_pink_body
		info_queue[#info_queue+1] = G.P_CENTERS.j_synthb_pink_ghost
		return {vars = {card.ability.extra.xmult, card.ability.extra.scoring, card.ability.extra.scored}}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.blueprint and not next(context.poker_hands['Flush']) and context.other_card:is_suit("Hearts") then
			card.ability.extra.scored = card.ability.extra.scored + 1
			if card.ability.extra.scored >= card.ability.extra.scoring then
				card:remove()
				SMODS.add_card{key = "j_synthb_pink_body"}
				SMODS.add_card{key = "j_synthb_pink_ghost"}
			end
		end
		if context.joker_main or context.forcetrigger then
			return {
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
						{ ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" }
					},
				}
			}
		}
	end
}


-- Pink Body
SynthB.Joker{
	key = "pink_body",
	atlas = "joker_placeholders",
	synthb_credits = {
		Background = "Foo54",
	},
	synthb_song = "song_synthb_pink",
	pos = {x = 0, y = 5},
	rarity = 4,
	cost = 20,
	config = {
		extra = {
			xmult = 1,
			gain = 0.4
		}
	},
	eternal_compat = false,
	blueprint_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	in_pool = function (self, args)
		return false
	end,
	set_sprites = function (self, card, front)
		if SynthB.mod.config.spoilers.deltarune then
			card.children.center:set_sprite_pos({x = 4, y = 1}) -- replace this with a spoiler sprite
		end
	end,
	attributes = {"xmult", "hearts", "suit", "song", "vocaloid song", "Camellia", "Toby Fox", "Miku"},
	loc_vars = function(self, info_queue, card)
		if SynthB.mod.config.spoilers.deltarune then return {vars = {"Deltarune"}, key = "j_synthb_spoiler"} end
		if not card.fake_card then SynthB.song_info(info_queue, "pink") end
		return {vars = {card.ability.extra.gain, card.ability.extra.xmult}}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger or (context.before and not next(context.poker_hands['Flush']) and not context.blueprint) then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "xmult",
				scalar_value = "gain"
			})
		end
		if context.joker_main or context.forcetrigger then
			return {
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
						{ ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" }
					},
				}
			}
		}
	end
}


-- Pink Ghost
SynthB.Joker{
	key = "pink_ghost",
	synthb_song = "song_synthb_pink",
	atlas = "joker_placeholders",
	synthb_credits = {
		Background = "Foo54",
	},
	attributes = {"suit", "hearts", "diamonds", "song", "vocaloid song", "Camellia", "Toby Fox", "Miku"},
	pos = {x = 1, y = 5},
	rarity = 4,
	cost = 20,
	eternal_compat = false,
	blueprint_compat = false,
	perishable_compat = true,
	demicolon_compat = false,
	config = {
		extra_slots_used = -1,
		immutable = {
			possessed = nil,
			return_table = nil -- so i remember this exists
		}
	},
	can_use = function (self, card)
		if card.area == G.synthb_ghost_area then return true end
		for i, _card in ipairs(G.jokers.cards) do
			if _card == card then
				if i > 1 and G.jokers.cards[i - 1].config.center.key ~= "j_synthb_pink_ghost" then return true end
			end
		end
		return false
	end,
	set_sprites = function (self, card, front)
		if SynthB.mod.config.spoilers.deltarune then
			card.children.center:set_sprite_pos({x = 4, y = 1}) -- replace this with a spoiler sprite
		end
	end,
	use = function(self, card, area, copier)
		if card.area == G.synthb_ghost_area then
			for _, _card in ipairs(G.jokers.cards) do
				if card.ability.immutable.possessed == _card.ability.synthb_pink_possess then
					_card.ability.synthb_pink_possess = nil
					break
				end
			end
			card.ability.immutable.possessed = nil
			card.ability.immutable.return_table = nil
			draw_card(G.synthb_ghost_area, G.jokers, 0, "up", nil, card)
			card.T.w = G.CARD_W
			card.T.h = G.CARD_H
			card.area:remove_from_highlighted(card)
		else
			local possess
			for i, _card in ipairs(G.jokers.cards) do
				if _card == card then
					possess = G.jokers.cards[i - 1]
				end
			end
			if possess.config.center.key == "j_synthb_pink_body" then
				possess:remove()
				card:remove()
				SMODS.add_card{key = "j_synthb_pink"}
			else
				card.ability.immutable.possessed = random_string(20)
				possess.ability.synthb_pink_possess = card.ability.immutable.possessed
				draw_card(G.jokers, G.synthb_ghost_area, 0, "up", nil, card)
				card.synthb_orbit_timer = 0
				card.area:remove_from_highlighted(card)
			end
		end
	end,
	update = function (self, card, dt)
		if not card.highlighted and card.ability.immutable.possessed then card.synthb_orbit_timer = (card.synthb_orbit_timer or 0) + dt / 5 end
	end,
	in_pool = function (self, args)
		return false
	end,
	loc_vars = function(self, info_queue, card)
		if SynthB.mod.config.spoilers.deltarune then return {vars = {"Deltarune"}, key = "j_synthb_spoiler"} end
		if not card.fake_card then SynthB.song_info(info_queue, "pink") end
		info_queue[#info_queue+1] = {set = "Other", key = "synthb_possessed"}
		if card.area == G.synthb_ghost_area then return {key = "j_synthb_pink_ghost_possessing"} end
	end,
	calculate = function (self, card, context)
		if card.area == G.synthb_ghost_area then
			if context.selling_card and context.card.ability.synthb_pink_possess == card.ability.immutable.possessed then
				draw_card(G.synthb_ghost_area, G.jokers, 0, "up", nil, card)
				card.T.w = G.CARD_W
				card.T.h = G.CARD_H
				card.ability.immutable.possessed = nil
				card.ability.immutable.return_table = nil
			end
			if context.individual and context.cardarea == G.play and (context.other_card:is_suit("Diamonds") or context.other_card:is_suit("Hearts")) then
				if card.ability.immutable.return_table then
					for _, _card in ipairs(G.jokers.cards) do
						if card.ability.immutable.possessed == _card.ability.synthb_pink_possess then
							local c = copy_table(card.ability.immutable.return_table)
							c.card = _card
							return c
						end
					end
				end
			end
			if context.post_trigger and context.other_card.ability.synthb_pink_possess == card.ability.immutable.possessed and context.other_ret and context.other_ret.jokers then
				local valid_storing_table = SynthB.prune_return_table(context.other_ret.jokers)
				if next(valid_storing_table) then
					card.ability.immutable.return_table = valid_storing_table
				end
			end
		end
	end
}


-- Affection Addiction
SynthB.Joker{
	key = "affection_addiction",
	pos = {x = 1, y = 0},
	rarity = 2,
	cost = 7,
	config = {
		extra = {
			scale = 0.25,
			reset = 1,
			xmult = 1
		},
		immutable = {
			last_scored = 0
		}
	},
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	attributes = {"scaling", "reset", "xmult", "vocaloid song", "song", "POPY", "VocaloKat", "AkuP", "ryu", "Jamie Paige"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "affection_addiction")
		return {vars = {card.ability.extra.scale, card.ability.extra.xmult, card.ability.immutable.last_scored}}
	end,
	calculate = function(self, card, context)
		if context.after and not context.blueprint then
			local scoring = SMODS.calculate_round_score()
			if scoring <= card.ability.immutable.last_scored then
				card.ability.immutable.last_scored = scoring
				card.ability.extra.xmult = card.ability.extra.reset
				return {
					message = localize("k_synthb_affection")
				}
			else
				card.ability.immutable.last_scored = scoring
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "xmult",
					scalar_value = "scale"
				})
			end
		end
		if context.joker_main or context.forcetrigger then
			return {
				xmult = card.ability.extra.xmult
			}
		end
	end,
}

-- on the rocks
SynthB.Joker{
	key = "song_synthb_on_the_rocks",
	pos = {x = 1, y = 0},
	rarity  = 2,
	cost = 6,
	config = {
		extra = {
			xmult = 2,
			temp = 5,
			cost = 20
		},
		immutable = {
			side = true
		}
	},
	synthb_song = "on_the_rocks_1",
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	attributes = {"xmult", "temperature", "modify_card", "song", "vocaloid song", "MEIKO", "KAITO", "OSTER Project"},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "on_the_rocks")
		if not card.ability.immutable.side then
			info_queue[#info_queue+1] = G.P_CENTERS.e_glass
		else
			SynthB.heat_info(info_queue)
		end
		return {vars = {card.ability.extra.mult, card.ability.extra.temp, card.ability.extra.cost}, key = "j_synthb_on_the_rocks_" .. (card.ability.immutable.side and "1" or "2")}
	end,
	calculate = function(self, card, context)
		local ret
		if context.joker_main or context.force_trigger then
			if card.ability.immutable.side then
				ret = {
					xmult = card.ability.extra.xmult
				}
			else
				ret = {
					func = SynthB.ease_temp(card.ability.extra.temp)
				}
			end
		end
		if context.joker_main and not context.blueprint then
			card.ability.immutable.side = not card.ability.immutable.side
			G.E_MANAGER:add_event(Event{
				func = function()
					card:flip()
					return true
				end
			})
			delay(0.5)
			G.E_MANAGER:add_event(Event{
				func = function()
					-- set sprites
					return true
				end
			})
			delay(0.5)
			G.E_MANAGER:add_event(Event{
				func = function()
					card:flip()
					return true
				end
			})
		end
		return ret
	end,
	can_use = function (self, card)
		return G.GAME.synthb_temp >= card.ability.extra.cost and #G.hand.highlighted == 1
	end,
	use = function(self, card)
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
					G.hand.highlighted[i]:set_ability("e_glass")
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
	end,
}

-- NPC
SynthB.Joker{
	key = "npc",
	config = {
		extra = {
			xmult = 1.55
		}
	},
	cost = 4,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicolon_compat = true,
	attributes = {"xmult", "song", "vocaloid song", "Teto", "Eipu"},
	synthb_credits = {
		artist = "some guy",
		concept = "some guy",
		lusha = "lusha",
		["X1.5 mult"] = "phoebe",
		["the nerd who pointed out"] = "Papu"
	},
	loc_vars = function(self, info_queue, card)
		SynthB.song_info(info_queue, "npc")
		return {vars = {card.ability.extra.xmult}}
	end,
}



