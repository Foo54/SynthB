SynthB.songs = {
	{link = "https://www.youtube.com/watch?v=V4elF7---KQ", key = "antani_itten_no"},
	{link = "https://www.youtube.com/watch?v=1U6qefKcOrg", key = "cadmium_colors", pos = {x = 1, y = 0}},
	{link = "https://www.nicovideo.jp/watch/sm3504435", key = "the_world_is_mine", pos = {x = 2, y = 0}},
	{link = "https://www.youtube.com/watch?v=GEMepvdruCo", key = "caramel_airfryer", pos = {x = 3, y = 0}},
	{link = "https://www.youtube.com/watch?v=a3owBc_MqRo", key = "regret_rock", pos = {x = 4, y = 0}},
	{link = "https://www.youtube.com/watch?v=2Pgfr75lgro", key = "burnt_toast", pos = {x = 0, y = 1}},
	{link = "https://www.youtube.com/watch?v=sqK-jh4TDXo", key = "machine_love", pos = {x = 1, y = 1}},
	{link = "https://www.nicovideo.jp/watch/sm3945173", key = "triple_baka", pos = {x = 2, y = 1}},
	{link = "https://www.youtube.com/watch?v=vnw8zURAxkU", key = "rolling_girl", pos = {x = 3, y = 1}},
	{link = "https://www.youtube.com/watch?v=ecRRxehRIDo", key = "self_destructive_girl", pos = {x = 4, y = 1}},
	{link = "https://www.youtube.com/watch?v=bY4RqgNQVuc", key = "lemonade", pos = {x = 0, y = 2}},
	{link = "https://www.youtube.com/watch?v=Soy4jGPHr3g", key = "tetoris", pos = {x = 1, y = 2}},
	{link = "https://www.youtube.com/watch?v=b56xjtP6Qac", key = "relayouter", pos = {x = 2, y = 2}},
	{link = "https://www.youtube.com/watch?v=3iUgKH8c7p4", key = "retry_now_normal", pos = {x = 3, y = 2}},
	{link = "https://www.youtube.com/watch?v=9hveQ4bsqzs", key = "fire_dance", pos = {x = 4, y = 2}},
	{link = "https://www.youtube.com/watch?v=cm-l2h6GB8Q", key = "king", pos = {x = 0, y = 3}},
	{link = "https://www.youtube.com/watch?v=0iVlSNpq8i8", key = "birdbrain", pos = {x = 1, y = 3}},
	{link = "https://www.youtube.com/watch?v=UsjsYMo3O1Q", key = "brainrot", pos = {x = 2, y = 3}},
	{link = "https://www.youtube.com/watch?v=s742C0v5SFI", key = "shrimp_fried_rice", pos = {x = 3, y = 3}},
	{link = "https://www.youtube.com/watch?v=JZaFgVQwXmA", key = "disclose_flick", pos = {x = 4, y = 3}},
	{link = "https://www.youtube.com/watch?v=Q_QEPrkwZ-Q", key = "copycat", pos = {x = 0, y = 4}},
	{link = "https://www.youtube.com/watch?v=2b1IexhKPz4", key = "kyu_kurarin", pos = {x = 1, y = 4}},
	{link = "https://www.youtube.com/watch?v=F38EuG2dAyM", key = "medicine", pos = {x = 2, y = 4}},
	{link = "https://www.youtube.com/watch?v=VZJRmKSZIfY&t=978s", key = "internet_is_mine", pos = {x = 3, y = 4}},
	{link = "https://www.youtube.com/watch?v=HwXaamu58Ao&t=665", key = "glass_girl", pos = {x = 4, y = 4}},
	{link = "https://www.youtube.com/watch?v=kbNdx0yqbZE", key = "monitoring", pos = {x = 0, y = 5}},
	{link = "https://www.youtube.com/watch?v=Om3MTou2kPg", key = "six_trillion", pos = {x = 1, y = 5}},
	{link = "https://www.youtube.com/watch?v=NocXEwsJGOQ", key = "miku", pos = {x = 2, y = 5}},
	{link = "https://www.youtube.com/watch?v=HOz-9FzIDf0", key = "matryoshka", pos = {x = 3, y = 5}},
	{link = "https://www.youtube.com/watch?v=STBoCK69vVQ", key = "spot_late", pos = {x = 4, y = 5}},
	{link = "https://www.youtube.com/watch?v=b2NTglk9tvI", key = "heat_abnormal", pos = {x = 0, y = 6}},
}

SynthB.key_songs = {}
for _, song in ipairs(SynthB.songs) do
	SynthB.key_songs[song.key] = song
end

function G.FUNCS.go_to_song(e)
	love.system.openURL(e.config.ref_table.link)
end

function SynthB.generate_song_button(key, index, prefix)
	-- adjust fixed scale and necessary to ensure all buttons are of uniform size
	local out = {n = G.UIT.C, config = {align = "tm", minw = 4.6, minh = 4.6, r = 0.1, padding = 0.2, emboss = 0.1, colour = HEX('5865F2'), shadow = true, scale = 0.6, button = "go_to_song", ref_table = SynthB.songs[index]}, nodes = localize{type = "name", set = "Joker", key = (prefix or "j_synthb_") .. key, fixed_scale = 0.67}}
---@diagnostic disable-next-line: param-type-mismatch
	table.insert(out.nodes, 1, {n = G.UIT.R, config = {align = "cm"}, nodes = {
		{n = G.UIT.O, config = {object = SMODS.create_sprite(0, 0, 3.5, 3.5, "synthb_covers", SynthB.songs[index].pos or {x = 0, y = 0})}}
	}})
	return out
end