local function new_colour (card)
	if not card.fake_card then
		card.synthb_changed_at = G.TIMERS.REAL
		card.synthb_old_colour = card.synthb_colour or {0, 0, 0, 1}
		while not card.synthb_colour or (card.synthb_colour[0] == card.synthb_old_colour[0] and card.synthb_colour[1] == card.synthb_old_colour[1] and card.synthb_colour[2] == card.synthb_old_colour[2]) do
			card.synthb_colour = pseudorandom_element(SynthB.custom_colors.streetcat_colours, "synthb_streetcat_colour")
		end
	end
end


SMODS.ConsumableType{
	key = "synthb_Sign",
	primary_colour = HEX("FF0000"),
	secondary_colour = SynthB.custom_colors.SIGN,
	collection_rows = {3, 3, 3},
	shop_rate = 3,
	default = "c_synthb_sign_keep_out",
	inject_card = function (self, center)
		local center_set_ability_ref = center.set_ability or function() end
		center.set_ability = function(_self, card, intial, delay_sprites)
			new_colour(card)
			center_set_ability_ref(_self, card, intial, delay_sprites)
		end
		local center_loc_vars_ref = center.loc_vars or function() end
		center.loc_vars = function(_self, info_queue, card)
			SynthB.song_info(info_queue, card, "streetcat")
			new_colour(card)
			return center_loc_vars_ref(_self, info_queue, card)
		end
	end
}


SynthB.Sign{
	key = "sign_keep_out"
}

SynthB.Sign{
	key = "sign_no_parking",
	pos = {x = 1, y = 0}
}

SynthB.Sign{
	key = "sign_no_loitering",
	pos = {x = 2, y = 0}
}

SynthB.Sign{
	key = "sign_fragile",
	pos = {x = 3, y = 0}
}
SynthB.Sign{
	key = "sign_caution",
	pos = {x = 4, y = 0}
}
SynthB.Sign{
	key = "sign_slow",
	pos = {x = 5, y = 0}
}
SynthB.Sign{
	key = "sign_keep_right",
	pos = {x = 6, y = 0}
}
SynthB.Sign{
	key = "sign_exit",
	pos = {x = 7, y = 0}
}
SynthB.Sign{
	key = "sign_no_entry",
	pos = {x = 8, y = 0}
}


