SynthB.energy_drinks = {
	"tag_synthb_drink_orange",
	"tag_synthb_drink_strawberry",
	"tag_synthb_drink_banana",
	"tag_synthb_drink_raspberry",
	"tag_synthb_drink_grape",
	"tag_synthb_drink_melon",
	"tag_synthb_drink_tritip",
	"tag_synthb_drink_durian"
}

-- Overthinking Orange
SMODS.Tag{
	key = "drink_orange",
	atlas = "tags",
	config = {
		extra = {
			cards = 2
		}
	},
	loc_vars = function(self, info_queue, tag)
		SynthB.song_info(info_queue, "brain_implosion_energy")
		return {vars = {tag.config.extra.cards}}
	end,
	on_obtain = function(self, tag)
		G.GAME.modifiers.booster_size_mod = (G.GAME.modifiers.booster_size_mod or 0) + tag.config.extra.cards
	end,
	apply = function (self, tag, context)
		if context.type == "synthb_pack_opened" then
			G.GAME.modifiers.booster_size_mod = (G.GAME.modifiers.booster_size_mod or 0) - tag.config.extra.cards
			tag:yep('+', G.C.PURPLE, function() return true end)
			tag.triggered = true
		end
	end,
	in_pool = function(self, args)
		return false
	end
}

-- Socially Anxious Strawberry
SMODS.Tag{
	key = "drink_strawberry",
	atlas = "tags",
	pos = {x = 1, y = 0},
	loc_vars = function(self, info_queue, tag)
		info_queue[#info_queue+1] = G.P_CENTERS.m_glass
		SynthB.song_info(info_queue, "brain_implosion_energy")
	end,
	apply = function (self, tag, context)
		if context.type == "synthb_before_hand" then
			for _, card in ipairs(G.play.cards) do
				card:set_ability("m_glass")
				card:juice_up()
			end
			tag:yep(';-;', G.C.RED, function() return true end)
			tag.triggered = true
		end
	end,
	in_pool = function(self, args)
		return false
	end
}

-- Burnout Banana
SMODS.Tag{
	key = "drink_banana",
	atlas = "tags",
	pos = {x = 2, y = 0},
	config = {
		extra = {
			num = 1,
			dem = 3
		}
	},
	loc_vars = function(self, info_queue, tag)
		info_queue[#info_queue+1] = G.P_CENTERS.j_gros_michel
		SynthB.song_info(info_queue, "brain_implosion_energy")
		local num, dem = SMODS.get_probability_vars(tag, tag.config.extra.num, tag.config.extra.dem, "synthb_burnout_banana")
		return {vars = {num, dem}}
	end,
	on_obtain = function(self, tag)
		SMODS.add_card{key = "j_gros_michel"}
	end,
	apply = function (self, tag, context)
		if context.type == "shop_start" then
			SMODS.add_card{key = "j_gros_michel"}
			if SMODS.pseudorandom_probability(tag, "synthb_burnout_banana", tag.config.extra.num, tag.config.extra.dem) then
				tag:yep("+", G.C.YELLOW, function() return true end)
				tag.triggered = true
			end
		end
	end,
	in_pool = function(self, args)
		return false
	end
}

-- Repressed Raspberry
SMODS.Tag{
	key = "drink_raspberry",
	atlas = "tags",
	pos = {x = 3, y = 0},
	config = {
		extra = {
			score = 0,
			active = false
		}
	},
	loc_vars = function (self, info_queue, tag)
		SynthB.song_info(info_queue, "brain_implosion_energy")
		return {vars = {tag.ability.score or tag.config.extra.score, tag.ability.active and "Active!" or "Inactive"}}
	end,
	set_ability = function (self, tag)
		tag.ability.score = 0
		tag.ability.active = false
	end,
	apply = function (self, tag, context)
		if context.type == "synthb_tag_clicked" then
			tag.ability.active = not tag.ability.active
			if tag.ability.active then
				juice_card_until(tag, function() return tag.ability.active end)
			end
		end
		if context.type == "synthb_gain_score" and not tag.ability.active then
			SynthB.Globals.ignore_tag_reductions = true
			tag.ability.score = tag.ability.score + SMODS.calculate_round_score() / 2
			tag:juice_up()
		end
		if context.type == "synthb_decrease_score" and not tag.ability.active then
			return {
				mult = 0.5
			}
		end
		if context.type == "synthb_before_hand" and tag.ability.active then
			tag.ability.active = false
			G.GAME.chips = G.GAME.chips + tag.ability.score
			tag:yep("+", G.C.PURPLE, function() return true end)
			tag.triggered = true
		end
	end,
	in_pool = function(self, args)
		return false
	end
}

-- Grieving Grape
SMODS.Tag{
	key = "drink_grape",
	atlas = "tags",
	pos = {x = 0, y = 1},
	config = {
		rounds = 3,
		discards = 0
	},
	loc_vars = function(self, info_queue, tag)
		SynthB.song_info(info_queue, "brain_implosion_energy")
		return {vars = {tag.ability.rounds or tag.config.rounds, (tag.ability.rounds or tag.config.rounds) > 1 and "s" or "", tag.ability.discards or tag.config.discards}}
	end,
	set_ability = function (self, tag)
		tag.ability.rounds = 3
		tag.ability.discards = 0
		tag.ability.triggered = false
	end,
	apply = function(self, tag, context)
		if context.type == "eval" then
			if G.GAME.current_round.discards_left > 0 then
				tag.ability.discards = tag.ability.discards + G.GAME.current_round.discards_left
				tag:juice_up()
				tag.ability.triggered = false
			end
		end
		if context.type == "round_start_bonus" then
			if not tag.ability.triggered then
				tag.ability.triggered = true
				tag.ability.rounds = tag.ability.rounds - 1
				if tag.ability.rounds == 0 then
					ease_discard(tag.ability.discards)
					tag:yep("+", G.C.RED, function() return true end)
					tag.triggered = true
				end
			end
		end
	end,
	in_pool = function(self, args)
		return false
	end
}

-- Misery Melon
SMODS.Tag{
	key = "drink_melon",
	atlas = "tags",
	pos = {x = 1, y = 1},
	config = {
		debt = 10
	},
	loc_vars = function (self, info_queue, tag)
		SynthB.song_info(info_queue, "brain_implosion_energy")
		return {vars = {tag.ability.debt or tag.config.debt}}
	end,
	set_ability = function (self, tag)
		tag.ability.debt = 10
	end,
	on_obtain = function(self, tag)
		G.GAME.bankrupt_at = G.GAME.bankrupt_at - tag.ability.debt
	end,
	apply = function (self, tag, context)
		if context.type == "synthb_money_changed" then
			if context.amount < 0 and G.GAME.dollars + context.amount <= G.GAME.bankrupt_at then
				ease_dollars(-2 * (G.GAME.dollars + context.amount))
				G.GAME.bankrupt_at = G.GAME.bankrupt_at + tag.ability.debt
				tag:yep("$", G.C.MONEY, function() return true end)
				tag.triggered = true
			end
		end
	end,
	in_pool = function(self, args)
		return false
	end
}

-- Trauma Tri-Tip
SMODS.Tag{
	key = "drink_tritip",
	atlas = "tags",
	pos = {x = 2, y = 1},
	config = {
		cards = 3
	},
	loc_vars = function (self, info_queue, tag)
		SynthB.song_info(info_queue, "brain_implosion_energy")
		return {vars = {tag.config.cards}}
	end,
	apply = function (self, tag, context)
		if context.type == "synthb_before_hand" then
			local t, _, _, _, _= G.FUNCS.get_poker_hand_info(G.play.cards)
			local planet
			for _, center in pairs(G.P_CENTER_POOLS.Planet) do
				if center.config.hand_type == t then
					planet = center.key
					break
				end
			end
			SMODS.add_card{key = planet}
			SMODS.add_card{key = planet}
			SMODS.add_card{key = planet}
			tag:yep("+", G.ARGS.LOC_COLOURS.planet, function() return true end)
			tag.triggered = true
		end
	end,
	in_pool = function(self, args)
		return false
	end
}

-- Depression Durian
SMODS.Tag{
	key = "drink_durian",
	atlas = "tags",
	pos = {x = 3, y = 1},
	loc_vars = function (self, info_queue, tag)
		SynthB.song_info(info_queue, "brain_implosion_energy")
	end,
	apply = function (self, tag, context)
		if context.type == "synthb_setting_blind" and context.blind.boss then
			G.E_MANAGER:add_event(Event({
				func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
							G.GAME.blind:disable()
							play_sound('timpani')
							delay(0.4)
							return true
						end
					}))
					SMODS.calculate_effect({ message = localize('ph_boss_disabled') }, tag)
					tag:yep("X", G.C.RED, function() return true end)
					tag.triggered = true
					return true
				end
			}))
		end
	end,
	in_pool = function(self, args)
		return false
	end
}


