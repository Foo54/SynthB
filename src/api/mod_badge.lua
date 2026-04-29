---@diagnostic disable: duplicate-set-field
-- code modified from more fluff

SMODS.Shader({
	key = "mod_badge",
	path = "mod_badge.fs",
	send_vars = function (self, sprite, card)
		return {
			mask = SMODS.Atlases.synthb_mod_badge_mask.image
		}
	end
})

local smcmb = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
	smcmb(obj, badges)
	if obj then
		for i = 1, #badges do
			if badges[i].nodes[1].nodes[2].config.object and badges[i].nodes[1].nodes[2].config.object.content and badges[i].nodes[1].nodes[2].config.object.content.string == SynthB.mod.display_name then
				if not obj.no_shader_on_modbadge then
					badges[i].nodes[1].config.shader = "synthb_mod_badge"
				end
				badges[i].nodes[1].nodes[2].config.object.content.scale = 0.5
				badges[i].nodes[1].nodes[2].config.object.content.config.scale = 0.5
				badges[i].nodes[1].nodes[2].config.object.content.config.spacing = 2
				badges[i].nodes[1].nodes[2].config.object.content:update_text(true)
				table.insert(badges[i].nodes[1].nodes, 1, {n = G.UIT.B, config = {h = 0.5, w = 0.03}})
				table.insert(badges[i].nodes[1].nodes, {n = G.UIT.B, config = {h = 0.5, w = 0.03}})
			end
		end
	end
end