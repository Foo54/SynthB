--- Page 4



-- Blackjack
SynthB.Joker{
	key = "blackjack",
	pos = {x = 2, y = 0},
	rarity = 3,
	cost = 7,
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
	pos = {x = 3, y = 0},
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


