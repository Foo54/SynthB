SynthB = SynthB or {}

SynthB.mod = SMODS.current_mod

SynthB.Globals = SynthB.Globals or {}
SynthB.Globals.blackjacks_to_play = 0
SynthB.Globals.blackjack = {
	buttons = {
		left_button = "Lower",
		middle_button = "Confirm",
		right_button = "Raise"
	}
}

SynthB.Credits = {
	index_to_key = {},
	list_of_people = {},
	data = {},
	Contributor = nil
}

SynthB.GUI = {}

SynthB.custom_colors = {
	LIGHT_GREEN = HEX("99e550"),
	TUNING = HEX("00FFFF"),
	TUNING_DARK = darken(HEX("00FFFF"), 0.1),
	TETO = HEX("E54C75"),
	ENERGY_DRINK = HEX("F0EC11"),
	energy_drink = {
		ORANGE = HEX("EF8A10"),
		STRAWBERRY = HEX("EC2053"),
		BANANA = HEX("E9ED1C"),
		RASPBERRY = HEX("E61A21"),
		GRAPE = HEX("E11191"),
		MELON = HEX("11DA4E"),
		TRITIP = HEX("E95C5C"),
		DURIAN = HEX("0F7917")
	},
	SIGN = HEX("BCA4CC"),
	streetcat_colours = {
		HEX("BCA4CC"),
		HEX("F8B37A"),
		HEX("724DA3"),
		HEX("FD5F66"),
		HEX("FFE669"),
		HEX("57B46C"),
		HEX("000000"),
	},
	CHARACTER = HEX("EE5F93"),
	credits = {
		foo = {
			BOOK = HEX("7779a2"),
			BOOK_2 = HEX("7678a1"),
			BOOK_3 = HEX("6a6b97"),
			TEXT = HEX("9ea1c2"),
			BUTTON = HEX("e6e6ee"),
			BUTTON_TEXT = HEX("444466"),
			OPEN_BOOK_BORDER = HEX("8b8baf"),
			OPEN_BOOK_INSIDE = HEX("c7cce0"),
			OPEN_BOOK_FURTHER_INSIDE = HEX("f2f1f7"),
			OPEN_BOOK_SPINE_OUTER = HEX("d6d6e2"),
			OPEN_BOOK_SPINE_INNER = HEX("c0bfcf"),
			OPEN_BOOK_EVEN_FURTHER_INSIDE = HEX("6e6ea4"),
			OPEN_BOOK_TAB_TOP = HEX("ebecf1"),
			OPEN_BOOK_TAB_BOTTOM = HEX("feffff"),
			OPEN_BOOK_TAB_TEXT = HEX("70708a")
		}
	},
	booster = {
		DIVA_BACKGROUND = HEX("6bdbcf"),
		DIVA_PARTICLES = HEX("f64c9d")
	},
	banners = {
		n25 = {
			BACKGROUND = HEX("DB8CE9"),
			UI = HEX("DB8CE9"),
			PARTICLES_1 = HEX("6d0ea8"),
			PARTICLES_2 = HEX("9775ad")
		},
		vs = {
			BACKGROUND = HEX("00ccbb"),
			UI = HEX("00ccbb"),
			PARTICLES_1 = HEX("2bd1c4"),
			PARTICLES_2 = HEX("50bfb6")
		},
		ln = {
			BACKGROUND = HEX("4455dd"),
			UI = HEX("4455dd"),
			PARTICLES_1 = HEX("5d6bd6"),
			PARTICLES_2 = HEX("7a83c8")
		},
		mmj = {
			BACKGROUND = HEX("88dd44"),
			UI = HEX("88dd44"),
			PARTICLES_1 = HEX("91d659"),
			PARTICLES_2 = HEX("a7cd89")
		},
		vbs = {
			BACKGROUND = HEX("ee1166"),
			UI = HEX("ee1166"),
			PARTICLES_1 = HEX("e8367a"),
			PARTICLES_2 = HEX("d65b8a")
		},
		wxs = {
			BACKGROUND = HEX("ff9900"),
			UI = HEX("ff9900"),
			PARTICLES_1 = HEX("f1ab41"),
			PARTICLES_2 = HEX("f1bd70")
		}
	}
}

SMODS.optional_features.retrigger_joker = true
SMODS.optional_features.post_trigger = true

SynthB.CHAR_W = G.CARD_W / 2
SynthB.CHAR_H = G.CARD_W / 2
SynthB.GHOST_W = G.CARD_W / 2
SynthB.GHOST_H = G.CARD_H / 2
SynthB.character_song_list = {
	"j_synthb_needle",
	"j_synthb_dna"
} -- every song
SynthB.character_major_song_list = {
	"j_synthb_needle"
} -- main songs

--- Prefaces print statements with some information, and doesn't do anything if debug is off
function SynthB.debug(...) 
	if SynthB.mod.config.DEBUG then
		print("SynthB |", ...)
	end
end

--- wrap load_file with assert
function SynthB.load_file (file_name) assert(SMODS.load_file("src/" .. file_name .. ".lua"))() end

SynthB.debug("Loading Files")

SynthB.debug("Loading Utility Files")
SynthB.load_file("util/util")
SynthB.load_file("util/songs")
SynthB.load_file("util/effect")

SynthB.debug("Loading API Files")
SynthB.load_file("api/extentions")
SynthB.load_file("api/hooks")
SynthB.load_file("api/attributes")
SynthB.load_file("api/atlas")
SynthB.load_file("api/mod_object")
SynthB.load_file("api/mod_badge")
SynthB.load_file("api/game")
SynthB.load_file("api/useable_joker")
SynthB.load_file("api/uidef")
SynthB.load_file("api/ownership")
SynthB.load_file("api/drawstep")
SynthB.load_file("api/sound")
SynthB.load_file("api/shader")
SynthB.load_file("api/smods")
SynthB.load_file("api/character")
SynthB.load_file("api/credits")

SynthB.debug("Loading Content Files")
SynthB.load_file("content/jokers/page 1")
SynthB.load_file("content/jokers/page 2")
SynthB.load_file("content/jokers/page 3")
SynthB.load_file("content/jokers/page 4")
SynthB.load_file("content/tuning/tuning")
SynthB.load_file("content/tuning/page 1")
SynthB.load_file("content/enhancement")
SynthB.load_file("content/spectral")
SynthB.load_file("content/tarot")
SynthB.load_file("content/sign")
SynthB.load_file("content/edition")
SynthB.load_file("content/booster")
--SynthB.load_file("content/back")
SynthB.load_file("content/seal")
SynthB.load_file("content/sticker")
SynthB.load_file("content/tag")

if SynthB.mod.config.experimental_features then
	SynthB.debug("Loading Character Files")
	SynthB.load_file("content/characters/virtual_singers/miku")
	SynthB.load_file("content/characters/virtual_singers/first_variation")
	SynthB.load_file("content/characters/virtual_singers/second_variation")
	SynthB.load_file("content/characters/banners")
end

SynthB.debug("Loading Credits")
SynthB.load_file("util/credits/foo")
SynthB.load_file("util/credits/pepix")

SynthB.debug("Loading Crossmod and Compatibility Files")
SynthB.load_file("compat/aikoshen")
SynthB.load_file("compat/baddirector")

SynthB.debug("Loading Crossmod Files")
-- cross mod loading modified from aikoshen
for _,mod in pairs(SMODS.Mods) do
	if mod.can_load and mod.path and not mod.meta_mod then
		pcall(function ()
			local p = SMODS.load_file("SynthB.lua", mod.id)
			if p then
				p()
			end
		end)
	end
end
