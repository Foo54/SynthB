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
					{
						"Raise the {C:temperature}Temperature{} by {X:temperature,C:white}#1#C",
						"when a playing card is destroyed",
						"{C:inactive,s:0.8,f:5}もっと美味しく出来るハズだから"
					},
					{
						"{X:temperature,C:white}#2#{C:green} in #3#{} chance",
						"to upgrade {C:attention}poker hand{} twice",
						"when a {C:planet}Planet{} card is used",
						"{C:inactive,s:0.8,f:5}もう遅いのはわかってるよ"
					},
					{
						"{C:attention}Use{} this card to",
						"upgrade the selected",
						"{C:attention}poker hand",
						"and lower the {C:temperature}Temperature",
						"by {X:temperature,C:white}#4#C",
						"{C:inactive,s:0.8,f:5}食べれないことないけどさ"
					}
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
					{
						"Raise the {C:temperature}Temperature{} by {X:temperature,C:white}#8#C",
						"when hand catches on fire",
						"{C:inactive,s:0.8,f:5}やばBADなBURNOUTぶっかます番だ"
					},
					{
						"{C:red}-#1#{} hand size",
						"{C:blue}+#2#{} hand size per {X:temperature,C:white}#3#C",
						"{C:inactive}[Currently {C:blue}+#7#{C:inactive} hand size]",
						"{C:inactive,s:0.8}Wake up, Get up, Stand up, MERA"
					},
					{
						"{C:attention}Use{} this card to",
						"increase the rank of",
						"up to {C:attention}#4#{} selected",
						"cards by {C:attention}#5#",
						"and lower the {C:temperature}Temperature",
						"by {X:temperature,C:white}#6#C",
						"{C:inactive,s:0.8,f:5}ガンガン登る今は何合目？"
					}
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
					"{C:inactive,s:0.8}Copy that, Copycat"
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
					"{C:attention}Face{} cards have no suit or rank,",
					"always score, and give {C:mult}+#1#{} Mult",
					"{C:inactive,s:0.8,f:5}カオが→鈍器になっちゃうヨ"
				}
			},
			j_synthb_internet_is_mine = {
				name = "Internet is Mine",
				text = {
					"Played and unscored {C:attention}Queens{}",
					"give {X:mult,C:white}X#1#{} Mult",
					"{C:inactive,s:0.8}I'm a queen, you can't beat"
				}
			},
			j_synthb_glass_girl = {
				name = "Glass Girl",
				text = {
					"Cards held in hand",
					"become {C:attention}Steel{} cards",
					"when {C:attention}2{} adjacent",
					"{C:attention}Glass{} cards shatter",
					"{C:inactive,s:0.8}Ooh girls made of glass,",
					"{C:inactive,s:0.8}our hearts full of lithium"
				}
			},
			j_synthb_monitoring = {
				name = {"{f:5}モニタリング", "{s:0.7}Monitoring"},
				text = {
					"If played hand contains",
					"exactly {C:attention}1{} card,",
					"that card will {C:attention}always",
					"be drawn on the first hand of round.",
					"This effect {C:red}stops",
					"if the card is not {C:attention}scored",
					"in the first played hand",
					"{C:inactive,s:0.8,f:5}何度だって受け止めてあげる"
				}
			},
			j_synthb_six_trillion = {
				name = {"{f:5}六兆年と一夜物語", "Six Trillion Years and Overnight Story"},
				text = {
					"Destroy all played",
					"cards in {C:attention}final",
					"{C:attention}hand{} of round",
					"This Joker gains {C:attention}1/3rd{}",
					"of the {C:attention}Chips{} and {C:attention}Mult",
					"those cards scored",
					"{C:inactive}[Currently {C:chips}+#1#{C:inactive} Chips and {C:mult}+#2#{C:inactive} Mult]",
					"{C:inactive,s:0.8,f:5}夕焼けの中に吸い込まれて消えてった"
				}
			},
			j_synthb_miku = {
				name = "Miku",
				text = {
					"{C:chips}+#1#{} Chips",
					"This card can always appear",
					"and does not take",
					"up a joker slot",
					"{C:inactive,s:0.8}Blue hair, blue tie, hiding in your wifi"
				}
			},
			j_synthb_matryoshka = {
				name = {"{f:5}マトリョシカ", "{s:0.7}Matryoshka"},
				text = {
					"{C:green}#1# in #2#{} chance to gain",
					"{C:blue}+#3#{} hands if played",
					"hand has exactly {C:attention}4{} cards",
					"{C:inactive,s:0.8,f:5}いつまで経っても針は四時"
				}
			},

			-- Page 3

			j_synthb_spot_late = {
				name = {"{f:5}スポットレイト", "{s:0.7}Spot Late"},
				text = {
					{
						"This Joker gains",
						"{C:mult}+#1#{} Mult per",
						"hand played if it's",
						"not the {C:attention}leftmost{} joker",
						"and loses {C:mult}+#1#{} Mult",
						"otherwise",
						"{C:inactive}[Currently {C:mult}+#2#{C:inactive} Mult]"
					},
					{
						"Only scores when",
						"this joker is",
						"the {C:attention}leftmost{} joker",
						"{C:inactive,s:0.8,f:5}あたし以外の概念で放置した分だけ"
					}
				}
			},
			j_synthb_heat_abnormal = {
				name = {"{f:5}熱異常", "{s:0.7}Heat Abnormal"},
				text = {
					{
						"Raise the {C:temperature}Temperature{} by {X:temperature,C:white}#4#C",
						"when playing cards are scored",
						"{C:inactive,s:0.8,f:5}数え事が孕んだ熱"
					},
					{
						"{C:chips}+#1#{} Chips per {X:temperature,C:white}1C{}",
						"{C:inactive}[Currently {C:chips}+#3#{C:inactive} Chips]",
						"{C:inactive,s:0.8,f:5}すぐそこまで",
					},
					{
						"Use this card to",
						"{C:attention}enhance{} all cards held in hand",
						"and lower the {C:temperature}Temperature",
						"by {X:temperature,C:white}#2#C",
						"{C:inactive,s:0.8,f:5}死んだ変数で繰り返す"
					}
				}
			},
			j_synthb_spoken_for = {
				name = "Spoken For",
				text = {
					"{C:mult}+/- #1#{} Mult",
					"{C:inactive,s:0.8}I could be a friend,",
					"{C:inactive,s:0.8}or I could be a foe"
				}
			},
			j_synthb_hello_world = {
				name = "Hello, World!",
				text = {
					{
						"The {C:attention}top{} card",
						"of your deck",
						"is visible below.",
						"{C:attention}Use{} this card",
						"to move the {C:attention}top",
						"card of deck",
						"to the {C:attention}bottom",
						"{C:inactive}Once per round",
						"{C:inactive,s:0.8,f:5}ハロー　どうも　僕はここ"
					},
					{
						" {element:1} "
					}
				}
			},
			j_synthb_clone_clone = {
				name = {"{f:5}クローンクローン", "{s:0.7}Clone Clone"},
				text = {
					"{C:green}#1# in #2#{} chance to duplicate",
					"scored cards, with a fixed",
					"{C:green}25%{} chance to become",
					"{C:attention}fake",
					"{C:inactive,s:0.8,f:5}何が真実で虚構かを"
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
			},
			internet_is_mine = {
				text = {
					"{C:attention}Title:",
					"Internet is Mine",
					"{C:attention}Producer:",
					"Nocticola, aleon, Treb",
					"{C:attention}Voice:",
					"{f:5}{f:5}初音ミク",
					"{C:inactive,s:0.8}Hatsune Miku"
				}
			},
			glass_girl = {
				text = {
					"Glass Girl",
					"{C:attention}Producer:",
					"eggtan {C:inactive}&{} Jamie Paige",
					"{C:attention}Voice:",
					"{f:5}足立レイ",
					"{C:inactive,s:0.8}Adachi Rei"
				}
			},
			monitoring = {
				text = {
					"{C:attention}Title",
					"{f:5}モニタリング",
					"{C:inactive,s:0.8}Monitoring",
					"{C:attention}Producer:",
					"{f:5}デコニーナ",
					"{C:inactive,s:0.8}Deco*27",
					"{C:attention}Voice:",
					"{f:5}初音ミク",
					"{C:inactive,s:0.8}Hatsune Miku"
				}
			},
			six_trillion = {
				text = {
					"{C:attention}Title",
					"{f:5}六兆年と一夜物語",
					"{C:inactive,s:0.8}Six Trillion Years and Overnight Story",
					"{C:attention}Producer:",
					"kemu",
					"{C:attention}Voice:",
					"{f:5}イア",
					"{C:inactive,s:0.8}IA"
				}
			},
			miku = {
				text = {
					"{C:attention}Title:",
					"Miku",
					"{C:attention}Producer:",
					"Anamanaguchi",
					"{C:attention}Voice:",
					"{f:5}{f:5}初音ミク",
					"{C:inactive,s:0.8}Hatsune Miku"
				}
			},
			matryoshka = {
				text = {
					"{C:attention}Title",
					"{f:5}マトリョシカ",
					"{C:inactive,s:0.8}Matryoshka",
					"{C:attention}Producer:",
					"{f:5}ハチ",
					"{C:inactive,s:0.8}Hachi",
					"{C:attention}Voice:",
					"{f:5}初音ミク{C:inactive} & {f:5}グミ",
					"{C:inactive,s:0.8}Hatsune Miku & GUMI"
				}
			},
			spot_late = {
				text = {
					"{C:attention}Title:",
					"{f:5}スポットレイト",
					"{C:inactive,s:0.8}Spot Late",
					"{C:attention}Producer:",
					"{f:5}稲葉曇",
					"{C:inactive,s:0.8}inabakumori",
					"{C:attention}Voice:",
					"{f:5}歌愛ユキ",
					"{C:inactive,s:0.8}Kaai Yuki"
				}
			},
			heat_abnormal = {
				text = {
					"{C:attention}Title:",
					"{f:5}熱異常",
					"{C:inactive,s:0.8}Heat Abnormal",
					"{C:attention}Producer:",
					"{f:5}いよわ",
					"{C:inactive,s:0.8}Iyowa",
					"{C:attention}Voice:",
					"{f:5}足立レイ",
					"{C:inactive,s:0.8}Adachi Rei"
				}
			},
			spoken_for = {
				text = {
					"{C:attention}Title:",
					"Spoken For",
					"{C:attention}Producer:",
					"Flavor Foley",
					"{C:attention}Voice:",
					"{f:5}重音テト",
					"{C:inactive,s:0.8}Kasane Teto"
				}
			},
			hello_world = {
				text = {
					"{C:attention}Title:",
					"Hello, World!",
					"{C:attention}Producer:",
					"{f:5}藤原基央",
					"{C:inactive,s:0.8}Motoo Fujiwara",
					"{C:attention}Voice:",
					"{f:5}{f:5}初音ミク",
					"{C:inactive,s:0.8}Hatsune Miku"
				}
			},
			clone_clone = {
				text = {
					"{C:attention}Title:",
					"{f:5}クローンクローン",
					"{C:inactive,s:0.8}Clone Clone",
					"{C:attention}Producer:",
					"{f:5}アテナ",
					"{C:inactive,s:0.8}Atena",
					"{C:attention}Voice:",
					"{f:5}グミ{C:inactive} & {f:5}鏡音リン",
					"{C:inactive,s:0.8}GUMI & Kagamine Rin"
				}
			}
		},
		MiscInfoQueue = {
			idea_credits = {
				name = "Concept",
				text = {
					"#1#"
				}
			},
			heat_explanation = {
				name = "The Temperature Mechanic",
				text = {
					"{C:temperature}Temperature{} is a resource that is",
					"generated by heat related cards.",
					"{C:inactive}-- -- -- --",
					"References to {C:temperature}Temperature{} values is denoted",
					"with a {X:temperature,C:white}Orange{} background, often followed by a {X:temperature,C:white}C{}.",
					"{C:inactive}-- -- -- --",
					"Some cards may be {C:attention}Used{} at the cost",
					"of an amount of {C:temperature}Temperature{}.",
					"They will not be destroyed unless specified otherwise.",
					"{C:inactive}-- -- -- --",
					"{C:temperature}Temperature{} can be viewed in the {C:attention}bottom-left",
					"of your screen by hovering over the thermometer",
					"{C:inactive}-- -- -- --",
					"{C:red,E:2}Negative{} effects will occur",
					"if {C:temperature}Temperature{} rises to over {X:temperature,C:white}100C{},",
					"including reductions to {C:chips}Chips{} and {C:mult}Mult{},",
					"losing {C:money}money{} at end of round",
					"cards being {C:red}debuffed{}, and hands not scoring",
					"{C:inactive}-- -- -- --",
					"{C:temperature}Temperature{} will decrease by {X:temperature,C:white}1C",
					"when entering the shop",
					"{C:inactive}-- -- -- --",
					"This information can be disabled in the mod",
					"config page"
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
		},
		Other = {
			synthb_fake = {
				name = "Fake Card",
				text = {
					"This card cannot score"
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
			synthb_fake = "Fake Card",
		}
	}
}

for _, content in pairs(descriptions.descriptions.SongInfo) do
	content.name = "Song Info"
end

return descriptions