---@diagnostic disable: duplicate-set-field
function SynthB.mod.config_tab()
	return {n = G.UIT.ROOT, config = { r = 0.1, minw = 8, align = "tm", padding = 0.2, colour = G.C.BLACK }, nodes = {
		{n = G.UIT.R, config = { padding = 0.2 }, nodes = {
			{n = G.UIT.C, config = { align = "cr" }, nodes = {
				{n = G.UIT.R, config = { align = "cr", padding = 0.01 }, nodes = {
					create_toggle({
						label = "Enable Song Info",
						ref_table = SynthB.mod.config,
						ref_value = 'display_song_info'
					})
				}}
			}}
		}}
	}}
end