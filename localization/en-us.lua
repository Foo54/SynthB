local descriptions = {
	descriptions = {
		Joker = {
			-- Page 1
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
				name = {"{f:5}いますぐ輪廻", "Retry Now"},
				text = {
					"Prevents death",
					"if chips scored",
					"are at least {C:attention}90%",
					"of required chips",
					"{E:2,C:red}self destructs?",
					"{C:inactive,s:0.8,f:5}いますぐ輪廻 今回も結ばれないね"
				}
			},
			j_synthb_retry_now_change = {
				name = {"{f:5}いますぐ輪廻", "Retry Now"},
				text = {
					"{X:mult,C:white}X#1#{} mult per {C:attention}hand",
					"played this run",
					"{C:inactive}[Currently {X:mult,C:white}X#2#{C:inactive} Mult]",
					"{C:inactive,s:0.8}207944155"
				}
			},

			-- Page 2

			j_synthb_fire_dance = {
				name = {"{f:5}ファイアダンス", "{s:0.7}Fire Dance"},
				text = {
					"{C:attention}+#1#{} hand size",
					"if the {C:attention}final{} hand played",
					"during the previous blind",
					"{C:attention}caught fire",
					"{C:inactive,s:0.8}Wake up, Get up, Stand up, MERA"
				}
			},
			j_synthb_king = {
				name = "KING",
				text = {
					"{C:attention}Leftmost{} and {C:attention}rightmost{} played cards",
					"increase their rank by {C:attention}1{}",
					"unless they are {C:attention}Kings{}",
					"{C:inactive,s:0.8,f:5}レフトサイド　ライトサイド"
				}
			},
			j_synthb_birdbrain = {
				name = "Birdbrain",
				text = {
					"Rounds do not end",
					"until {C:attention}all{} hands are used",
					"{C:inactive,s:0.8}Baby, I don't know when",
					"{C:inactive,s:0.8}I'm supposed to stop!"
				}
			},
			j_synthb_brainrot = {
				name = {"{f:5}ブレインロット", "{s:0.7}Brain Rot"},
				text = {
					"Create a {C:attention}Stone{} copy",
					"of destroyed cards",
					"{C:inactive,s:0.8,f:5}Brain rot　もっと　灰になるまでHigh"
				}
			},
			j_synthb_shrimp_fried_rice = {
				name = {"{f:5}エビチャーハン!", "{s:0.7}You're Telling Me A SHRIMP Fried This Rice?!"},
				text = {
					"Unscored cards give",
					"{C:chips}+#1#{} chips",
					"Loses {C:chips}+#2#{} chips",
					"per card scored",
					"{C:inactive,s:0.8}THIS IS A CERTIFIED SHRIMP"
				}
			},
			j_synthb_disclose_flick = {
				name = {"{f:5}ディスクローズ・フリック", "{s:0.7}Disclose Flick"},
				text = {
					"This Joker gains {X:chips,C:white}X#1#{} Chips",
					"when a {C:tarot}#2#{} is used",
					"and {X:mult,C:white}X#3#{} Mult",
					"when a {C:tarot}#4#{} is used",
					"{C:inactive}[Currently {X:chips,C:white}X#5#{C:inactive} Chips and {X:mult,C:white}X#6#{C:inactive} Mult]",
					"{C:inactive,s:0.8,f:5}絶対的正義 始終判定"
				}
			},
			j_synthb_copycat = {
				name = "Copycat",
				text = {
					"Cards with {C:attention}#1#{} suit held in hand",
					"convert the card to their {C:attention}left",
					"into a {C:attention}copy{} of themselves",
					"at end of round",
					"Suit changes at end of round",
					"{C:inactve,s:0.8}Copy that, Copycat"
				}
			},
			j_synthb_kyu_kurarin = {
				name = {"{f:5}きゅうくらりん", "{s:0.7}Kyu-kurarin"},
				text = {
					"This Joker gains {C:chips}+#1#{} Chips",
					"when a playing card is {C:red}destroyed",
					"{C:inactive}[Currently {C:chips}+#2#{C:inactive} Chips]",
					"{C:inactive,s:0.8,f:5}わたし　ちゅうぶらりん"
				}
			},
			j_synthb_medicine = {
				name = {"{f:5}イガク", "{s:0.7}Medicine"},
				text = {
					"All played {C:attention}Face{} cards",
					"become {C:attention}Steel{} cards",
					"when scored",
					"{C:inactive,s:0.8,f:5}カオが→鈍器になっちゃうヨ"
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
					"{f:5}舞{C:inactive} & {}Choir Voices #1#",
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
					"{f:5}重音テト{C:inactive} & {f:5}初音ミク",
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
					"{f:5}いますぐ輪廻",
					"{C:inactive,s:0.8}Retry Now",
					"{C:attention}Producer:",
					"{f:5}なきそ",
					"{C:inactive,s:0.8}Nakiso",
					"{C:attention}Voice:",
					"{f:5}初音ミク",
					"{C:inactive,s:0.8}Hatsune Miku"
				}
			},
			fire_dance = {
				text = {
					"{C:attention}Title",
					"{f:5}ファイアダンス",
					"{C:inactive,s:0.8}Fire Dance",
					"{C:attention}Producer:",
					"{f:5}デコニーナ{C:inactive} & {f:5}ギガ",
					"{C:inactive,s:0.8}Deco*27 & Giga",
					"{C:attention}Voice:",
					"{f:5}初音ミク{C:inactive} & {f:5}鏡音レン{C:inactive} & {f:5}カイト{C:inactive} & {f:5}メイコ",
					"{C:inactive,s:0.8}Hatsune Miku & Kagamine Len & KAITO & MEIKO"
				}
			},
			king = {
				text = {
					"{C:attention}Title",
					"KING",
					"{C:attention}Producer:",
					"Kanaria",
					"{C:attention}Voice:",
					"{f:5}グミ",
					"{C:inactive,s:0.8}GUMI"
				}
			},
			birdbrain = {
				text = {
					"{C:attention}Title:",
					"Birdbrain",
					"{C:attention}Producer:",
					"Jamie Paige {C:inactive}&{} OK Glass",
					"{C:attention}Voice:",
					"{f:5}重音テト",
					"{C:inactive,s:0.8}Kasane Teto"
				}
			},
			brainrot = {
				text = {
					"{C:attention}Title:",
					"{f:5}ブレインロット",
					"{C:inactive,s:0.8}Brain Rot",
					"{C:attention}Producer:",
					"{f:5}東京真中",
					"{C:inactive,s:0.8}Tokyo Manaka",
					"{C:attention}Voice:",
					"{f:5}重音テト",
					"{C:inactive,s:0.8}Kasane Teto"
				}
			},
			shrimp_fried_rice = {
				text = {
					"{C:attention}Title:",
					"{f:5}エビチャーハン!",
					"{C:inactive,s:0.8}You're Telling Me A SHRIMP Fried This Rice?!",
					"{C:attention}Producer:",
					"Jamie Paige",
					"{C:attention}Voice:",
					"{f:5}{f:5}初音ミク",
					"{C:inactive,s:0.8}Hatsune Miku"
				}
			},
			disclose_flick = {
				text = {
					"{C:attention}Title:",
					"{f:5}ディスクローズ・フリック",
					"{C:inactive,s:0.8}Disclose Flick",
					"{C:attention}Producer:",
					"{f:5}柊マグネタイト",
					"{C:inactive,s:0.8}Hiiragi Magnetite",
					"{C:attention}Voice:",
					"{f:5}重音テト",
					"{C:inactive,s:0.8}Kasane Teto"
				}
			},
			copycat = {
				text = {
					"{C:attention}Title:",
					"Copycat",
					"{C:attention}Producer:",
					"CircusP",
					"{C:attention}Voice:",
					"{f:5}グミ",
					"{C:inactive,s:0.8}GUMI"
				}
			},
			kyu_kurarin = {
				text = {
					"{C:attention}Title:",
					"{f:5}きゅうくらりん",
					"{C:inactive,s:0.8}Kyu-kurarin",
					"{C:attention}Producer:",
					"{f:5}いよわ",
					"{C:inactive,s:0.8}Iyowa",
					"{C:attention}Voice:",
					"{f:5}可不",
					"{C:inactive,s:0.8}KAFU"
				}
			},
			medicine = {
				text = {
					"{C:attention}Title:",
					"{f:5}イガク",
					"{C:inactive,s:0.8}Medicine",
					"{C:attention}Producer:",
					"{f:5}原口沙輔",
					"{C:inactive,s:0.8}Sasuke Haraguchi",
					"{C:attention}Voice:",
					"{f:5}重音テト",
					"{C:inactive,s:0.8}Kasane Teto"
				}
			}
		},
		Edition = {
			e_synthb_cover_miku = {
				name = "Miku Cover",
				text = {
					"Any {C:mult}Mult{} this card",
					"scores is replaced",
					"with {C:attention}#1#x{} its",
					"value in {C:chips}Chips"
				}
			},
			e_synthb_cover_teto = {
				name = "Teto Cover",
				text = {
					"Any {C:chips}Chips{} this card",
					"scores is replaced",
					"with {C:attention}1/#1#{} its",
					"value in {C:mult}Mult"
				}
			},
			e_synthb_cover_kaito = {
				name = "KAITO Cover",
				text = {
					"Any {C:mult}Mult{} this card",
					"scores is replaced",
					"with {C:attention}1/#1#{} its",
					"value in {X:chips,C:white}XChips"
				}
			},
			e_synthb_cover_meiko = {
				name = "MEIKO Cover",
				text = {
					"Any {C:chips}Chips{} this card",
					"scores is replaced",
					"with {C:attention}1/#1#{} its",
					"value in {X:mult,C:white}XMult"
				}
			}
		}
	},
	misc = {
		dictionary = {
			ph_retry_now = "いますぐ輪廻 今回も結ばれないね"
		},
		labels = {
			synthb_cover_miku = "Miku Cover",
			synthb_cover_teto = "Teto Cover",
			synthb_cover_kaito = "KAITO Cover",
			synthb_cover_meiko = "MEIKO Cover",
		}
	}
}

for _, content in pairs(descriptions.descriptions.SongInfo) do
	content.name = "Song Info"
end

return descriptions