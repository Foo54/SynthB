SMODS.DrawStep{
	key = "retry_now_glow",
	order = 25,
	func = function (card, layer)
		if card.config.center.key == "j_synthb_retry_now_normal" or card.config.center.key == "j_synthb_retry_now_change" then
			card.children.center:draw_shader("synthb_retry_now", nil, card.ARGS.send_to_shader)
		end
	end
}