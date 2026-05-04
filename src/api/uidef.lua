local scale = 0.7

--Modifies the slider value if it is being dragged. e contains the 'container' for the bar and
--c contains the 'child' for the bar. either can be dragged. The value is lerped between the size
--of the child bar and the parent bar depending on any min/max values. Also changes the display text for the slider.
--
---@param e {}
--**e** Is the slider UIE that called this function
function G.FUNCS.synthb_slider(e)
  local c = e.children[1]
	c.T.h = (c.config.ref_table.ref_table[c.config.ref_table.ref_value] - c.config.ref_table.min)/(c.config.ref_table.max - c.config.ref_table.min)*c.config.ref_table.h
	c.config.h = c.T.h
end

function G.UIDEF.synthb_thermometer_middle ()
	local w = 1 * scale * 0.8
	local h = 3.81 * scale * 0.9
	return {n = G.UIT.ROOT, config = {colour = G.C.CLEAR}, nodes = {
		{n=G.UIT.C, config={align = "cm", minw = w, min_h = h, padding = 0.1, r = 0.1, colour = G.C.CLEAR}, nodes={
			{n=G.UIT.C, config={align = "cl", minw = w, r = 0.1,min_h = h, colour = G.C.RED,func = 'synthb_slider', refresh_movement = true}, nodes={
				{n=G.UIT.B, config={w=w,h=h, r = 0.1, colour = G.C.WHITE, ref_table = {
					ref_table = G.GAME,
					ref_value = "synthb_temp_thermo",
					min = 1,
					max = 100,
					w = w,
					h = h,
					hide_value = true
				}, refresh_movement = true}},
			}},
		}}
	}}
end


function G.UIDEF.synthb_thermometer_top ()
	return {n = G.UIT.ROOT, config = {colour = G.C.CLEAR}, nodes = {
		{n = G.UIT.R, config = {
			colour = G.C.CLEAR,
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