local descriptions = {
	descriptions = {
		Joker = {
			j_synthb_antani_itten_no = {
				name = {"{f:5}アンタに言ってんの!!!", "{s:0.7}I'm Talking to You!!!"},
				text = {
					"{C:clubs}#1#{} held in hand",
					"give {C:mult}+#2#{} mult",
					"{C:inactive,s:0.8,f:5}泣いちゃいたいくらい",
					"{C:inactive,s:0.8,f:5}に素敵な月ですね(笑)",
				}
			},
			j_synthb_cadmium_colors = {
				name = "Cadmium Colors",
				text = {
					"Cards with {C:hearts}#1#{} or {C:diamonds}#2#{} suit",
					"Earn {C:money}$#3#{} when scored,",
					"but lose {C:money}$#3#{} when held in hand",
					"{C:inactive,s:0.8}How could anybody ever",
					"{C:inactive,s:0.8}live like me?",
				}
			},
			j_synthb_the_world_is_mine = {
				name = {"{f:5}ワールドイズマイン", "{s:0.7}The World is Mine"},
				text = {
					"This joker gains {C:chips}+#1#{} chips when a",
					"{C:attention}card{} with {C:spades}#2#{} suit scores",
					"{C:inactive}[Currently {C:chips}+#3#{C:inactive} chips]",
					"{C:inactive,s:0.8,f:5}世界でいちばんおひめさま"
				}
			},
			j_synthb_caramel_airfryer = {
				name = "lump of caramel in the air fryer",
				text = {
					"{C:green}#1# in #2# chance{} for played cards",
					"to become {C:attention}Stone{} cards",
					"{C:inactive,s:0.8}Oh, when all my emptiness turns pink,",
					"{C:inactive,s:0.8}will you even care?"
				}
			},
			j_synthb_regret_rock = {
				name = "Regret Rock",
				text = {
					"{C:attention}Once{} per round,",
					"{C:attention}Undebuff{} all playing cards in view",
					"if {C:attention}played{} hand contains",
					"only {C:red}debuffed{} cards",
					"{C:inactive,s:0.8}R - E - G - R - E - T!"
				}
			},
			j_synthb_burnt_toast = {
				name = {"{f:5}temp", "My Bread was Burnt to a Crisp"},
				text = {
					"{C:red}Destroying{} playing cards",
					"upgrades a {C:attention}poker hand",
					"based on the cards rank",
					"{C:inactive,s:0.8,f:5}lyrics"
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
					"{C:attention}Producer:",
					"Jamie Paige",
					"{C:attention}Voice:",
					"{f:5}重音テト",
					"{C:inactive,s:0.8}Kasane Teto"
				}
			},
			the_world_is_mine = {
				text = {
					"{C:attention}Title",
					"{f:5}ワールドイズマイン",
					"{C:inactive,s:0.8}The World is Mine",
					"{C:attention}Producer:",
					"ryo",
					"{C:attention}Voice:",
					"{f:5}初音ミク",
					"{C:inactive,s:0.8}Hatsune Miku"
				}
			},
			caramel_airfryer = {
				text = {
					"{C:attention}Title:",
					"lump of caramel in the air fryer",
					"{C:attention}Producer:",
					"Copykeys",
					"{C:attention}Voice:",
					"{f:5}舞{} & Choir Voices #1#",
					"{C:inactive,s:0.8}Mai"
				}
			},
			regret_rock = {
				text = {
					"{C:attention}Title:",
					"Regret Rock",
					"{C:attention}Producer:",
					"MonochroMenace",
					"{C:attention}Voice:",
					"{f:5}重音テト",
					"{C:inactive,s:0.8}Kasane Teto"
				}
			},
			burnt_toast = {
				text = {
					"{C:attention}Title:",
					"{f:5}temp",
					"{C:inactive,s:0.8}My Bread was Burnt to a Crisp",
					"{C:attention}Producer:",
					"Picdo",
					"{C:attention}Voice:",
					"{f:5}temp",
					"{C:inactive,s:0.8}Adachi Rei"
				}
			},
		}
	}
}

for _, content in pairs(descriptions.descriptions.SongInfo) do
	content.name = "Song Info"
end

return descriptions