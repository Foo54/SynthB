--- attributes defined by this mod (or others)
--- idk if i'll use any of them but their good to have
--- 
--- RegEx for getting keys and aliases -> ('key', '"alias1", "alias2"'')
--- /^SMODS\.Attribute\{key = "([^"]+), (?:alias = \{((?:"[^"]+")(, )?)+\})?\}"/

--#region GENERAL
SMODS.Attribute{key = "debuff"}
SMODS.Attribute{key = "song"}
SMODS.Attribute{key = "vocaloid song"}


--#region CROSSMOD
SMODS.Attribute{key = "music", alias = {"song"}} -- paperback


--#region VOICEBANKS
SMODS.Attribute{key = "Teto"}
SMODS.Attribute{key = "Miku"}
SMODS.Attribute{key = "Mai"}
SMODS.Attribute{key = "Choir"}
SMODS.Attribute{key = "Rei"}


--#region ARTISTS
SMODS.Attribute{key = "ぴーなた"}
SMODS.Attribute{key = "Jamie Paige"}
SMODS.Attribute{key = "ryo"}
SMODS.Attribute{key = "Copykeys"}
SMODS.Attribute{key = "MonochroMenace"}
SMODS.Attribute{key = "Picdo"}
SMODS.Attribute{key = "Wowaka"}