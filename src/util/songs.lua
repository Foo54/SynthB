SynthB.songs = {
	{link = "https://www.youtube.com/watch?v=V4elF7---KQ", key = "antani_itten_no"},
	{link = "https://www.youtube.com/watch?v=1U6qefKcOrg", key = "cadmium_colors"},
	{link = "https://www.nicovideo.jp/watch/sm3504435", key = "the_world_is_mine"},
	{link = "https://www.youtube.com/watch?v=GEMepvdruCo", key = "caramel_airfryer"},
	{link = "https://www.youtube.com/watch?v=a3owBc_MqRo", key = "regret_rock"},
	{link = "https://www.youtube.com/watch?v=2Pgfr75lgro", key = "burnt_toast"},
	{link = "https://www.youtube.com/watch?v=sqK-jh4TDXo", key = "machine_love"},
	{link = "https://www.nicovideo.jp/watch/sm3945173", key = "triple_baka"},
	{link = "https://www.youtube.com/watch?v=vnw8zURAxkU", key = "rolling_girl"},
	{link = "https://www.youtube.com/watch?v=ecRRxehRIDo", key = "self_destructive_girl"},
	{link = "https://www.youtube.com/watch?v=bY4RqgNQVuc", key = "lemonade"},
	{link = "https://www.youtube.com/watch?v=Soy4jGPHr3g", key = "tetoris"},
	{link = "https://www.youtube.com/watch?v=b56xjtP6Qac", key = "relayouter"},
	{link = "https://www.youtube.com/watch?v=3iUgKH8c7p4", key = "retry_now_normal"},
	{link = "https://www.youtube.com/watch?v=9hveQ4bsqzs", key = "fire_dance"},
	{link = "https://www.youtube.com/watch?v=cm-l2h6GB8Q", key = "king"},
	{link = "https://www.youtube.com/watch?v=0iVlSNpq8i8", key = "birdbrain"},
	{link = "https://www.youtube.com/watch?v=UsjsYMo3O1Q", key = "brainrot"},
	{link = "https://www.youtube.com/watch?v=s742C0v5SFI", key = "shrimp_fried_rice"},
	{link = "https://www.youtube.com/watch?v=JZaFgVQwXmA", key = "disclose_flick"},
	{link = "https://www.youtube.com/watch?v=Q_QEPrkwZ-Q", key = "copycat"},
	{link = "https://www.youtube.com/watch?v=2b1IexhKPz4", key = "kyu_kurarin"},
	{link = "https://www.youtube.com/watch?v=F38EuG2dAyM", key = "medicine"},
	{link = "https://www.youtube.com/watch?v=VZJRmKSZIfY&t=978s", key = "internet_is_mine"},
	{link = "https://www.youtube.com/watch?v=HwXaamu58Ao&t=665", key = "glass_girl"}
}

function G.FUNCS.go_to_song(e)
	love.system.openURL(e.config.ref_table.link)
end

function SynthB.generate_song_button(key, prefix)
	return {n = G.UIT.R, config = {align = "tm", minw = 8, r = 0.1, padding = 0.2, emboss = 0.1, colour = HEX('5865F2'), shadow = true, button = "go_to_song", ref_table = SynthB.songs[key]}, nodes = localize{type = "name", set = "Joker", key = (prefix or "j_synthb_") .. key}}
end