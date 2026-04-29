---@diagnostic disable: duplicate-set-field
local set_edition_ref = Card.set_edition
function Card:set_edition(edition, immediate, silent, delay)
	if type(edition) == "table" then
		if edition.name_of_edition then
			edition = "e_" .. edition.name_of_edition
		else
			edition = edition.key
		end
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
	return effect, post_trig
end