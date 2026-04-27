local descriptions = {
	descriptions = {
		Joker = {
			j_synthb_antani_itten_no = {
				name = {"{f:5}アンタに言ってんの!!!", "{s:0.7}I'm Talking to You!!!"},
				text = {
					"{C:clubs}#1#{} held in hand",
					"give {C:mult}+#2#{} mult"
				}
			},
			j_synthb_cadmium_colors = {
				name = "Cadmium Colors",
				text = {
					"{C:hearts}#1#{} and {C:diamonds}#2#",
					"Earn {C:money}$#3#{} when scored,",
					"but lose {C:money}$#3#{} when held in hand"
				}
			}
		},
		SongInfo = {
			antani_itten_no = {
				text = {
					"{C:attention}Title:",
					"{f:5}アンタに言ってんの!!!",
					"{C:inactive,s:0.8}I'm Talking to You!!!",
					"{C:attention}Producer:",
					"{f:5}ぴーなた",
					"{C:inactive,s:0.8}Pinata",
					"{C:attention}Voice:",
					"{f:5}重音テト",
					"{C:inactive,s:0.8}Kasane Teto"
				}
			},
			cadmium_colors = {
				text = {
					"{C:attention}Title:",
					"Cadmium Colors",
					"{C:attention}",
					"{C:attention}Producer:",
					"Jamie Paige",
					"{C:attention}Voice:",
					"{f:5}重音テト",
					"{C:inactive,s:0.8}Kasane Teto"
				}
			}
		}
	}
}

for _, content in pairs(descriptions.descriptions.SongInfo) do
	content.name = "Song Info"
end

return descriptions