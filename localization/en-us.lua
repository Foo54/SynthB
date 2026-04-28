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
					"{C:inactive}[Currently {C:chips}+#3#{C:inactive} Chips]",
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
				name = {"{f:5}パンこげこげになっちゃった", "{s:0.7}My Bread was Burnt to a Crisp"},
				text = {
					"{C:red}Destroying{} playing cards",
					"upgrades a {C:attention}poker hand",
					"based on the cards rank",
					"{C:inactive,s:0.8,f:5}もっと美味しく出来るハズだから"
				}
			},
			j_synthb_machine_love = {
				name = "Machine Love",
				text = {
					"Every played {C:attention}card{}",
					"permanently gains",
					"{C:mult}+#1#{} mult when scored",
					"Resets when discarded",
					"{C:inactive,s:0.8}Can you teach me to be real?"
				}
			},
			j_synthb_triple_baka = {
				name = {"{f:5}驫麤～とりぷるばか～", "{s:0.7}Triple Baka"},
				text = {
					"Create a {C:tarot}#2#",
					"if played hand",
					"is a {C:attention}#1#{}",
					"poker hand changes",
					"at end of round",
					"{C:inactive}[Must have room]",
					"{C:inactive,s:0.8,f:5}バカ! バカ! バカ!"
				}
			},
			j_synthb_rolling_girl = {
				name = {"{f:5}ローリンガール", "{s:0.7}Rolling Girl"},
				text = {
					"Retrigger {C:attention}last{} played",
					"card used in scoring",
					"{C:attention}#1#{} additional times",
					"{C:inactive,s:0.8,f:5}もう一回、もう一回。"
				}
			},
			j_synthb_self_destructive_girl = {
				name = "Self Destructive Girl",
				text = {
					"Sell this card to",
					"{C:red}destroy{} adjacent jokers",
					"{C:inactive}[Bypasses {C:attention}Eternal{C:inactive}]",
					"{C:inactive,s:0.8,f:5}バイバイ、壊してあげるね"
				}
			},
			j_synthb_lemonade = {
				name = "Lemonade",
				text = {
					{
						"Earn {C:money}$#1#{} at",
						"end of round",
						"{C:money}-$#2#{} per",
						"round played"
					},
					{
						"When a card is sold",
						"{C:attention}double{} money earned",
						"{C:inactive}[max of {C:money}$#4#{C:inactive}]",
						"and raise money lost by {C:money}$#3#",
						"{C:inactive,s:0.8}One more scoop of sugar, sugar"
					}
				}
			},
			j_synthb_tetoris = {
				name = {"{f:5}テトリス", "{s:0.7}Tetoris"},
				text = {
					"Gain {C:chips}+#1#{} chips if",
					"a {C:attention}#2#{} card hand",
					"is played",
					"{C:inactive}[Currently {C:chips}+#3#{C:inactive} Chips]",
					"{C:inactive,s:0.8,f:5}テテテテトリス"
				}
			},
			j_synthb_relayouter = {
				name = {"{f:5}リレイアウター", "{s:0.7}Relay Outer"},
				text = {
					"Earn {C:money}$#1#{} at",
					"end of round",
					"Payout increases by",
					"{C:money}$#2#{} when a {C:attention}#3#",
					"is scored, resets",
					"when {C:attention}Boss Blind{} defeated",
					"{C:inactive,s:0.8,f:5}どうしようもない僕の嬉しさは"
				}
			},
			j_synthb_retry_now_normal = {
				name = {"{f:5}temp", "Retry Now"},
				text = {
					"Prevents death",
					"if chips scored",
					"are at least {C:attention}90%",
					"of required chips",
					"{E:2,C:red}self destructs?",
					"{C:inactive,s:0.8,f:5}lyrics"
				}
			},
			j_synthb_retry_now_change = {
				name = {"{f:5}temp", "Retry Now"},
				text = {
					"{X:mult,C:white}X#1#{} mult per {C:attention}hand",
					"played this run",
					"{C:inactive}[Currently {X:mult,C:white}X#2#{C:inactive} Mult]",
					"{C:inactive,s:0.8}207944154"
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
					"{f:5}パンこげこげになっちゃった",
					"{C:inactive,s:0.8}My Bread was Burnt to a Crisp",
					"{C:attention}Producer:",
					"Picdo",
					"{C:attention}Voice:",
					"{f:5}足立レイ",
					"{C:inactive,s:0.8}Adachi Rei"
				}
			},
			machine_love = {
				text = {
					"{C:attention}Title:",
					"Machine Love",
					"{C:attention}Producer:",
					"Jamie Paige",
					"{C:attention}Voice:",
					"{f:5}重音テト",
					"{C:inactive,s:0.8}Kasane Teto"
				}
			},
			triple_baka = {
				text = {
					"{C:attention}Title:",
					"{f:5}驫麤～とりぷるばか～",
					"{C:inactive,s:0.8}Triple Baka",
					"{C:attention}Producer:",
					"LamazeP",
					"{C:attention}Voice:",
					"{f:5}重音テト{} & {f:5}初音ミク",
					"{C:inactive,s:0.8}Kasane Teto & Hatsune Miku"
				}
			},
			rolling_girl = {
				text = {
					"{C:attention}Title:",
					"{f:5}ローリンガール",
					"{C:inactive,s:0.8}Rolling Girl",
					"{C:attention}Producer:",
					"Wowaka",
					"{C:attention}Voice:",
					"{f:5}初音ミク",
					"{C:inactive,s:0.8}Hatsune Miku"
				}
			},
			self_destructive_girl = {
				text = {
					"{C:attention}Title:",
					"Self Destructive Girl",
					"{C:attention}Producer:",
					"EMIRI",
					"{C:attention}Voice:",
					"{f:5}初音ミク",
					"{C:inactive,s:0.8}Hatsune Miku"
				}
			},
			lemonade = {
				text = {
					"{C:attention}Title:",
					"Lemonade",
					"{C:attention}Producer:",
					"worzy",
					"{C:attention}Voice:",
					"{f:4}奕夕",
					"{C:inactive,s:0.8}Yi Xi"
				}
			},
			tetoris = {
				text = {
					"{C:attention}Title:",
					"{f:5}テトリス",
					"{C:inactive,s:0.8}Tetoris",
					"{C:attention}Producer:",
					"{f:5}柊マグネタイト",
					"{C:inactive,s:0.8}Hiiragi Magnetite",
					"{C:attention}Voice:",
					"{f:5}重音テト",
					"{C:inactive,s:0.8}Kasane Teto"
				}
			},
			relayouter = {
				text = {
					"{C:attention}Title:",
					"{f:5}リレイアウター",
					"{C:inactive,s:0.8}Relay Outer",
					"{C:attention}Producer:",
					"{f:5}稲葉曇",
					"{C:inactive,s:0.8}inabakumori",
					"{C:attention}Voice:",
					"{f:5}歌愛ユキ",
					"{C:inactive,s:0.8}Kaai Yuki"
				}
			},
			retry_now = {
				text = {
					"{C:attention}Title",
					"{f:5}temp",
					"{C:inactive,s:0.8}Retry Now",
					"{C:attention}Producer:",
					"{f:5}temp",
					"{C:inactive,s:0.8}Nakiso",
					"{C:attention}Voice:",
					"{f:5}初音ミク",
					"{C:inactive,s:0.8}Hatsune Miku"
				}
			}
		}
	}
}

for _, content in pairs(descriptions.descriptions.SongInfo) do
	content.name = "Song Info"
end

return descriptions