SMODS.DrawStep{
	key = "various_things",
	order = 25,
	func = function (card, layer)
		if card.config.center.key == "j_synthb_retry_now_normal" or card.config.center.key == "j_synthb_retry_now_change" then
			card.children.center:draw_shader("synthb_retry_now", nil, card.ARGS.send_to_shader)
		end
		if card.config.center.set == "synthb_Sign" then
			card.children.center:draw_shader("synthb_streetcat", nil, card.ARGS.send_to_shader)
		end
	end
}