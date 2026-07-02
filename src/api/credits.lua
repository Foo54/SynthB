---@class SynthB.Credits.Contributor: SMODS.Joker
SynthB.Credits.Contributor = SMODS.Joker:extend{
	synthb_credit_card = true,
	in_pool = function (self, args)
		return false
	end,
	no_collection = true,
	discovered = true,
	unlocked = true,
	set_badges = function (self, card, badges)
		badges[#badges+1] = create_badge("Credit Card", SynthB.custom_colors.LIGHT_GREEN)
	end,
	create_area = function(self, w, h, extra_params)
		w = w or G.CARD_W
		h = h or G.CARD_H
		extra_params = extra_params or {}
		extra_params.type = "title"
		return CardArea(G.ROOM.T.x, G.ROOM.T.y, w, h, extra_params)
	end,
	create_sprite = function(self, area, extra_params)
		extra_params = extra_params or {}
		extra_params.key = self.key
		extra_params.area = area
		local joker = SMODS.create_card(extra_params)
		joker:set_edition(nil)
		if self.no_ui then joker.no_ui = true end
		joker.synthb_in_credits = true
		local joker_hover_ref = joker.hover
		function joker.hover (_self)
			joker_hover_ref(_self)
			self:hover()
		end
		local joker_stop_hover_ref = joker.stop_hover
		function joker.stop_hover (_self)
			joker_stop_hover_ref(_self)
			self:stop_hover()
		end
		local joker_click_ref = joker.click
		function joker.click (_self)
			joker_click_ref(_self)
			self:click()
		end
		area:emplace(joker)
		return joker
	end,
	hover = function(self) end,
	stop_hover = function(self) end,
	click = function(self) end,
	inject = function (self, i)
		if not SynthB.Credits.data[self.original_key] then
			SynthB.Credits.data[self.original_key] = self
			SynthB.Credits.index_to_key[#SynthB.Credits.index_to_key+1] = self.original_key
			SynthB.Credits.list_of_people[#SynthB.Credits.list_of_people+1] = self.name
		end
		return SMODS.Joker.inject(self, i)
	end
}