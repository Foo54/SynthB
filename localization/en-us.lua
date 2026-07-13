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
					"This Joker gains {C:mult}+#1#{} Mult",
					"when a playing card is {C:red}destroyed",
					"{C:inactive}[Currently {C:mult}+#2#{C:inactive} Mult]",
					"{C:inactive,s:0.8,f:5}わたし　ちゅうぶらりん"
				}
			},
			j_synthb_medicine = {
				name = {"{f:5}イガク", "{s:0.7}Medicine"},
				text = {
					"{C:attention}Face{} cards have no rank,",
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
			j_synthb_spoken_for_mult = {
				name = "Spoken For",
				text = {
					"{C:mult}+#1#{} Mult",
					"{C:inactive,s:0.8}I could be a friend,"
				}
			},
			j_synthb_spoken_for_chips = {
				name = "Spoken For",
				text = {
					"{C:chips}+#1#{} Chips",
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
						"to destroy the {C:attention}top",
						"card of deck",
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
			},
			j_synthb_im_the_rain = {
				name = {"{f:5}私は雨", "{s:0.7}I'm the Rain"},
				text = {
					"{C:green}#1# in #2#{} chance to",
					"create a {C:tarot}Tarot{} card",
					"when a card's rank changes",
					"{C:inactive,s:0.8,f:5}セカイ的気候変動"
				}
			},
			j_synthb_parry = {
				name = {"{f:5}パリィ", "{s:0.7}Parry"},
				text = {
					"{C:attention}Glass{} cards become",
					"{C:attention}Gold{} cards instead",
					"of being destroyed",
					"{C:inactive,s:0.8,f:5}グラス割ってぶちまける"
				}
			},
			j_synthb_nyan_cat = {
				name = "Nyanyanyanyanyanyanya!",
				text = {
					"{X:mult,C:white}X#1#{} Mult per suit",
					"in {C:attention}scoring{} hand",
					"{C:inactive,s:0.8}Yes I know this is a cover of a miku song"
				}
			},
			j_synthb_dna = {
				name = "D/N/A",
				text = {
					"If {C:attention}first hand{} of round",
					"has only {C:attention}1{} card,",
					"Create a {C:attention}linked{} copy of it",
					"{C:inactive,s:0.8,f:5}繋がれたまま　夢を見る"
				}
			},
			j_synthb_character_t = {
				name = {"{f:5}キャラクターT", "{s:0.7}Character T"},
				text = {
					"Create a {C:garfields_thanksgiving}Teto{} Joker",
					"when {C:attention}selecting blind",
					"{C:inactive}[Must have room]",
					"{C:inactive,s:0.8,f:5}何もない時代から生まれて"
				}
			},
			j_synthb_feedback = {
				name = "FEEDBACK",
				text = {
					"This Joker gains {C:mult}+#2#{} mult",
					"if {C:attention}scored hand{} contains",
					"a {C:attention}Wild Ace{} of {C:spades}Spades{}",
					"{C:inactive}[Currently {C:mult}+#1#{C:inactive} Mult]",
					"{C:inactive,s:0.8}We'll shout until the speakers blow out"
				}
			},
			j_synthb_tell_your_world = {
				name = "Tell Your World",
				text = {
					{
						"Create {C:tarot}#1#",
						"when {C:attention}Blind{} is selected",
						"{C:inactive}[Must have room]",
						"{C:inactive,f:5,s:0.8}君に届けたいことが"
					},
					{
						"Cards targeted by {C:tarot}#1#",
						"become {C:attention}linked{} for {C:attention}#2#{} rounds",
						"{C:inactive,f:5,s:0.8}いくつもの線は円になって"
					}
				}
			},
			j_synthb_shanti = {
				name = {"{f:5}シャンティ", "{s:0.8}SHANTI"},
				text = {
					"Prevents Death,",
					"takes {C:red}$#1#{}, and doubles fee",
					"if at least {C:attention}50%{} of",
					"required chips are scored",
					"and you are not in debt",
					"{C:inactive,f:5,s:0.8}金ならまた今度でいいさ"
				}
			},
			j_synthb_human = {
				name = "Human",
				text = {
					"All {C:diamonds}Diamonds{} are",
					"considered {C:attention}Face{} cards",
					"{C:inactive,s:0.8}Why do you like the stars?"
				}
			},
			j_synthb_brain_implosion_energy = {
				name = "Brain Implosion Energy Drink",
				text = {
					"Create an {C:synthb_drink}Energy Drink{} tag",
					"when {C:attention}Shop{} is entered",
					"{C:inactive,s:0.8}10,000g of pure caffine!"
				}
			},

			-- Page 4
			j_synthb_shiawase_for_you = {
				name = "SHIAWASE FOR YOU",
				text = {
					"do something idk"
				}
			},
			j_synthb_blackjack = {
				name = "Blackjack",
				text = {} -- this cards UI is handled with main_end
			},
			j_synthb_dance_delightful = {
				name = "Dance Delightful",
				text = {
					"{C:attention}Adjacent{} Jokers have {X:attention,C:white}X#1#{} values",
					"{C:inactive,s:0.8}I'll find the point where the two paths meet"
				}
			},
			j_synthb_yararara = {
				name = {"{f:5}ヤラララ", "{s:0.7}YARARARA"},
				text = {
					"After scoring {C:attention}#1#{} and",
					"discarding {C:attention}#2#{} cards,",
					"create a {C:dark_edition}negative{} copy",
					"of a random Joker",
					"{C:red,E:2}Self Destructs",
					"{C:inactive}[#3# of #1#, #4# of #2#]",
					"{C:inactive,s:0.8,f:5}ヤラララ、程遠くても"
				}
			},
			j_synthb_needle = {
				name = "needLe",
				text = {
					"Prevents {C:hearts}Hearts{} from being destroyed",
					"{C:green}#1# in #2#{} chance to fail",
					"{C:inactive,s:0.8,f:5}簡単に愛は終わらないよ"
				}
			},
			j_synthb_pink = {
				name = "Pink",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
					"After scoring {C:attention}#2#{} {C:hearts}Hearts{}",
					"outside of flushes,",
					"this Joker splits into",
					"{C:attention}Body{} and {C:attention}Ghost",
					"{C:inactive}[#3#/#2# scored]",
					"{C:inactive,f:5,s:0.8}全力で突き進めばいいのキューティ革命"
				}
			},
			j_synthb_pink_body = {
				name = "Pink's Body",
				text = {
					"This Joker gains {X:mult,C:white}X#1#{} Mult",
					"if played non-flush contains a {C:attention}Heart",
					"{C:inactive}[Currently {X:mult,C:white}X#2#{C:inactive}]",
					"{C:inactive,f:5,s:0.8}歌詞わからねー"
				}
			},
			j_synthb_pink_ghost = {
				name = "Pink's Ghost",
				text = {
					"Use this Joker to",
					"possess Joker to the left.",
					"{C:inactive}Cannot Possess Pink's Ghost",
					"{C:inactive,f:5,s:0.8}世界殺戮　今度は水中"
				}
			},
			j_synthb_pink_ghost_possessing = {
				name = "Pink's Ghost",
				text = {
					"Use this Joker to",
					"STOP possessing current Joker.",
					"{C:inactive,f:5,s:0.8}世界殺戮　今度は水中" -- so evil
				}
			},
			j_synthb_affection_addiction = {
				name = "Affection Addiction",
				text = {
					"This Joker gains {X:mult,C:white}X#1#{} mult",
					"per {C:attention}consecutive{} hand played scoring",
					"{C:attention}greater{} than the previous hand {C:inactive}(#3#)",
					"{C:inactive}[Currently {X:mult,C:white}X#2#{C:inactive}]",
					"{C:inactive,s:0.8}But I can't survive without the high"
				}
			},
			j_synthb_on_the_rocks_1 = {
				name = "on the rocks",
				text = {
					{
						"{X:red,C:white}X#1#{} Mult",
						"Ability flips every round",
						"{C:inactive,s:0.8,f:5}今日はシングルよりダブルで",
					},
					{
						"{C:attention}Use{} this card to",
						"one selected card",
						"in hand to a {C:attention}Glass Card",
						"and lower the {C:temperature}Temperature",
						"by {X:temperature,C:white}#3#C",
						"{C:inactive,s:0.8,f:5}グラス越しに見える世界は"
					}
				}
			},
			j_synthb_on_the_rocks_2 = {
				name = "on the rocks",
				text = {
					{
						"{X:temperature,C:white}+#2#C",
						"Ability flips every round",
						"{C:inactive,s:0.8,f:5}喉元から熱く灼いて"
					},
					{
						"{C:attention}Use{} this card to",
						"one selected card",
						"in hand to a {C:attention}Glass Card",
						"and lower the {C:temperature}Temperature",
						"by {X:temperature,C:white}#3#C",
						"{C:inactive,s:0.8,f:5}グラス越しに見える世界は"
					}
				}
			},
			j_synthb_npc = {
				name = "NPC",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
					"{C:inactive,s:0.8,f:5}それもどれもなにもかも中途半端"
				}
			},

			--- spoilers
			j_synthb_spoiler = {
				name = "SPOILER",
				text = {
					"This card is a spoiler for",
					"#1#",
					"It will not show up in gameplay"
				}
			},

			--- Crossmod
			j_synthb_weathergirl = {
				name = "Weathergirl",
				text = {
					"{C:green}#1# in n{} chance for",
					"played cards to become {C:attention}#2#s{},",
					"where {C:green}n{} is the position of the card",
					"{C:inactive}1st card: 1 in 1, 5th card: 1 in 5",
					"{C:inactive,s:0.8}I heard they said it looked like rain"
				}
			}, -- aikoshen
			j_synthb_smokey_love = {
				name = {"{f:5}導火愛", "{s:0.7}Smokey Love"},
				text = {
					"Destroy scoring cards",
					"Between {C:attention}2{} scoring {C:hearts}Hearts",
					"{C:inactive,f:5,s:0.8}繋いだ導火愛　濡らしたままで"
				}
			}, -- Bad Director
			j_synthb_marshmallow = {
				name = {"{f:5}temp", "Marshmallow"},
				text = {
					"also do something"
				}
			}, -- Bad Director

			--- Credits
			j_synthb_credits_foo54 = {
				name = "Foo54",
				text = {
					"Mike, rebuild my kids!"
				}
			},
			j_synthb_credits_pepix = {
        name = 'Pepix',
        text = {
					'Look, its {E:1,C:green}Pepix{}!',
					'it {C:attention}creates{} a {C:dark_edition}Negative{}',
					'{C:attention}Machine love{} when {C:attention}Blind{} is selected'
        },
			},
			j_synthb_credits_pepix_2 = {
				name = "Pepix",
				text = {
					"play balatro refreshed, trust me, its peak"
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
					"{C:attention}Title:",
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
			},
			im_the_rain = {
				text = {
					"{C:attention}Title:",
					"{f:5}私は雨",
					"{C:inactive,s:0.8}I'm the Rain",
					"{C:attention}Producer:",
					"{f:5}稲葉曇",
					"{C:inactive,s:0.8}inabakumori",
					"{C:attention}Voice:",
					"{f:5}歌愛ユキ{C:inactive} & {f:5}初音ミク",
					"{C:inactive,s:0.8}Kaai Yuki & Hatsune Miku"
				}
			},
			parry = {
				text = {
					"{C:attention}Title",
					"{f:5}パリィ",
					"{C:inactive,s:0.8}Parry",
					"{C:attention}Producer:",
					"{f:5}宮守文学",
					"{C:inactive,s:0.8}Miyamori Bungaku",
					"{C:attention}Voice:",
					"{f:5}鏡音レン{C:inactive} & {f:5}鏡音リン",
					"{C:inactive,s:0.8}Kagamine Len & Kagamine Rin"
				}
			},
			nyan_cat = {
				text = {
					"{C:attention}Title",
					"Nyanyanyanyanyanyanya!",
					"{C:attention}Producer:",
					"{f:5}ももももP",
					"{C:inactive,s:0.8}momomomo-P",
					"{C:attention}Voice:",
					"{f:5}桃音モモ",
					"{C:inactive,s:0.8}Momo Momone"
				}
			},
			dna = {
				text = {
					"{C:attention}Title",
					"D/N/A",
					"{C:attention}Producer:",
					"Azari",
					"{C:attention}Voice:",
					"{f:5}重音テト{C:inactive} & {}flower",
					"{C:inactive,s:0.8}Kasane Teto"
				}
			},
			character_t = {
				text = {
					"{C:attention}Title:",
					"{f:5}キャラクターT",
					"{C:inactive,s:0.8}Character T",
					"{C:attention}Producer:",
					"{f:5}アテナ",
					"{C:inactive,s:0.8}Atena",
					"{C:attention}Voice:",
					"{f:5}重音テト{C:inactive} & {f:5}重音テト",
					"{C:inactive,s:0.8}Kasane Teto & Kasane Teto"
				}
			},
			feedback = {
				text = {
					"{C:attention}Title:",
					"FEEDBACK",
					"{C:attention}Producer:",
					"MonochroMenace{C:inactive} & {}isidore",
					"{C:attention}Voice:",
					"{f:5}巡音ルカ",
					"{C:inactive,s:0.8}Megurine Luka"
				}
			},
			tell_your_world = {
				text = {
					"{C:attention}Title:",
					"Tell Your World",
					"{C:attention}Producer:",
					"kz(livetune)",
					"{C:attention}Voice:",
					"{f:5}初音ミク",
					"{C:inactive,s:0.8}Hatsune Miku"
				}
			},
			weathergirl = {
				text = {
					"{C:attention}Title:",
					"Weathergirl",
					"{C:attention}Producer:",
					"Flavor Foley",
					"{C:attention}Voice:",
					"Eleanor Forte" -- shortest song info woah
				}
			},
			brain_implosion_energy = {
				text = {
					"{C:attention}Title:",
					"Brain Implosion Energy Drink",
					"{C:attention}Producer:",
					"Flanger Moose",
					"{C:attention}Voice:",
					"{f:5}重音テト{C:inactive} & {}Eleanor Forte",
					"{C:inactive,s:0.8}Kasane Teto"
				}
			},
			shanti = {
				text = {
					"{C:attention}Title",
					"{f:5}シャンティ",
					"{C:inactive,s:0.8}SHANTI",
					"{C:attention}Producer:",
					"{f:5}ヲタク",
					"{C:inactive,s:0.8}wotaku",
					"{C:attention}Voice:",
					"{f:5}カイト",
					"{C:inactive,s:0.8}KAITO"
				}
			},
			human = {
				text = {
					"{C:attention}Title:",
					"Human",
					"{C:attention}Producer:",
					"Flavor Foley",
					"{C:attention}Voice:",
					"{f:5}temp{C:inactive} & {f:5}temp",
					"{C:inactive,s:0.8}SF-A2 miki & Hiyama Kiyoteru"
				}
			},
			blackjack = {
				text = {
					"{C:attention}Title:",
					"Blackjack",
					"{C:attention}Producer:",
					"{f:5}ゆちゃ{C:inactive} & {f:5}ダルビッシュP{C:inactive} & {f:5}かいち",
					"{C:inactive}YuchaP & DarvishP & kaichi",
					"{C:attention}Voice:",
					"{f:5}巡音ルカ",
					"{C:inactive,s:0.8}Megurine Luka"
				}
			},
			dance_delightful = {
				text = {
					"{C:attention}Title:",
					"Dance Delightful",
					"{C:attention}Producer:",
					"Jamie Paige",
					"{C:attention}Voice:",
					"{f:5}足立レイ",
					"{C:inactive,s:0.8}Adachi Rei"
				}
			},
			smokey_love = {
				text = {
					"{C:attention}Title:",
					"{f:5}導火愛",
					"{C:inactive,s:0.8}Smokey Love",
					"{C:attention}Producer:",
					"Tonbi",
					"{C:attention}Voice:",
					"{f:5}メイコ",
					"{C:inactive,s:0.8}MEIKO"
				}
			},
			needle = {
				text = {
					"{C:attention}Title",
					"needLe",
					"{C:attention}Producer:",
					"{f:5}デコニーナ",
					"{C:inactive,s:0.8}Deco*27",
					"{C:attention}Voice:",
					"{f:5}初音ミク",
					"{C:inactive,s:0.8}Hatsune Miku"
				}
			},
			shiawase_for_you = {
				text = {
					"{C:attention}Title:",
					"SHIAWASE FOR YOU",
					"{C:attention}Producer:",
					"{f:5}いよわ",
					"{C:inactive,s:0.8}Iyowa",
					"{C:attention}Voice:",
					"{f:5}初音ミク",
					"{C:inactive,s:0.8}Hatsune Miku"
				}
			},
			yararara = {
				text = {
					"{C:attention}Title:",
					"{f:5}ヤラララ",
					"{C:inactive,s:0.8}YARARARA",
					"{C:attention}Producer:",
					"AnythingBecomeMoe",
					"{C:attention}Voice:",
					"{f:5}重音テト",
					"{C:inactive,s:0.8}Kasane Teto"
				}
			},
			approve_please_genie = {
				text = {
					"{C:attention}Title:",
					"{f:4}승인해주세요지니님!",
					"{C:inactive,s:0.8}Approve Please, Genie!",
					"{C:attention}Producer:",
					"{f:4}트랩칙",
					"{C:inactive,s:0.8}TRAP CHICK",
					"{C:attention}Voice:",
					"{f:5}重音テト{C:inactive} & {f:5}音街ウナ",
					"{C:inactive,s:0.8}Kasane Teto & Otomachi Una"
				}
			},
			pink = {
				text = {
					"{C:attention}Title:",
					"Cutie Mew Mew Magic",
					"{C:attention}Producer:",
					"{f:5}かめりあ{C:inactive} & {}Toby Fox",
					"{C:inactive,s:0.8}Camellia",
					"{C:attention}Voice:",
					"{f:5}初音ミク",
					"{C:inactive,s:0.8}Hatsune Miku"
				}
			},
			affection_addiction = {
				text = {
					"{C:attention}Title:",
					"Affection Edition",
					"{C:attention}Producer:",
					"VocaloKat{C:inactive} & {}AkuP{C:inactive} & {}Ryu{C:inactive} & {}Jamie Paige",
					"{C:attention}Voice:",
					"{f:5}ポピー",
					"{C:inactive,s:0.8}POPY"
				}
			},
			on_the_rocks = {
				text = {
					"{C:attention}Title:",
					"on the rocks",
					"{C:attention}Producer:",
					"OSTER Project",
					"{C:attention}Voice:",
					"{f:5}メイコ{C:inactive} & {f:5}カイト",
					"{C:inactive,s:0.8}MEIKO & KAITO"
				}
			},
			npc = {
				text = {
					"{C:attention}Title:",
					"NPC",
					"{C:attention}Producer:",
					"{f:5}えいぷ",
					"{C:inactive,s:0.8}Eipu",
					"{C:attention}Voice:",
					"{f:5}重音テト",
					"{C:inactive,s:0.8}Kasane Teto"
				}
			},
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
			},
			energy_drinks = {
				name = "Energy Drinks",
				text = {
					"{C:synthb_orange}Overthinking Orange",
					"{C:synthb_strawberry}Socially Anxious Strawberry",
					"{C:synthb_banana}Burnout Banana",
					"{C:synthb_raspberry}Repressed Raspberry",
					"{C:synthb_grape}Grieving Grape",
					"{C:synthb_melon}Misery Melon",
					"{C:synthb_tritip}Trauma Tri-Tip",
					"{C:synthb_durian}Depression Durian"
				}
			},
			blackjack_rules = {
				name = "Blackjack Rules",
				text = {
					"{C:attention,s:1.2,u:inactive}How to play",
					"Get as close as you can to",
					"Scoring 21 without going over to win.",
					"Your opponent will also be",
					"trying to do the same thing",
					" ",
					"{C:attention}Number{} cards are worth their value,",
					"{C:attention}Face{} cards are worth 10,",
					"and {C:attention}Aces{} are worth 1 or 11.",
					" ",
					"{C:attention,s:1.2,u:inactive}Terminology",
					"Hit{C:inactive} - {}Draw another card",
					"Stand{C:inactive} - {}Stop drawing cards",
					"Double Down{C:inactive} - {}Double your bet, hit, then stand",
					"All In{C:inactive} - {}Bet all XMult, hit, then stand"
				}
			}
		},
		Tag = {
			tag_synthb_drink_orange = {
				name = "Overthinking Orange",
				text = {
					"Next opened booster pack",
					"has {C:attention}#1#{} additional cards"
				}
			},
			tag_synthb_drink_strawberry = {
				name = "Socially Anxious Strawberry",
				text = {
					"Cards in next played hand",
					"become {C:attention}Glass{} cards"
				}
			},
			tag_synthb_drink_banana = {
				name = "Burnout Banana",
				text = {
					"Create a {C:attention}Gros Michel",
					"when entering shop",
					"{C:green}#1# in #2#{} chance to be drunk"
				}
			},
			tag_synthb_drink_raspberry = {
				name = "Repressed Raspberry",
				text = {
					"Takes and stores {C:attention}50%{} of score",
					"Click this tag to release it",
					"on the next hand played",
					"{C:inactive}[Currently holding #1# score]",
					"{C:inactive}#2#"
				}
			},
			tag_synthb_drink_grape = {
				name = "Grieving Grape",
				text = {
					"Unused discards are stored",
					"and given back in {C:attention}#1#{} round#2#",
					"{C:inactive}[Currently {C:red}+#3#{C:inactive} Discards]"
				}
			},
			tag_synthb_drink_melon = {
				name = "Misery Melon",
				text = {
					"Go up to {C:red}-$#1#{} in debt",
					"When debt limit is reached,",
					"make money {C:money}positive"
				}
			},
			tag_synthb_drink_tritip = {
				name = "Trauma Tri-Tip",
				text = {
					"Create {C:attention}3{} {C:planet}Planet{} Cards",
					"for next played poker hand"
				}
			},
			tag_synthb_drink_durian = {
				name = "Depression Durian",
				text = {
					"Disable next {C:attention}Boss Blind"
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
			song_synthb_approve_please_genie = {
				name = {"{f:4}승인해주세요지니님!", "{s:0.7}Approve Please, Genie!"},
				text = {}
			},
			song_synthb_pink = {
				name = "Cutie Mew Mew Magic"
			},
			synthb_fake = {
				name = "Fake Card",
				text = {
					"This card cannot score"
				}
			},
			synthb_linked = {
				name = "Linked",
				text = {
					"Linked cards are",
					"{C:attention}Always{} scored together",
					"{C:inactive}ID: #1#"
				}
			},
			synthb_blackjack = {
				text = {
					"Play a game of {C:attention}Blackjack",
					"before scoring.",
					"Bet this cards {X:mult,C:white}XMult{}",
					"for a chance to win",
					"double it back",
					"Bet {X:mult,C:white}X0{} if you don't",
					"want to play",
					"{C:inactive}[Currently {X:mult,C:white}X#1#{C:inactive} Mult]",
					"{C:inactive,f:5,s:0.8}這いずるだけの唄"
				}
			},
			synthb_linked_temp = {
				name = "Linked",
				text = {
					"Linked cards are",
					"{C:attention}Always{} scored together",
					"{C:inactive}ID: #1#",
					"{C:inactive}Link is removed in {C:attention}#2#{C:inactive} round#3#"
				}
			},
			card_synthb_mult = {
				text = {
					"Gains {C:mult}+#1#{} Mult",
					"the next {C:attention}#2#{} #3# scored",
				}
			},
			card_synthb_chips = {
				text = {
					"Loses {C:chips}+#1#{} Chips",
					"the next {C:attention}#2#{} #3# scored",
				}
			},
			card_synthb_xmult = {
				text = {
					"Gains {X:mult,C:white}X#1#{} Mult",
					"the next {C:attention}#2#{} #3# scored",
				}
			},
			card_synthb_xchips = {
				text = {
					"Loses {X:chips,C:white}X#1#{} Chips",
					"the next {C:attention}#2#{} #3# scored",
				}
			},
			undiscovered_tuning = {
				name = "Not Discovered",
				text={
					"Purchase or use",
					"this card in an",
					"unseeded run to",
					"learn what it does"
				}
			},
			undiscovered_mistuning = {
				name = "Not Discovered",
				text={
					"Purchase or use",
					"this card in an",
					"unseeded run to",
					"learn what it does"
				}
			},
			undiscovered_synthb_character = {
				name = "Not Discovered",
				text={
					"Purchase or use",
					"this card in an",
					"unseeded run to",
					"learn what it does"
				}
			},
			synthb_utau_seal = {
				name = "UTAU Seal",
				text = {
					"Create a {C:synthb_tuning_dark}Tuning{} card",
					"if all played cards",
					"have a {C:synthb_tuning_dark}UTAU Seal",
					"{C:inactive}[Must have room]"
				}
			},
			synthb_misutau_seal = {
				name = "alUTAU Se",
				text = {
					"Create a {C:synthb_mistuning_dark}ingTun{} card",
					"per unscored card without a {C:synthb_mistuning_dark}alUTAU Se",
				}
			},
			synthb_possessed = {
				name = "Possessed",
				text = {
					"This Joker's last",
					"applied effect",
					"is repeated whenever",
					"a {C:attention}Light Suit{} is scored"
				}
			},
			
			--- Credits
			synthb_credits_foo54 = {
				text = {
					"this text won't actually appear",
					"its just here as an example"
				}
			},
			synthb_credits_pepix = {
				text = {
					"its me! {C:green}Pepix{} {C:attention}creator and artist{} of {C:blue} Balatro refreshed{}"
				}
			},

			--- Banners
			synthb_gacha_n25 = {
				name = 'Nightcord at 25:00',
				text = {
					"Pulls a random",
					"{C:attention}Nightcord at 25:00{}",
					"character for {C:money}$10"
				}
			},
			synthb_gacha_vs = {
				name = 'Virtual Singers',
				text = {
					"Pulls a random",
					"{C:attention}Virtual Signer{}",
					"character for {C:money}$10"
				}
			},
			synthb_gacha_ln = {
				name = 'Leo/Need',
				text = {
					"Pulls a random",
					"{C:attention}Leo/Need{}",
					"character for {C:money}$10"
				}
			},
			synthb_gacha_mmj = {
				name = 'More More Jump',
				text = {
					"Pulls a random",
					"{C:attention}More More Jump{}",
					"character for {C:money}$10"
				}
			},
			synthb_gacha_vbs = {
				name = 'Vivid Bad Squad',
				text = {
					"Pulls a random",
					"{C:attention}Vivid Bad Squad{}",
					"character for {C:money}$10"
				}
			},
			synthb_gacha_wxs = {
				name = 'Wonderlands x Showtime',
				text = {
					"Pulls a random",
					"{C:attention}Wonderlands x Showtime{}",
					"character for {C:money}$10"
				}
			}
		},
		synthb_Character = {
			char_synthb_miku1 = {
				name = "Hatsune Miku",
				text = {
					"The first {C:attention}#2#{} times",
					"you gain chips each hand,",
					"gain {X:chips,C:white}X#1#{} the amount"
				}
			},
			char_synthb_miku_ln = {
				name = {"Hatsune Miku", "{s:0.7}Leo/Need"},
				text = {
					"{C:attention}Poker hands{} gain an",
					"additional {X:planet,C:white}X#1#{} stats",
					"when leveled up"
				}
			},
			char_synthb_miku_mmj = {
				name = {"Hatsune Miku", "{s:0.7}More More Jump"},
				text = {
					"{C:attention}Retrigger{} the first",
					"{C:attention}#1#{} cards in hand",
					"{C:attention}#2#{} times"
				}
			},
			char_synthb_miku_vbs = {
				name = {"Hatsune Miku", "{s:0.7}Vivid Bad Squad"},
				text = {
					"Score {C:purple}#1#%{} of the",
					"blind requirement each hand"
				}
			},
			char_synthb_miku_wxs = {
				name = {"Hatsune Miku", "{s:0.7}Wonderlands X Showtime"},
				text = {
					"All sources of {C:red}Mult",
					"give at least {C:red}+#1#{} Mult"
				}
			},
			char_synthb_miku_n25 = {
				name = {"Hatsune Miku", "{s:0.7}Nightcord at 25:00"},
				text = {
					"{C:blue}+#1#{} hand#2#"
				}
			},

			char_synthb_rin1 = {
				name = "Kagamine Rin",
				text = {
					"Earn {C:money}$#1#{} extra",
					"Whenever money is gained"
				}
			},
			char_synthb_len1 = {
				name = "Kagamine Len",
				text = {
					"Lose {C:money}$#1#{} less",
					"Whenever money is lost"
				}
			},
			char_synthb_luka1 = {
				name = "Megurine Luka",
				text = {
					"This Character gains {C:chips}+#1#{} Chip#2#",
					"when other characters trigger",
					"{C:inactive}[Currently {C:chips}#3#{C:inactive} Chip#4#]"
				}
			},
			char_synthb_meiko1 = {
				name = "MEIKO",
				text = {
					"First {C:attention}#1#{} scored card#2#",
					"each round gains an {C:attention}enhancement"
				}
			},
			char_synthb_kaito1 = {
				name = "KAITO",
				text = {
					"Retriggers Character above {C:attention}#1#{} time#2#",
					"Each retrigger has a {C:green}#3# in #4#{} chance",
					"to occur"
				}
			},

			char_synthb_rin2 = {
				name = {"Kagamine Rin", "{s:0.7}More More Jump"},
				text = {
					"Earn {C:money}$#1#{} when",
					"a playing card is {C:attention}retriggered"
				}
			},
			char_synthb_len2 = {
				name = {"Kagamine Len", "{s:0.7}Vivid Bad Squad"},
				text = {
					"Each Joker gives {X:purple,C:white}X#1#{} score"
				}
			},
			char_synthb_luka2 = {
				name = {"Megurine Luka", "{s:0.7}Leo/Need"},
				text = {
					"Played Poker Hand gains {C:chips}+#1#{} chips"
				}
			},
			char_synthb_meiko2 = {
				name = {"MEIKO", "{s:0.7}Vivid Bad Squad"},
				text = {
					"If played hand would score {C:attention}less{} than",
					"last played hand {C:inactive}(#2#){}, {X:mult,C:white}X#1#{} Mult"
				}
			},
			char_synthb_kaito2 = {
				name = {"KAITO", "{s:0.7}Wonderlands X Showtime"},
				text = {
					"All scaling values are",
					"raised by {X:attention,C:white}X#1#"
				}
			},
		},
		Tarot = {
			c_synthb_tarot_treasure_hunter = {
				name = "The Treasure Hunter",
				text = {
					"Create a {C:attention}Consumable{} of the",
					"same type as the last",
					"{C:attention}Consumable{} used",
					" {element:1} ",
					"{C:inactive,s:0.8,f:5}OK! OK! あっちもこっちも大探検"
				}
			}
		},
		Spectral = {
			c_synthb_spectral_voicebank = {
				name = "Voicebank",
				text = {
					"Add a {C:synthb_tuning_dark}UTAU Seal",
					"to {C:attention}1{} selected",
					"card in your hand"
				}
			},
			c_synthb_bd_heat = {
				name = "Heat",
				text = {
					"Add {C:dark_edition}Thermal{} to",
					"a random {C:attention}Joker,",
					"{C:red}-#1#{} discard size",
					"Raise the {C:temperature}Temperature{} by {X:temperature,C:white}30C"
				},
			},
			c_synthb_spectral_wish = {
				name = "Wish",
				text = {
					"Create an {C:uncommon}Uncommon",
					"or {C:common}Common{} Joker",
					"of your choice.",
					"{C:red}-1{} consumable slot for {C:attention}3{} rounds",
					"{C:inactive}[Must have room]",
					"{C:inactive,s:0.8,f:5}OK! OK! 他人を助けるなら、大歓迎"
				}
			},
			c_synthb_spectral_training = {
				name = "Training",
				text = {
					"Levels up Selected Character"
				}
			}
		},
		Tuning = {
			c_synthb_tuning_pitch_bend = {
				name = "Pitch Bend",
				text = {
					"Set the rank of the {C:attention}2nd",
					"of {C:attention}#1#{} selected cards",
					"to the {C:attention}average{} of the other cards"
				}
			},
			c_synthb_tuning_velocity = {
				name = "Velocity",
				text = {
					"Multiply almost all",
					"stats on a random card",
					"held in hand by {X:attention,C:white}X#1#"
				}
			},
			c_synthb_tuning_attack = {
				name = "Attack",
				text = {
					"{C:attention}#1#{} selected cards",
					"will permanently",
					"gain {C:mult}+#2#{} Mult",
					"the next {C:attention}#3#{} times they score"
				}
			},
			c_synthb_tuning_decay = {
				name = "Decay",
				text = {
					"{C:attention}#1#{} selected cards",
					"permanently gain {C:chips}+#2#{} Chips",
					"but lose {C:chips}+#3#{} Chips",
					"the next {C:attention}#4#{} times they score"
				}
			},
			c_synthb_tuning_gender = {
				name = "Gender",
				text = {
					"Change the {C:attention}Rank",
					"of {C:attention}#1#{} selected cards",
					"Odd cards {C:attention}increase{} their rank",
					"Even cards {C:attention}decrease{} their rank",
					"Kings and Jacks {C:attention}become{} Queens",
					"Queens {C:attention}become{} Kings or Jacks"
				}
			},
			c_synthb_tuning_portamento = {
				name = "Portamento",
				text = {
					"Select {C:attention}#1#{} cards.",
					"Move all modifications from",
					"the {C:attention}first{} selected card",
					"onto the {C:attention}second"
				}
			},
			c_synthb_tuning_lowpass = {
				name = "Lowpass",
				text = {
					"Convert all {C:attention}#1#'s{} or higher",
					"in hand to a random rank below {C:attention}#1#"
				}
			},
			c_synthb_tuning_normalize = {
				name = "Normalize",
				text = {
					"Convert {C:attention}#1#",
					"selected cards into",
					"{C:attention}#2#{} of {V:1}#3#"
				}
			},
			c_synthb_tuning_vibrato = {
				name = "Vibrato",
				text = {
					"{C:attention}#1#{} selected",
					"cards permanently gain between",
					"{C:chips}-#3#{} and {C:chips}#2#{} Chips"
				}
			},
			c_synthb_tuning_modulation = {
				name = "Modulation",
				text = {
					"{C:attention}#1#{} selected",
					"cards permanently gain between",
					"{C:mult}-#3#{} and {C:mult}#2#{} Mult"
				}
			},
			c_synthb_tuning_direct = {
				name = "Direct",
				text = {
					"Remove all modifications",
					"from up to {C:attention}#1#{} selected",
					"cards and create a",
					"{C:dark_edition}Negative{} Joker or Consumable",
					"for every {C:attention}#1#{} modifications removed"
				}
			},
			c_synthb_tuning_tone_shift = {
				name = "Tone Shift",
				text = {
					"Cycle the {C:attention}Suit{}",
					"of {C:attention}#1#{} selected cards",
				}
			}
		},
		misTuning = {
			c_synthb_mistuning_pitch_bend = {
				name = "ch BendPit",
				text = {
					"Set the {E:bd_glitching,C:attention}rank{} of each",
					"card held in hand",
					"to the {C:attention}average{} of the other {E:bd_glitching}cards"
				}
			},
			c_synthb_mistuning_velocity = {
				name = "ocityVel",
				text = {
					"{E:bd_glitching}Multiply{} all stats",
					"on a random {E:bd_glitching,C:attention}Joker{} by {X:attention,C:white}X#1#",
					"{E:2,C:red}Cannot target the same {E:bd_glitching,C:attention}Joker{E:2,C:red} twice"
				}
			},
			c_synthb_mistuning_attack = {
				name = "ackAtt",
				text = {
					"{C:attention}#1#{} selected {E:bd_glitching}cards",
					"permanently lose {X:mult,C:white}X#2#{} Mult",
					"but gain {X:mult,C:white}X#3#{} {E:bd_glitching}Mult",
					"the next {C:attention}#4#{} {E:bd_glitching}times{} they score"
				}
			},
			c_synthb_mistuning_decay = {
				name = "ayDec",
				text = {
					"{C:attention}#1#{} selected {E:bd_glitching}cards",
					"permanently gain {X:chips,C:white}X#2#{} Chips",
					"but lose {X:chips,C:white}X#3#{} {E:bd_glitching}Chips",
					"the next {C:attention}#4#{} {E:bd_glitching}times{} they score"
				}
			},
			c_synthb_mistuning_gender = {
				name = "derGen",
				text = {
					"Each {E:bd_glitching,C:attention}card{} in hand",
					"is either destroyed",
					"or becomes a {E:bd_glitching,C:attention}queen"
				}
			},
			c_synthb_mistuning_portamento = {
				name = "tamentoPor",
				text = {
					"Distribute each {E:bd_glitching}card{}'s {E:bd_glitching,C:attention}modifications",
					"between adjacent {C:attention}cards"
				}
			},
			c_synthb_mistuning_lowpass = {
				name = "passLow",
				text = {
					"Destroy all {C:attention}#1#'s{} or {E:bd_glitching}higher",
				}
			},
			c_synthb_mistuning_normalize = {
				name = "malizeNor",
				text = {
					"Convert {C:attention}#1#",
					"{E:bd_glitching}selected cards{} into",
					"{V:1}#2#{} {C:attention}#3#s{}"
				}
			},
			c_synthb_mistuning_vibrato = {
				name = "ratoVib",
				text = {
					"{C:attention}#1#{} selected",
					"cards permanently gain between",
					"{X:chips,C:white}-X#3#{} and {X:chips,C:white}X#2#{} XChips"
				}
			},
			c_synthb_mistuning_modulation = {
				name = "ulationMod",
				text = {
					"{C:attention}#1#{} selected",
					"cards permanently gain between",
					"{X:mult,C:white}-X#3#{} and {X:mult,C:white}X#2#{} XMult"
				}
			},
			c_synthb_mistuning_direct = {
				name = "ectDir",
				text = {
					"Destroy all {E:bd_glitching,C:attention}modified{}",
					"cards in hand and create a",
					"{C:dark_edition}Negative{} Joker or Consumable",
					"for every {E:bd_glitching}card{} destroyed"
				}
			},
			c_synthb_mistuning_tone_shift = {
				name = "e ShiftTon",
				text = {
					"Randomize the {C:attention}Suit{}",
					"of {E:bd_glitching}all{} cards in {E:bd_glitching,C:attention}hand",
				}
			}
		},
		mispectral = {
			c_synthb_misspectral_voicebank = {
				name = "ankVoiceb",
				text = {
						"{E:bd_glitching,C:green}#1#{}{C:green} in {C:green}#2#{} chance to",
						"{E:bd_glitching}add a{} {C:synthb_tuning_dark}UTAU Seal{} or",
						"a {C:synthb_mistuning_dark}alUTAU Se",
						"to each {E:bd_glitching}card in{} your hand",
				}
			}
		}
	},
	misc = {
		dictionary = {
			ph_synthb_retry_now = "いますぐ輪廻 今回も結ばれないね",
			ph_synthb_shanti = "Shanti Happy Candy",
			k_tuning = "Tuning",
			b_tuning_cards = "Tuning Cards",
			k_synthb_plus_tuning = "+1 Tuning Card",
			k_mistuning = "ingTun",
			b_mistuning_cards = "ing CardsTun",
			k_synthb_plus_mistuning = "ing Card+1 Tun",
			k_synthb_plus_energy_drink = "+1 Energy Drink",
			k_synthb_plus_teto = "+1 Teto",
			k_synthb_times_singular = "time",
			k_synthb_times_plural = "times",
			k_synthb_needs_attention = "Click Me!",
			k_synthb_blackjack_win = "Win!",
			k_synthb_blackjack_lose = "Loss!",
			k_synthb_blackjack_tie = "Tie!",
			b_synthb_characters = "Greenroom",
			k_synthb_character = "Character",
			k_synthb_no_copies_ex = "No Copies!",
			b_synthb_proceed = "Proceed",
			k_synthb_spoiler_warning_ex = "Spoiler Warning!",
			k_synthb_spoiler = "Content Hidden due to Spoiler Restrictions",
			k_synthb_deltarune = "Deltarune Chapter 5",
			k_synthb_affection = "QWZmZWN0aW9u",
			k_gacha_banner_synthb_gacha_n25 = "Nightcord at 25",
			k_gacha_banner_synthb_gacha_vs = "Virtual Singers",
		},
		v_dictionary = {
			k_synthb_plus_mistuning = "ing Card#2#+#1# Tun"
		},
		labels = {
			synthb_cover_miku = "Miku Cover",
			synthb_cover_teto = "Teto Cover",
			synthb_cover_kaito = "KAITO Cover",
			synthb_cover_meiko = "MEIKO Cover",
			synthb_fake = "Fake Card",
			synthb_linked = "Linked",
			tuning = "Tuning",
			synthb_utau_seal = "UTAU Seal",
			mistuning = "ingTun",
			synthb_misutau_seal = "alUTAU Se",
		}
	}
}

for _, content in pairs(descriptions.descriptions.SongInfo) do
	content.name = "Song Info"
end

return descriptions