local scale = 0.7

function G.UIDEF.synthb_thermometer_bottom ()
	return {n = G.UIT.ROOT, nodes = {
		{n = G.UIT.O, config = {object = SMODS.create_sprite(0, 0, 1 * scale, 3.81 * scale, "synthb_thermometer", {x = 1, y = 0})}}
	}}
end

function G.UIDEF.synthb_thermometer_top ()
	return {n = G.UIT.ROOT, nodes = {
		{n = G.UIT.R, config = {
			tooltip = {
				title = "Current Temperature",
				text = {{ref_table = G.GAME, ref_value = "synthb_temp_c"}},
				align = "cr"
			}
		}, nodes = {
			{n = G.UIT.O, config = {
				object = SMODS.create_sprite(0, 0, 1 * scale, 3.81 * scale, "synthb_thermometer", {x = 0, y = 0})
			}}
		}}
	}}
end