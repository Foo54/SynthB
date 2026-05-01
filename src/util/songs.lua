SynthB.songs = {
	antani_itten_no = {link = "https://www.youtube.com/watch?v=V4elF7---KQ"},
	cadmium_colors = {link = "https://www.youtube.com/watch?v=1U6qefKcOrg"},
	the_world_is_mine = {link = "https://www.nicovideo.jp/watch/sm3504435"},
	caramel_airfryer = {link = "https://www.youtube.com/watch?v=GEMepvdruCo"},
	regret_rock = {link = "https://www.youtube.com/watch?v=a3owBc_MqRo"},
	burnt_toast = {link = "https://www.youtube.com/watch?v=2Pgfr75lgro"},
	machine_love = {link = "https://www.youtube.com/watch?v=sqK-jh4TDXo"},
	triple_baka = {link = "https://www.nicovideo.jp/watch/sm3945173"},
	rolling_girl = {link = "https://www.youtube.com/watch?v=vnw8zURAxkU"},
	self_destructive_girl = {link = "https://www.youtube.com/watch?v=ecRRxehRIDo"},
	lemonade = {link = "https://www.youtube.com/watch?v=bY4RqgNQVuc"},
	tetoris = {link = "https://www.youtube.com/watch?v=Soy4jGPHr3g"},
	relayouter = {link = "https://www.youtube.com/watch?v=b56xjtP6Qac"},
	retry_now = {link = "https://www.youtube.com/watch?v=3iUgKH8c7p4", key = "retry_now_normal"},
	fire_dance = {link = "https://www.youtube.com/watch?v=9hveQ4bsqzs"},
	king = {link = "https://www.youtube.com/watch?v=cm-l2h6GB8Q"},
	birdbrain = {link = "https://www.youtube.com/watch?v=0iVlSNpq8i8"},
	brainrot = {link = "https://www.youtube.com/watch?v=UsjsYMo3O1Q"},
	shrimp_fried_rice = {link = "https://www.youtube.com/watch?v=s742C0v5SFI"},
	disclose_flick = {link = "https://www.youtube.com/watch?v=JZaFgVQwXmA&pp=0gcJCd4KAYcqIYzv"},
	copycat = {link = "https://www.youtube.com/watch?v=Q_QEPrkwZ-Q"},
	kyu_kurarin = {link = "https://www.youtube.com/watch?v=2b1IexhKPz4"},
	medicine = {link = "https://www.youtube.com/watch?v=F38EuG2dAyM"},
	internet_is_mine = {link = "https://www.youtube.com/watch?v=VZJRmKSZIfY&t=978s"},
	glass_girl = {link = "https://youtu.be/HwXaamu58Ao?t=665"}
}

function G.FUNCS.go_to_song(e)
	love.system.openURL(e.config.ref_table.link)
end

function SynthB.generate_song_button(key, prefix)
	return {n = G.UIT.R, config = {align = "tm", minw = 8, r = 0.1, padding = 0.2, emboss = 0.1, colour = HEX('5865F2'), shadow = true, button = "go_to_song", ref_table = SynthB.songs[key]}, nodes = localize{type = "name", set = "Joker", key = (prefix or "j_synthb_") .. (SynthB.songs[key].key or key)}}
end