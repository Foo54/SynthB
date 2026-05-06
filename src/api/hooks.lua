---@diagnostic disable: duplicate-set-field
local set_edition_ref = Card.set_edition
function Card:set_edition(edition, immediate, silent, delay)
	if type(edition) == "table" then
		if edition.name_of_edition then
			edition = "e_" .. edition.name_of_edition
		elseif edition.key then
			edition = edition.key
		else
			for key, _ in pairs(edition) do
				edition = "e_" .. key
				break
			end
		end
		if type(edition) == "table" then edition = nil end
	end
	if not SynthB.mod.config.allow_covers_on_any_card and edition and type(G.P_CENTERS[edition].valid_card) == 'function' then
		while type(G.P_CENTERS[edition].valid_card) == 'function' and not G.P_CENTERS[edition]:valid_card(self) do
			edition = SMODS.poll_edition{guaranteed = true}
		end
	end
	return set_edition_ref(self, edition, immediate, silent, delay)
end

local eval_card_ref = eval_card
function eval_card(card, context)
	local effect, post_trig = eval_card_ref(card, context)
	if card.edition and card.edition.key and type(G.P_CENTERS[card.edition.key].modify_effect) == "function" then
		for key, partial_effect in pairs(effect) do
			G.P_CENTERS[card.edition.key].modify_effect(card, key, partial_effect)
		end
	end
	if SynthB.too_hot() then
		for key, partial_effect in pairs(effect) do
			SynthB.heat_modify_effect(card, key, partial_effect)
		end
	end
	return effect, post_trig
end


local has_no_suit_ref = SMODS.has_no_suit
function SMODS.has_no_suit (card)
	if has_no_suit_ref(card) then return true end
	if card.debuff then return false end
	local id = card.base.id
	local rank = SMODS.Ranks[card.base.value]
	if not id then return false end
	if (id > 0 and rank and rank.face) or next(SMODS.find_card("j_pareidolia")) then
			return next(SMODS.find_card("j_synthb_medicine"))
	end
end

local has_no_rank_ref = SMODS.has_no_rank
function SMODS.has_no_rank (card)
	if has_no_rank_ref(card) then return true end
	if card.debuff then return false end
	local id = card.base.id
	local rank = SMODS.Ranks[card.base.value]
	if not id then return false end
	if (id > 0 and rank and rank.face) or next(SMODS.find_card("j_pareidolia")) then
			return next(SMODS.find_card("j_synthb_medicine"))
	end
end

local cardarea_shuffle_ref = CardArea.shuffle
function CardArea.shuffle (self, _seed)
	local ret = cardarea_shuffle_ref(self, _seed)
	if G.GAME.synthb_monitored then
		for index, card in ipairs(self.cards) do
			if card.ability.synthb_monitored then
				self.cards[index] = self.cards[#self.cards]
				self.cards[#self.cards] = card
			end
		end
		self:set_ranks() --- idk what this does but the original function has it and it seems important
	end
	return ret
end

local card_click_ref = Card.click
function Card:click ()
	if self.config.center.synthb_song then
		if SynthB.mod.config.triple_click_for_song then
			if G.TIMERS.REAL - self.config.center.synthb_timer > 1 then
				self.config.center.synthb_timer = G.TIMERS.REAL
				self.config.center.synthb_count = 0
			end
			self.config.center.synthb_count = self.config.center.synthb_count + 1
			if self.config.center.synthb_count >= 3 then
				self.config.center.synthb_count = 0
				self.config.center.synthb_timer = G.TIMERS.REAL
				G.FUNCS.go_to_song({config = {ref_table = SynthB.key_songs[type(self.config.center.synthb_song) == "string" and self.config.center.synthb_song or self.config.center.original_key]}})
			end
		end
	end
	card_click_ref(self)
end


local create_run_ref = G.start_run
function G:start_run (args)
	local ret = create_run_ref(self, args)
	if SynthB.get_temp() > 0 then
		SynthB.draw_thermometer()
	end
	return ret
end

local chip_bonus_ref = Card.get_chip_bonus
function Card:get_chip_bonus()
    return chip_bonus_ref(self) + (self.ability.synthb_bonus_chips or 0)
end

local perma_bonuses_ref = SMODS.localize_perma_bonuses
function SMODS.localize_perma_bonuses(specific_vars, desc_nodes)
	local ret = perma_bonuses_ref(specific_vars, desc_nodes)
	if specific_vars and specific_vars.synthb_mult_gain then
		localize{type = "other", key = "card_synthb_mult", nodes = desc_nodes, vars = {specific_vars.synthb_mult_gain, specific_vars.synthb_mult_duration, localize(specific_vars.synthb_mult_duration > 1 and "b_times_plural" or "b_times_singular")}}
	end
	if specific_vars and specific_vars.synthb_chips_gain then
		localize{type = "other", key = "card_synthb_chips", nodes = desc_nodes, vars = {-specific_vars.synthb_chips_gain, specific_vars.synthb_chips_duration, localize(specific_vars.synthb_chips_duration > 1 and "b_times_plural" or "b_times_singular")}}
	end
	return ret
end

local change_base_ref = SMODS.change_base
function SMODS.change_base(card, suit, rank, delay_sprites)
	local _rank = card.base.id
	local ret = change_base_ref(card, suit, rank, delay_sprites)
	if ret ~= nil and _rank ~= card.base.id then
		SMODS.calculate_context({modify_card_rank = card, old_rank = _rank, new_rank = card.base.id})
	end
	return ret
end
